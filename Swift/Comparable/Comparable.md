## Comparable

<br>
<br>

### Comparable이란?
- ##### 객체나 구조체를 연산자를 통해 수치 비교가 가능하게 도와주는 프로토콜이다.
- ##### <, >, <=, >= 등의 연산을 수행할 수 있도록 도와준다.
- ##### 반드시 Equatable을 함께 사용해야 한다.

<br>
<br>

### 구조체 Comparable하게 만들기
- ##### Comparable protocol은 반드시 < 연산자를 오버로딩 해야한다.
```Swift
extension Point: Comparable {
    static func <(left: Point, right: Point) -> Bool {
        if left.y < right.y { return true }
        return left.x < right.x
    }
}
```

