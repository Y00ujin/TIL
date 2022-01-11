## Stored Property

<br>
<br>

### Stored Property란?
- ##### 객체의 값을 저장하고있는 기본적인 프로퍼티
- ##### 객체가 생성이 되면 자동으로 초기화된다.
- ##### 클래스, 구조체에서 사용가능하고 열거형에서는 사용 불가능

<br>
<br>

### Stored Property 사용하기
```Swift
struct CoordinatePoint {
  var x: Int  // 저장 프로퍼티
  var y: Int  // 저장 프로퍼티
}

//구초제는 기본적으로 저장 프로퍼티를 매개변수로 가지는 이니셜라이져가 있습니다.
let point: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

class Position {
  var point: CoordinatePoint  // 저장 프로퍼티(변수)

  let name: String    // 저장 프로퍼티(상수)

  init(name: String, currentPoint: CoordinatePoint) {
      self.name = name
      self.point = currentPoint
  }
}

//사용자정의 이니셜라이저를 호출해야만 한다.
//그렇지 않으면 프로퍼티 초깃값을 할당할 수 없기 때문에 인스턴스 생성이 불가능 하다.
let position: Position = Position(name: "김승진", currentPoint: point)

```

<br>
<br>

##### 참고자료
- ###### https://joycestudios.tistory.com/m/5?category=859596
