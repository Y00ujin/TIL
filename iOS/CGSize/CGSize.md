## CGSize

<br>
<br>

### CGSize란?
- ##### 너비와 높이 값을 포함하는 구조체
- ##### `CGSize`는 `CoreGraphics` 프레임워크를 반입해야만 사용 가능한데 `UIkit`에 해당 프레임워크가 내포되어있어 `UIKit`만 반입해주면 된다.
###### width와 height를 포함하고있다.

```Swift
public struct CGSize {

    public var width: CGFloat

    public var height: CGFloat

    public init()

    public init(width: CGFloat, height: CGFloat)
}
```

<br>
<br>

### CGSize는 언제 사용할까
- ##### 높이와 넓이가 필요할 때.. 사용한다.
```Swift
import UIKit

let size = CGSize(width: 200, height: 300)
```

<br>
<br>

##### 참고자료
- ###### https://zeddios.tistory.com/201
- ###### https://boidevelop.tistory.com/102
- ###### https://boidevelop.tistory.com/102


