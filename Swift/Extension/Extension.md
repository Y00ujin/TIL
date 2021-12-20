## Extension

<br>

### Extension이란?
- ###### Extension은 기존 클래스, 구조체, 열거형, 프로토콜 타입에 새로운 기능을 추가한다. 기존 소스 코드에서 접근하지 못하는 타입들을 확장하는 능력이다.
- ###### 새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없다.
- ###### Extension은 추가 메모리를 관리할 수 없기 때문에 저장 프로퍼티는 추가할 수 없다.
- ###### 원본 타입(소스 코드)에 접근하지 못하는 타입들도 확장해서 사용할 수 있다

<br>

### Extension 사용법
- ##### Extension은 `extension`이라는 키워드를 사용하여 선언한다.
```Swift
extension 확장할 타입 이름 {
    // 타입에 추가될 새로운 기능 구현
}

extension UIColor {
    // 타입에 추가될 새로운 기능 구현
}
```

- ##### 타입이 프로토콜을 채택할 수 있도록 Extension하기
```Swift
extension 확장할 타입 이름: 프로토콜1, 프로토콜2, 프로토콜3 {
    // 프로토콜 요구사항 구현
}
```

<br>

### Extension으로 다양한 것들 추가하기
- ##### 1. 연산 프로퍼티 추가
```Swift
extension Int{
    // Int타입에 두 개의 연산 프로퍼티 추가
    var isEven: Bool{
        return self % 2 == 0
    }

    var isOdd: Bool{
        return self % 2 == 1
    }

    // static 키워드를 사용하여 연산 타입 프로퍼티도 추가
    static var isZero: Bool{
        return self == 0
    }
}

print(1.isEven) // false
print(2.isEven) // true
```

- ##### 2. 메서드 추가
###### 인스턴스 메서드, 타입 메서드 모두 추가 가능하다.
```Swift
extension Int{
    func multiply(by n: Int) -> Int{
        return self * n
    }
}

print(2.multiply(by:2)) // 4
```

- ##### 3. 이니셜라이저 추가
###### 3-1. Class에서의 생성자 추가
> ###### Designated initializer는 추가할 수 없고 Convenience initializer만 추가할 수 있으며, deinitializer(원본클래스에서만 구현해야함)를 추가할 수 없다.
```Swift
extension NSString{
    convenience init(name: NSString){
        self.init()
    }
}
```
###### 3-2. Struct에서 생성자 추가
> ###### extension으로 생성자를 추가할 경우, Memberwise Initializer(따로 생성자를 구현하지 않았을 경우에 자동으로 제공되는 모든 프로퍼티를 초기화 할 수 있게 하는 생성자)를 보존하며 새로운 생성자를 추가할 수 있다.

- ###### 이렇게 init을 구현하지않으면 Memberwise Initializer가 자동으로 생성됨
```Swift
struct PointStruct{
    let x: Int
    let y: Int
}

let point: PointStruct = .init(x:1, y:2) // 이 .으로 접근한 init이 Memberwise Initializer임
```

- ###### 그런데 이렇게 내가 생성자를 직접 구현하면 Memberwise Initializer는 제공되지 않음
```Swift
struct PointStruct{
    let x: Int
    let y: Int
    
    init(value: Int){
        self.x = value
        self.y = value
    }
}

let point: PointStruct = .init(x:1, y:2) // Error!
let point: PointStruct = .init(value: 2) // 이렇게 내가 정의한 생성자만 쓸 수 있음
```

- ###### 그런데 Extension을 사용하여 생성자를 직접 구현하면 Memberwise Initializer도 보존되고 내가 직접만든 생성자도 보존됨
```Swift
struct PointStruct {
    let x: Int
    let y: Int
}
 
extension PointStruct {
    init(value: Int) {
        self.x = value
        self.y = value
    }
}

// Extension으로 init을 정의해서 Memberwise Initializer도 사용하능! 보존되기때문
let point: PointStruct = .init(x:1, y:2) // 사용가능!
let point: PointStruct = .init(value: 2) // 사용가능!
```


- ##### 4. 서브스크립트 추가
###### 기존 타입에 새로운 서브스크립트를 추가할 수 있습니다. 
```Swift
extension String{
    subscript(appendValue: String) -> String {
        return self + appendValue
    }

    print("abc"["def"])// "abcdef"
}
```

- ##### 5. 중첩 타입 추가
###### 클래스, 구조체, 열거형에 새로운 중첩 타입을 추가할 수 있습니다.
```Swift
extension Int{ // Int라는 구조체에 열거형을 추가하여 중첩타입 완성
    enum Kind{
        case Negative, Zero, Positive
    }
}
```

- ##### 6. 변경 가능한 인스턴스 메소드 추가
// Method TIL 작성 후 내용 ㅇ추가


#### 참고자료
- ###### https://blog.yagom.net/529/
- ###### https://gwangyonglee.tistory.com/48
- ###### https://babbab2.tistory.com/124
- ###### 
- ######
- ######