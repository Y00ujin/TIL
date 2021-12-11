# Stuct

<br>

### Stuct란?
- ##### 인스턴스의 값(프로퍼티)을 저장하거나 기능(메소드)을 제공하고 이를 캡슐화할 수 있는 스위프트가 제공하는 타입(named type)입니다.

<br>

### Stuct의 특징!
- ##### 1. 상속 불가능!
- ##### 2. 값타입이다.
- ##### 3. iOS 프레임워크의 대부분이 클래스로 구성되어있다.

<br>

### Stuct 사용법!
```Swift
struct Name {
    var name = "Song"
    
    func my_name() {
        print("my name is \(name)")
    }
}

var song : Name = Name() // 인스턴스 생성!

print(song.name)
song.my_name()

song.name = "kim"
song.my_name()
```

<br>

### Stuct의 초기화 방법!
```Swift
struct Name {
    var name: String
    
    func my_name() {
        print("my name is \(name)")
    }
}

var song : Name = Name(name: "song") // class와 다르게 Init없이 자동으로 초기화할 수 있게 해줌!
// 초기화 코드를 직접 정의하면 자동 초기화 코드는 저 이상 제공받지 못한다

print(song.name)
song.my_name()
```