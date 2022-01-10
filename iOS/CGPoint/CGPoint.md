## CGPoint

<br>
<br>

### CGPoint란?
- ##### 2차원 좌표계의 `점`을 포함하는 구조체
- ##### `CGPoint`는 `CoreGraphics` 프레임워크를 반입해야만 사용 가능한데 `UIkit`에 해당 프레임워크가 내포되어있어 `UIKit`만 반입해주면 된다.
###### CGPoint는 x와 y를 가지고있다.
```Swift
public struct CGPoint {
    public var x: CGFloat

    public var y: CGFloat

    public init()

    public init(x: CGFloat, y: CGFloat)
}
```

<br>
<br>

### CGPoint는 언제 사용할까
- ##### 요소들을 위치시킬 때 `x, y 좌표`가 필요한데 그때 CGPoint를 사용한다.
```Swift
let pos: CGPoint = .init(x: 100, y: 200)
```

<br>
<br>

##### 참고자료
- ###### https://zeddios.tistory.com/201
- ###### https://boidevelop.tistory.com/102
- ###### https://boidevelop.tistory.com/102

