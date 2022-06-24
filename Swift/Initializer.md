## Initializer

<br>

### Initializer란?
- ##### 클래스, 구조체, 열거형 인스턴스를 사용하기 위한 준비 작업이다.
- ##### 저장 프로퍼티의 초기 값을 설정합니다.
- ##### 초기화 작업이 완료되면 메모리에 인스턴스가 생성된다.
- ##### 초기화를 하는 방법에는 init()을 사용하는것, 저장 프로퍼티에 초기값을 저장하는 것 두가지가 있다.

<br>

### Initializer의 역할( 이니셜라이저의 대(BIG...!!)원칙 )
- ##### 스위프트는 에러에 대한 안전을 최우선시 한다.
- ##### 빈 메모리에 접근하게 된다면 예기치 못한 에러가 발생할 수 있다.
- ##### 타입 내부에 프로퍼티가 있다면 해당 프로퍼티에는 무조건 값이 있다는 것을 보장해야 한다.

<br>

### 초기화 하는 법
#### 1. 기본 값을 지정하여 초기화 하기
- ##### 프로퍼티의 `선언과 동시에 값을 할당`하면 그 값을 초기 값으로 사용할 수 있다.
- ##### `항상 같은 초기 값을 가진다면` 프로퍼티 선언과 동시에 초기 값을 할당하는 게 좋다.

#### 2. 이니셜라이저를 사용하여 초기화하기
- ##### init()을 사용하여 초기화한다.
- ##### init()의 가장 기본적인 형태는 매개변수가 없는 형태이다.
```Swift
init(){
    // 이 곳에서 프로퍼티 초기화를 구현한다.
}
```

<br>

- ##### 이니셜라이저는 메소드와 달리 괄호 앞에 식별할 수 있는 이름을 가지지 않기 때문에 매개 변수명 및 타입이 이니셜라이저를 식별하는 데 중요한 역할을 한다.
```Swift
Struct Sample{
    // 옵셔널 타입 프로퍼티는 초기값이 없어도 되고, 나중에 추가도 가능하다. 초기값이 없는 경우에는 자동으로 nil로 초기화가 된다.
    var weight: Double? 

    let footSize: Int

    // 외부이름과 내부이름을 준 경우
    init(tall height: Double){...}
    // 인자명을 지정하지 않으면 내부 이름과 동일한 외부 이름을 가진다.
    init(weight: Double) {...}
    // 인자명을 생략하고 싶다면 '_'(와일드 카드)를 사용하면 된다.
    init(_ footSize: Int) {...}

    // 이니셜라이저는 상수 프로퍼티에 값을 할당하는 것도 가능하다.
    init(footSize: Int){
        self.footSize = footSize
    }

    let Sample1 = Sample(tall: 180.0)
    let Sample2 = Sample(weight: 79.8)
    let Sample3 = Sample(270)
}
```

<br>

- ##### 실패 가능한 이니셜라이저 사용하기 (init?())
> ###### 초기화 과정 중에 실패할 가능성이 있는 init, 반환 값으로 옵셔널 값을 생성, 초기화 실패 시 nil을 반환
###### 앞에서 말했듯이 이니셜라이저는 매개변수명과 타입으로 구분하기 때문에 init?()과 init()의 형태가 다르다고 해서 같은 매개변수 타입과 이름을 사용할 수 없다.

```Swift
struct Animal{
    let species: String
    init?(species: String){
        if species.isEmpty {return nil} // nil 반환 시 return 사용
        self.species = species
    }
}

class Athlete{
    var name: String
    
    init?(name: String){
        self.name = name
        if name == ""{ // 인자값이 ""이면 인스턴스 객체가 만들어지지 않도록 하고 있음
            return nil
        }
    }
}
```

<br>

- ##### 이니셜라이저 위임(Initializer Delegation)
> ###### 이니셜라이저는 인스턴스 초기화의 일부를 수행하기 위해 다른 이니셜라이저를 호출할 수 있다. 코드 중복 예방 가능
```Swift
class Man{
    var age: Int
    var weight: Double
    func display(){
        print("\(age), \(weight)")
    }

    init(age: Int, weight: Double){
        self.age = age
        self.weight = weight
    } // designated initializer

    convenience init(age: Int){
        self.init(age: age, weight: 3.5) // initializer delegation
    } // convenience initializer
}

var kim: Man = Man(age: 10, weight: 20)
kim.display()
var lee: Man = Man(age: 1)
lee.display()
```

- ##### 구조체의 이니셜라이저
###### 구조체는 기본적으로 제공되는 이니셜라이저가 2개 있다.
> ###### 1. memberwise initializer
###### 프로퍼티를 매개 변수로 가지는 이니셜라이저
###### 구조체 내에서 프로퍼티가 하나라도 초기화되지 않은 경우, 초기값이 없는 속성을 매개 변수로 갖는 memberwise initializer가 제공된다.
###### 다만 속성이 모두 let으로 초기화 되어 있는 경우 멤버와이즈 이니셜라이저는 제공되지 않는다.
> ###### 2. default initializer
###### 프로퍼티가 모두 초기화 되어 있는 경우 매개 변수가 없는 이니셜라이저(기본 이니셜라이저)도 제공된다.
```Swift
struct Sample {
    let speciesString: String
    let speciesInt: Int = 0
    let speciesBool: Bool = true

}
let sample = Sample(speciesString: “하하”) // 멤버와이즈 이니셜라이저

struct Sample {
    var species: String = "하하"

}
let sample = Sample() // 기본 이니셜라이저
let sample2 = Sample(species: "호호") // 멤버와이즈 이니셜라이저
                     
struct Sample {
    let species: String = "하하"

}
let sample = Sample()
let sample2 = Sample(species: "호호") // 오류: let으로 선언되었기 때문에 값 변경 불가
```
> ###### 3. 사용자 이니셜라이저와 멤버와이즈 이니셜라이저 둘 다 사용하는 법
###### 값 타입을 위한 사용자 이니셜라이저를 정의하면 기본 이니셜라이저 또는 멤버와이즈 이니셜라이저에 접근할 수 없다.
###### 이러한 제약을 주는 이유는 이니셜라이저의 복잡성을 낮추고 이니셜라이저가 의도치 않게 사용되는 것을 방지하기 위함이다.
###### 사용자 지정 이니셜라이저를 사용하면서 기본 또는 멤버와이즈 이니셜라이저도 사용하고 싶다면, 사용자 지정 이니셜라이저를 원래의 값 타입에 구현하지 않고, 익스텐션에 구현을 하면 된다.
```Swift
struct Sample {
    var name: String
    var number: Int

    init(anotherNumber: Int) { // 사용자 지정 이니셜라이저 구현
        self.name = "SK"
        self.number = anotherNumber
    }
}
// 오류: 사용자가 구조체 내부에 이니셜라이저를 구현하였기 때문에 멤버와이즈 이니셜라이저는 사용할 수 없다.
// 멤버와이즈 이니셜라이저 사용 불가능
let aiden = Sample(name: "Aiden", number: 1)
// 사용자 지정 이니셜라이저 사용
let sk = Sample(anotherNumber: 2) // Sample(name: "SK", number: 2)
//================================================================
struct Sample {
    var name: String
    var number: Int
}
extension Sample {
    init(anotherNumber: Int) { // init은 매개 변수의 이름으로 식별하기 때문에 이름이나 타입을 다르게 해줘야한다.
        self.name = "SK"
        self.number = anotherNumber
    }
}
// 멤버와이즈 이니셜라이저 사용
let aiden = Sample(name: "Aiden", number: 1) // Sample(name: "SK", number: 1)
// 사용자 지정 이니셜라이저 사용
let sk = Sample(anotherNumber: 2) // Sample(name: "SK", number: 2)

```

<br>

- ##### 열거형의 이니셜라이저
###### 열거형의 case들을 초기화해주는 것은 가능하지만 rawValue는 변할 수 없는 값이기 때문에 초기화 해줄 수 없다.
```Swift
enum PowerRanger: String{
    case red
    case blue = "블루"
    case black

    init(call: Character){
        switch call{
            case "r": self = .red
            case "b": self = .blue
            default: self = .black
        }
    }
}

let callToDoctor = PowerRange(call: "r") // red
```

<br>

- ##### 클래스의 이니셜라이저
###### 상속받은 모든 프로퍼티를 포함하여 모든 클래스의 저장 프로퍼티는 초기화 하는 동안 초기 값을 지정해줘야 한다.
###### swift는 클래스 유형에 대해 두 가지 이니셜라이저를 정의한다.
- ###### 1. 지정 이니셜라이저 (designated init())
> ###### 객체를 만들 때 인자값을 받게 한 다음, 해당 인자값으로 프로퍼티 초기값을 정하는 방식이다.
```Swift
class Student{
    var name: String
    var age: Int
    var study: String

    init(myName: String, myAge: Int, myStudy: String){
        self.name = myName
        self.age = myAge
        self.study = myStudy
    }
}

let youjin = Student(myName: "youjin", myAge: 18, myStudy: "iOS")
```
> ##### 

- ###### 2. 편의 이니셜라이저 (convenience init())
> ###### 인스턴스 객체마다 같은 인자값을 지니는 경우에는 convenience init을 통해 초기값을 지정해줄 수 있다.
```Swift
class Athlete{
    var name: String

    // Designated init
    init(name: String){
        self.name = name
    }

    // Convenience Init
    convenience init(){
        self.init(name: "NONAME")
    }
}
```
<br>

### designated init(), convenience init()과 상속
> #### 아래와 같은 Building클래스를 활용하여 상속할 때에 `designated initializer`와 `convenience initializer`를 살펴보겠다.
```Swift
class Building{ // parent(super) class 생성
    var stories: Int
    var type: String
    var name: String

    // Building의 designated이자 인스턴스 객체를 만들때마다 인자값을 받는 custom initializer 생성
    init(stories: Int, type: String, name: String){
        self.stories = stories
        self.type = type
        self.name = name
    }
}

var store = Building(stories: 30, type: "Commercial", name: "store")
```
- #### 1. 상속 시 designated initializer 살펴보기
##### 일단 youjinStore class에는 Building에는 없는 isOpen, managerName이라는 저장 프로퍼티가 존재합니다.
##### youinStore는 Building class를 상속하므로 youjinStore의 인스턴스 객체는 Building의 Property들도 모두 세팅해주어야 한다.
##### 이때 중요한 점은 subclass에 존재하는 property부터 세팅을 한다음 super.init이 와야한다. super.init부터 세팅하면 컴파일러 에러 발생..
```Swift
class YoujinStore: Building{
    var isOpen: Bool
    var managerName: String

    init(isOpen: Bool, managerName: String, stories: Int, type: String, name: String){
        self.isOpen = isOpen
        self.managerName = managerName
        super.init(stories: stories, type: type, name: name)
    }
}

let youjinStore = YoujinStore(isOpen: true, managerName: "Youjin", stories: 2, type: "store", name: "youjinStore")
```
- #### 2. 상속 시 convenience initializer 살펴보기
##### convenience init을 보면 인자값을 하나만 받고 나머지 프로퍼티들은 기본값을 세팅한다.
##### 이렇게 처음에 각 인스턴스 객체마다 따로 세팅이 필요한 property 값만 인자값으로 받게 하고, 각 인스턴스 객체 모두 같은 값을 가져도 되는 property들은 기본값을 세팅해주는 것이 바로 convenience initializer이다.
```Swift
class YoujinStore: Building{
    var isOpen: Bool
    var managerName: String

    // designated initializer
    init(isOpen: Bool, managerName: String, stories: Int, type: String, name: String){
        self.isOpen = isOpen
        self.managerName = managerName
        super.init(stories: stories, type: type, name: name)
    }

    // convenience init
    convenience init(isOpen: Bool){
        self.init(managerName: String, stories: Int, type: String, name: String)
    }
}

// convenience initializer를 통해 새로운 인스턴스 객체를 만들면 단 하나의 인자값만 넣어주면 나머지 property는 default 값으로 세팅되게 됩니다.
var youjinStore = YoujinStore(isOpen: true)
```

<br>

### required init()
- ##### required initializer는 자신을 상속하는 subclass들이 모두 따르도록 강제하는 initializer이다.
###### 아래를 살펴보면 지금 상태에서는 아무런 문제가 없다. CookieRun은 required init을 가지는 Game의 subclass이지만 initializer를 아예 기입하지 않았기 때문이다.
###### 기본적으로 subclass에 designated initializer가 없다면 자동적으로 superclass의 initializer를 상속하기 때문에 subclass에 다로 initializer를 만들 필요가 없다.
```Swift
class Game{
    var name: String

    required init(name: String){
        self.name = name
    }
}

class CookieRun: Game{

}
```

###### 하지만 CookieRun에 별도의 init()을 만들려고 할 때 문제가 발생한다.
###### 아래처럼 무조건 상위 class의 required init()부터 선언하도록 강제하기 때문이다.
```Swift
class Game{
    var name: String

    required init(name: string){
        self.name = name
    }
}

class CookieRun: Game{
    required init(name: String){
        super.init(name: name)
    }
}
```

- ##### required init의 예제로 uiview의 required init을 가져왔다.
> ###### UIView를 상속받아서 생성자를 사용하려고하면 required init?(coder: NSCoder)를 작성해야 한다. 이것은 무엇이고 왜 UIView를 상속받아서 사용할 때 항상 필요한걸까?

###### UIView를 상속하여 지정이니셜라이저를 작성할 때, required 이니셜라이저인 Init(corder:)를 정의해주어야한다는 에러인데, 다음과 같이 정의만 해주면 에러 문구는 사라진다.
```Swift
class youjinView: UIView {
    required init?(corder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
```
###### 왜 이런 에러가 발생하며 위와 같은 작업을 해줘야 할까? 바로 `NSCoding` 때문이다.
###### NSCoding 프로토콜은 이를 구현하는 클래스로 하여금, 위와 같은 required init?() 즉, 실패가능한 이니셜라이저를 작성하도록 한다.
###### 프로토콜에 명세된 이니셜라이저를 구현하면 required 키워드가 붙으며, required 키워드가 붙은 이니셜라이저는 상속받은 자식 클래스에서도 반드시 구현해주어야 한다.
```Swift
public protocol NSCoding{
    public func encode(with aCoder: NSCoder)
    public init?(coder aDecoder: NSCoder)
}
```
###### UIView는 NSCoding 프로토콜을 채택하고있으므로, 이를 상속받은 클래스에서는 required init?(coder:)를 구현 해줘야 한다.

<img width="348" alt="스크린샷 2021-12-23 오후 11 34 45" src="https://user-images.githubusercontent.com/71479613/147254726-f8b44150-eab6-4a74-8e5c-2f0a63bdf93f.png">

###### 그럼 init을 구현하지 않았을 때는 required init?(coder:)를 구현해야한다는 문구가 나오지 않다가 새로운 지정 이니셜라이저를 작성한 후에 나타나는 이유가 뭘까?
###### Swift에서는 자식 클래스에서 지정이니셜라이저를 따로 작성하지 않은 경우, 부모의 이니셜라이저들을 자동으로 상속한다. 즉, UIView 객체를 구현한 후 init을 따로 작성하지 않으면 부모 즉 UIView의 required init?을 자동으로 상속하여 오류 문구가 뜨지않는것이다. 
###### 하지만 자식클래스에서 따로 이니셜라이저를 작성하게되면, 부모 클래스의 이니셜라이저들이 자동상속되지 않아 required init?(coder:)을 구현하라는 오류 문구가 나오게 되는 것이다!!!!!!!!!!!


<br>

#### 참고자료
- ###### https://zeddios.tistory.com/142
- ###### https://medium.com/@jgj455/%EC%98%A4%EB%8A%98%EC%9D%98-swift-%EC%83%81%EC%8B%9D-%EC%B4%88%EA%B8%B0%ED%99%94-%EA%B0%92-%ED%83%80%EC%9E%85%EC%9D%98-initializer-1e3d329050c6
- ###### https://medium.com/@jgj455/%EC%98%A4%EB%8A%98%EC%9D%98-swift-%EC%83%81%EC%8B%9D-initializer-2%ED%8E%B8-%ED%81%B4%EB%9E%98%EC%8A%A4%EC%9D%98-initializer-7141cda4ecf2
- ###### https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=jdub7138&logNo=220379745883
- ###### https://giraff-ios.tistory.com/1