## Lazy Stored Property

<Br>
<br>

### Lazy Stored Property란?
- ##### 지연 저장 프로퍼티는 호출이 있어야 값을 초기화하게 된다.
- ##### 지연 저장 프로퍼티를 잘 사용하면 불필요한 성능 저하나 공간 낭비를 줄일 수 있습니다.

<br>
<br>

### Lazy Stored Property 사용법
- ##### 상수는 인스턴스가 완전히 생성되기 전에 초기화 되어있어야하므로 `var 키워드`를 사용하여 변수로 정의한다.
- ##### lazy 키워드를 사용한다.
```Swift
struct CoordinatePoint{
    var x: Int = 0
    var y: Int = 0
}

class Position {
    // 지연 저장 프로퍼티 생성
    lazy var point: CoordinatePoint = CoordinatePoint()
    let name: String

    init(name: String){
        self.name = name
    }
}

// Position이라는 객체가 생성되었지만 CoordinatePoint는 호출되지않았기때문에 생성되지 않은 상태이다.
// point가 lazy로 선언되지 않았다면 이때 CoordinatePoint도 동시에 생성된다.
let position: Position = Position(name: "youjin")

// point에 처음 접근할 때 point 프로퍼티의 CoordinatePoint가 생성된다.
print(position.point)
```
