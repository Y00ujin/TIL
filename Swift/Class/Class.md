# Class

<br>

### Class란?
- ##### `클래스(class)`는 객체 지향 프로그래밍(OOP)에서 특정 객체를 생성하기 위해 변수와 메소드를 정의하는 `일종의 틀`이다.
- ##### 객체를 정의 하기 위한 상태(멤버변수)와 메서드(함수)로 구성된다.
- ##### 객체(Object)를 디자인하기 위한 기능

<br>

### Class의 특징!
- ##### 1. 단일 상속만 가능하다. 다중 상속 불가능!
- ##### 2. 참조타입이다.
- ##### 3. iOS 프레임워크의 대부분이 클래스로 구성되어있다.

<br>

### Class 사용법!
```Swift
Class 함수형{
    // Property, Method 
}

let youjin = 함수형() // 인스턴스 생성
```

<br>

### Class의 초기화 방법!
```Swift
class Name {
    var name : String
    var age : Int
    
    init(name:String, age:Int) { //초기화!
        self.name = name
        self.age = age
    }
    
    func my_name() {
        print("my name is \(name) and \(age) year's old")
    }
}

let name1 : Name = Name(name: "song", age: 24)
let name2 : Name = Name(name: "kim", age: 25)

name1.my_name()
name2.my_name()
```