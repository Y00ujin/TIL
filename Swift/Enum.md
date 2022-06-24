# Enum

### Enum?
- ##### “열거”타입은 `임의의 관계를 맺는 값`들을 `하나의 타입으로 묶어서` 타입-안전한 방식으로 다룰 수 있게 해준다.
- ##### `유사한 종류의 여러값`을 유의미한 이름으로 `한곳에 모아 정의한 것`

<br>

### Enum 구현법?
```Swift
enum Animal {
    case tiger
    case leopard
    case lion
}

    // 두개는 같은 것, Animal이라고 명시했으므로 Animal.tiger로 접근하지않고 바로 .lion으로 접근해도 돼!
    let tiger2: Animal = Animal.tiger
    let lion2: Animal = .lion

    // case 이름 그 자체로 값을 가짐
    print(tiger2) // tiger
    print(lion2) // lion
```

<br>

### Enum + 원시값(Raw Values)?
###### 열거형의 case는 모두 독립적인 값이지만 내부에 또 다른 값을 저장할 수 있다. 이를 원시값(raw value)라고 한다. 열거형을 정의할 때 원시값 저장은 필수사항이 아닙니다.
###### 원시값 타입으로 올 수 있는 것은 Stirng, Character, NumberType 으로 제한된다.
###### 선언시점에 저장한 원시값은 나중에 바꿀 수 없다.
###### 먼저 열거형 이름뒤에 원시값의 타입을 지정합니다. 
```Swift
enum Name: Int { // Int로 원시값의 타입을 지정했다.
    case caseName = value
}
```

- ##### 1.Raw Value 지정하기
> ###### 1-1. Number Type으로 원시값 주기
###### 원시값의 타입을 Int로 지정하고 원시값 할당을 생략하면 0부터 1씩 증가하며 차례대로 할당됩니다.
```Swift
enum CaompassPoint: Int{
    case north
    case south
    case east
    case west
}

CompassPoint.north.rawValue // 0
CompassPoint.south.rawValue // 1
CompassPoint.east.rawValue // 2
CompassPoint.west.rawValue // 3
```
###### 원시값을 직접 할당하면 각각 어떤 값이 저장될까?
```Swift
enum CompassPoint: Int {
    case north
    case south
    case east = 100
    case west
}
```

###### 증가될 때의 기준값은 이전 case이므로 100에서 1증가한 101이 .west에 저장된다.

```Swift
CompassPoint.north.rawValue // 0
CompassPoint.south.rawValue // 1
CompassPoint.east.rawValue // 100
CompassPoint.west.rawValue // 101
```

###### raw value의 타입을 Double, Float로 지정할 경우 모든 case에 대해 값을 지정해주지 않으면 에러가 발생한다.
```Swift
enum Position: Double{
    case top = 1.0
    case mid = 2.0
    case jug = 3.0
    case adc = 4.0
    case sup // error
}
```
###### 그 이유는 Number Type의 Raw Value는 만약 값이 없으면, 바로 이전 case의 Raw Value의 값에서 1이란 정수값을 더한 값을 가지는데 sup의 Raw Value를 컴파일러가 지정해야하는데 adc의 Raw Value가 실수값이기 때문에 1을 더하지 못한다고 오류가 나는 것
###### 따라서 Int가 아닌 Number 자료형을 사용할 경우, Raw Value를 생략하고 싶다면, 바로 이전 case의 Raw Value를 정수 값으로 지정해줘야함
```Swift
enum Position: Double{
    case top = 1.0  // 1.0
    case mid = 2.0  // 2.0
    case jug = 3.0  // 3.0
    case adc = 4    // 4.0
    // 이전 값을 정수값으로 지정해도 Double형으로 형변환 되어 들어간다.
    case sup        // 5.0
}
```

<br>

> ###### 1-2. Character Type으로 원시값 주기
###### Character Type으로 열거형을 선언할 경우 모든 case에 대한 Raw Value를 직접 지정해줘야한다.
```Swift
enum Position: Character{
    case top = "t"
    case mid = "m"
    case jug = "j"
    case adc = "a"
    case sup = "s"
}
```

###### 하나라도 지정해주지 않으면 아까 Double에서 에러난 것과 비슷한 에러가 발생한다.
###### 컴파일러가 지정되지 않은 Raw Value에 이전 case Raw Value에 1을 더한 값을 저장해야하는데 이전 case의 Raw Value가 정수형이 아니라서 +1을 못한다고 에러를 발생시키는 것이다.
<br>

> ###### 1-3. String Type을 가지는 열거형
###### String은 Character와 달리 Raw Value를 지정하지 않으면 case 이름과 동일한 Raw Value가 자동으로 만들어진다.
```Swift
enum Position: String{
    case top            // top
    case mid            // mid
    case jug = "slave"  // slave
    case adc            // adc
    case sup            // sup
}
```

<br>

- ##### 2. Raw Value에 접근하기
```Swift
var user1: Position = .top // top
var user2: Position = .mid // mid
var user3: Position = .jug // jug

user1.rawValue // "top"
user2.rawValue // "mid"
user3.rawValue // "jug"
```

<br>

### Raw Value로 열거형 생성하기
###### 없는 Raw Value일 경우 nil을 리턴한다.
```Swift
var user1 = PositionWithRawValue.init(rawValue: "sup") // sup
var user2 = PositionWithRawValue.init(rawValue: "supp") // nil
```


<br>

### Enum + Optional?
```Swift

enum Animal : Int {
    case tiger = 0
    case leopard
    case lion
}

print(Animal(rawValue: 4)) // 원시값이 4인 case 출력인데 원시값이 4인 case가 없다..! 
// 고로 전달한 원시값에 해당하는 케이스가 없을 수 있기 때문에 원시값을 통한 인스턴스 생성은 옵셔널값으로 반환된다.

// 결과적으로 nil이 출력되게 된다.
```

<br>

### Enum + 연관값?
###### Raw Value를 사용할 경우 모든 case가 동일한 형식으로 Raw Value를 가져야 하고, case 별 값은 미리 지정된 한 가지 값만 가질 수 있다.
###### 이러한 단점을 보완하여 사용할 수 있는 것이 연관값(associated vaue)이다.

- ##### 연간괎을 가진 열거형 선언하기
###### case 옆에 튜플 형태로 원하는 Type을 명시하면 된다.
###### 이때 튜플은 Named Tuple도 되고, Unnamed Tuple도 가능하다.
```Swift
enum TypeName{
    case caseName(Type)
    case caseName(Type, Type, ...)
}

enum AppleDevice {
    case iPhone(model: String, storage: Int) // named tuple
    case iMac(size: Int, model: String, price: Int)
    case macBook(String, Int, Int) // unnamed tuple
}
```

- ##### 연관값을 가지는 열거형 생성 방법
###### 열거형 생성 시 연관값을 함께 전달한다.
```Swift
let product: AppleProduct = .iPad(model: "ipad")
let product2: AppleProduct = .iPhone(model: "6", storage: "storage")
```

<br>

### 열거형 + 프로토콜
###### Class, struct와 마찬가지로 Enum에서도 프로토콜을 채택할 수 있다.
###### 해당 프로토콜에 지정된 allClases또한 사용할 수 있다.
```Swift
enum Apple Product: String, CaseIterable{
    case iPad = "2"
    case iPhone = "2"
    case macbook = "Pro"
}

AppleProduct.allClases.randomElement()
```

#### 참고자료
- ###### https://zeddios.tistory.com/12
- ###### https://soooprmx.com/enum/