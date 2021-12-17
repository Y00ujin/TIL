# Computed Property

<br>

### Computed Property란?
- ##### 클래스, 구조체, 열거형에서 사용된다
- ##### 저장 프로퍼티와 달리 `저장 공간을 갖지 않고`, 다른 "저장 프로퍼티"의 값을 읽어 연산을 실행하거나, 프로퍼티로 전달받은 값을 `다른 프로퍼티에 저장`한다.
- ##### 연산프로퍼티는 반드시 var로 선언되어야 합니다. 값이 고정되어 있지 않기때문
- ##### 연산 프로퍼티는 위 코드처럼 get, set둘다 가질 수 있지만, get만을 가질 수 있습니다. (set만 가지는 것은 안돼!)

<br>

### Computed Property 정의하기
```Swift
class Person {
    var name: String = "Sodeul"
 
    // 연산 프로퍼티는 어떠한 값을 저장하는 것이 아니기 때문에, 타입 추론을 통해 형식을 알 수 없어서 반드시 선언할 때 타입 어노테이션을 통해 자료형을 명시해야 함 (String)
    var alias: String {
        get {
            // getter는 어떤 저장 프로퍼티의 값을 연산해서 return할 것인지, return 구문이 항상 존재해야 함
            return name
        }
        set(name) {
            // setter는 파라미터로 받은 값을 어떤 저장 프로퍼티에 어떻게 설정할 것인지를 구현
            self.name = name
        }
    }
}
```

- ##### 틀린 코드
> ###### 연산 프로퍼티는 다른 "저장 프로퍼티"를 읽고 써야하는데 현재 alias라는 연산 프로퍼티를 읽고 쓰고있음. alias란 연산 프로퍼티는 값을 저장할 저장 공간이 없는데, alias에 저장된 값을 읽으려고 하기 때문에 오류 발생

> ###### 따라서 위와 같이 name과 같이 읽거나 쓸 수 있는 "저장 프로퍼티"가 먼저 존재해야 하고, 연산 프로퍼티에선 이 다른 "저장 프로퍼티"의 값을 읽거나 쓰는 작업을 해야 함
```Swift

class Person {
    var alias: String {
        get {
            return alias
        }
        set(name) {
            self.alias = name
        }
    }
}
```

<br>

### Computed Property 사용하기
```Swift
let sodeul: Person = .init()
 
// get에 접근
print(sodeul.alias) // Sodeul
 
// set에 접근
sodeul.alias = "소들" // setter의 파라미터 name으로 "소들"이라는 값이 들어가고 그 namedl alias로 들어감
print(sodeul.name) // 소들
```

<br>

### Set의 축약
- ##### setter 기본형
```Swift
    var alias: String {
        get {
            return name
        }
        set(name) { // setter는 파라미터를 받기위해 name이라고 이름을 지정해주었는데 (name)이부분을 생략하고 아래와 같이 쓸 수 있다.
            self.name = name
        }
    }
```

- ##### setter 축약형
```Swift
    var alias: String {
        get {
            return name
        }
        set { // 이와같이 newValue라는 키워드를 사용하여 축약할 수 있다. 다른 이름 안댐 newValue만 써야함
            self.name = newValue
        }
    }
```

<br>

### Read-Only Computed Properties란?
- ##### get만 있는 연산 프로퍼티, 읽기 전용, get만 있을 때는, get을 "생략"해도 됩니다. 

```Swift
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
```