## Method

<br>

### Method란?
- ##### 주어진 타입의 인스턴스에 작업을 위한 특정 작업이나 기능을 캡슐화 한다.
- ##### 클래스, 구조체, 열거형에 속하는 함수이다.
- ##### 메소드는 특정 타입과 연관된 특정 작업을 수행하기 위한 독립적인 코드 집합이다.
- ##### 클래스, 구조체 및 열거형은 특정 작업이나 기능을 캡슐화한 인스턴스 메소드와 타입 자체와 관련된 타입 메소드를 정의할 수 있다.

<br>

### 메소드를 위한 지역 및 외부 인자 이름 (Local and External Parameter Names for Methods)
- ##### 함수 인자는 함수 내부에서 사용할 지역 이름(`parameter name`)과 함수를 호출할 때 사용할 외부 이름(`argument label`)을 가질 수 있다.
```Swift
// parameter name : operand1, opeand2
// argument label: first, second
func add(first operand1: Int, second operand2: Int) -> Int{
    return operand1 + operand2
}

print(add(first: 1, second: 2)) // 3
```

<br>

### 외부 이름 숨기기(Modifying External Parameter Name behavior for Methods)
- ###### 외부 이름을 없애고싶으면 `_`를 사용하자
```Swift
class Counter {
    var allPrice: Int = 0
    func incrementBy(count: Int, _ price: Int) {
        allPrice = count * price
    }
}

let myCounter = Counter()
myCounter.incrementBy(count: 2, 2000) // 외부 이름없이 인자를 넘길 수 있다.
```

<br>

### Instance Methods
- ##### 인스턴스 메서드는 객체 타입이 만들어내는 인스턴스에 소속된 함수
- ##### 객체의 인스턴스에 대한 기능적 측면을 제공한다.
- ##### 인스턴스 메서드는 객체 타입 내부에 선언된다는 점을 제외하면 일반 함수와 선언하는 형식이 동일하다.
- ##### 인스턴스 생성없이 독립적으로 호출할 수는 없다.
- ##### 인스턴스 속성에 접근하고 수정하는 방법 또는 인스턴스 목적에 맞는 기능을 제공한다.
```Swift
class Counter{
    var count = 0
    func increment(){
        self.count += 1
    }
}
```

- ##### 인스턴스 메서드는 속성처럼 점 문법으로 호출한다
```Swift
let counter = Counter()
counter.increment()
```

<br>

### Modifying Value Types from Within Instance Methods 
###### 인스턴스(instance) 메서드에서 값 유형 수정

- ##### 구조체와 열거형은 값 타입입니다.
- ##### 기본적으로 Value Type의 프로퍼티들은 해당 인스턴스 메소드 내에서 수정할 수 없습니다.
- ##### 그러나 특정 메소드 내에서 구조체 또는 열거형의 프로퍼티를 수정해야하는 경우, 해당 메소드의 동작을 변경(mutating)하도록 선택 할 수 있습니다.

> ##### 아래 코드는 틀렸다.. Value Type은 기본적으로 인스턴스 메소드 안에서 프로퍼티를 변경할 수 없기때문이다!
```Swift
struct Point{
    var x = 0.0, y = 0.0

    func moveBy(x deltaX: Double, y deltaY: Double){
        x += deltaX // 인스턴스 메소드에서 프로퍼티를 변경하고있다.
        y += deltaY
    }
}

var somePoint point(x: 1.0, y:1.0)
somePoint.moveBy(x: 2.0, y:3.0)
```

- ##### 그럼 Value Type의 인스턴스 메소드 안에서 프로퍼티를 변경해야한다면 mutating키워드를 사용하자 
```Swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX // 인스턴스 메소드에서 프로퍼티를 변경하고있다.
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
```

<br>

### Assigning to self Within a Mutatig Method
###### Mutatig 메서드 내에서 자신에게 할당

- ##### mutating 메서드는 self 프로퍼티를 이용해서 자기자신을 완전히 새로운 인스턴스로 변경할 수도 있다.
- #####
```Swift
struct Point{
    var x = 0.0, y = 0.0

    mutating func moveBy(X deltaX: Double, y deltaY: Double){
        self = Point(x: x+deltaX, y: y+deltaY)
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
```

- ##### 열거형에서도 self를 switch의 파라미터로 사용해서 로직을 만들 수 있다.
```Swift
enum TriStateSwitch{
    case off, low, high

    mutating func next(){
        switch self{
            case .off:
            self = .low
            case .low:
            self = .high
            case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next() // .high
ovenLight.next() // .off
```

<br>

### The self Property
- ##### 모튼 타입의 인스턴스는 암묵적으로 self 프로퍼티를 가진다.
- ##### 하지만 self는 명시적으로 작성하지않아도 된다. 인스턴스가 같은 메서드의 파라미터로 인스턴스 내에 존재하는 프로퍼티와 같은 이름을 가진 값을 받을 때 사용한다. 

```Swift
stuct Point{
    var x = 0.0, y = 0.0
    func isToTheRightOf(x:Double) -> Bool{
        return self.x>x
    }
}

let somePoint = Point(x: 4.0, y:5.0)
if somePoint.isToTheRightOf(x:1.0){
    print("This point is to the right of the line where x == 1.0")
}
```

<br>

### Type Methods
- ##### 타입 자체에서 호출되는 메소드
- ##### 타입 메서드는 타입에서 정의되는 메서드로 static 키워드를 func키워드 앞에 붙이는 것으로 작성한다.
- ##### 타입 메서드는 인스턴스를 생성하지 않아도 타입 자체에서 호출이 가능하다.

> ###### func 앞에 static or class가 붙으면 타입 메소드!
```Swift
class SomeClass{
    static func otherTypeMethod(){

    }

    class func someTypeMethod(){

    }
}

// SomeClass의 인스턴스를 생성하지않고도, 바로 타입을 통해 메소드를 호출한다.
SomeClass.someTypeMethod() 
Someclass.otherTypeMethod()
```

> ###### Class라는 키워드가 붙으면 해당 클래스를 상속받는 자식클래스가 해당 타입 메소드를 재정의할 수 있다! -> Class someTypeMethod를 재정의할 수 있다.
```Swift
class youjin: SomeClass{
    // SomeClass에서 someTypeMethod를 class 키워드를 사용하여 선언했기 때문에 SomeClass를 상속받는 자식클래스 즉 youjin 클래스에서 someTypeMethod를 재정의 할 수 있다.
    override static func someTypeMethod(){ }
}
```

<br>

### Method와 in-to, in-out 파라미터
- ##### 함수의 파라미터는 기본적으로 상수(Constant)이다.
###### 따라서 아래와 같이 함수 내에서 파라미터를 변경하려고 시도하면 컴파일 에러가 발생한다. 상수를 변경하려고 시도했기 때문이다.
```Swift
funt add(num: Int){
    num += 1
    print(num)
}
```
###### 함수의 파라미터를 함수 내부에서 변경하고 함수가 종료된 후에도 변경한 값이 지속되도록 하려면 변수의 주소값을 넘겨 직접 접근할 수 있도록 도와주는 inout 키워드를 사용하면 된다.

###### inout 키워드를 사용하여 파라미터로 들어온 값을 1증가시키고 출력하는 코드이다. 
###### 파라미터와 데이터 타입 사이에 inout키워드를 작성하고, 함수를 호출할 때 변수 명 앞에 앰퍼샌드(&) 기호를 붙여 사용한다.
```Swift
var number = 10
 
func addOne(value: inout Int){
    value += 1
    print(value)
}
 
addOne(value: &number)
```
#### 참고자료
- ###### https://2018-start.tistory.com/92
- ###### http://minsone.github.io/mac/ios/swift-methods-summary
- ###### https://zeddios.tistory.com/258
- ###### https://hodev.tistory.com/111
- ###### https://jeonyeohun.tistory.com/72
- ###### http://minsone.github.io/mac/ios/swift-methods-summary
- ###### https://sujinnaljin.medium.com/objective-c-%ED%95%A8%EC%88%98%EC%9D%98-%EC%B2%AB%EB%B2%88%EC%A7%B8-%EC%9D%B8%EC%9E%90-%EC%9D%B4%EB%A6%84-%EC%A7%80%EC%A0%95%ED%95%98%EA%B8%B0-863aae7a3533
