## Method

<br>

### Method란?
- ##### 주어진 타입의 인스턴스에 작업을 위한 특정 작업이나 기능을 캡슐화 한다.
- ##### 클래스, 구조체, 열거형에 속하는 함수이다.
- ##### 메소드는 특정 타입과 연관된 특정 작업을 수행하기 위한 독립적인 코드 집합이다.
- ##### 클래스, 구조체 및 열거형은 특정 작업이나 기능을 캡슐화한 인스턴스 메소드와 타입 자체와 관련된 타입 메소드를 정의할 수 있다.

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
    override static func someTypeMethod(){

    }
}
```

<br>

#### 참고자료
- ###### http://minsone.github.io/mac/ios/swift-methods-summary
- ###### https://zeddios.tistory.com/258
- ###### https://hodev.tistory.com/111
- ###### https://jeonyeohun.tistory.com/72

