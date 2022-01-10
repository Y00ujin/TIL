## CGRect

<br>
<br>

### CGRect란?
- ##### 사각형의 크기와 위치가 포함되어있는 구조체
- ##### 뷰의 위치, 크기를 한 번에 잡아주기 위한 구조체
- ##### `CGRect`는 `CoreGraphics` 프레임워크를 반입해야만 사용 가능한데 `UIkit`에 해당 프레임워크가 내포되어있어 `UIKit`만 반입해주면 된다.
##### CGPoint 형식의 origin과 CGSize 형식의 size를 포함하고있다.
```Swift
public struct CGRect{
    public var origin: CGPoint
    public var size: CGSize
    public init()
    public init(origin: CGPoint, size: CGSize)
}
```

<Br>
<br>

### CGRect는 언제 사용할까
- ##### 사각형을 그릴 때 사용한다.
```Swift
var rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 30))
```

<Br>
<br>

##### 참고자료
- ###### https://zeddios.tistory.com/201
- ###### https://boidevelop.tistory.com/102
- ###### https://boidevelop.tistory.com/102

