## Singleton Pattern

- ##### iOS 면접 질문 준비하기 `211027` with Youjin🙇🏻‍♀️

<br>

### Sigleton?
> ##### 싱글톤을 사용하여 전역적으로 액세스할 수 있는 클래스의 공유 인스턴스를 제공합니다. 
> ##### 한 Instance에 어디 클래스에서든 접근 가능하게 하는 것
> ##### 싱글톤 패턴이란 특정용도로 객체를 하나 생성하여 공용으로 사용하고 싶을 때 사용하는 방법

<br>

### Sigleton 사용법?
##### 1. Sigleton Class 생성
- ###### shared 전역변수를 통해 UserInfo에 접근한다
```swift

class UserInfo {
    static let shared = UserInfo()

    var id: String?
    var password: String?
    var name: String?

    private init() { } // Init 함수를 호출해 Instance를 또 생생하는 것을 막기 위해, init() 함수 접근 제어자를 private로 지정
}
```
##### 2. Sigleton Class 접근
 - ###### 어느 클래스에서든 shared란 static 프로퍼티로 접근하면, 하나의 Instance를 공유할 수 있다.
```swift
//A ViewController
let userInfo = UserInfo.shared
userInfo.id = "Sodeul"
 

//B ViewController
let userInfo = UserInfo.shared
userInfo.password = "123"
 

//C ViewController
let userInfo = UserInfo.shared
userInfo.name = "Sodeul"
```

<br>

### Singleton 장점
- ##### 한 번의 Instance만 생성하므로 메모리 낭비를 방지할 수 있음
- ##### Singleton Instance는 전역 Instance로 다른 클래스들과 자원 공유가 쉬움
- ##### 한 번의 Instance만 생성하므로 메모리 낭비를 방지할 수 있음

<br>

### Singleton 단점
- ##### Singleton Instance가 너무 많은 일을 하거나, 많은 데이터를 공유시킬 경우 다른 클래스의 Instance들 간 결합도가 높아져  "개방=폐쇄" 원칙을 위배함 (객체 지향 설계 원칙 어긋남)
- ##### 따라서 수정과 테스트가 어려워짐

<br>

##### 참고자료
- ###### https://developer.apple.com/documentation/swift/cocoa_design_patterns/managing_a_shared_resource_using_a_singleton