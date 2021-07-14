# **Components**

- #### ```Components``` 이해해보기 with Youjin 👩🏻‍💻

### Components가 뭐야?

> #### ```주어진 구분 기호로 나누어진 수신기의 부분 문자열을 포함하는 배열을 반환합니다.```
> #### ```인자값으로 문자를 받아 문자 기준으로 쪼갠 결과값을 반환합니다.```
> #### ```반환형이 [String] 이다```

### 응..? Split이랑 똑같은 거 아닌가? 👩🏻‍💻
- ###### Split은 반환값이 [SubString], Components는 반환값이 [String]이다 !
 - ###### Split은 import UIKit이지만 Components는 import Foundation을 해주어야 한다 !
 - ###### Split은 다양한 옵션 인자값을 가지지만 Components는 인자값이 하나이다!
 - ###### 결과값만 본다면 동일해 보일지 모르지만 그 과정에서 차이가 있다고 합니다 😱


### Components, 어떻게 사용할까?
- ###### 매우 간단하다 🤔
```swift
import Foundation
var array = ["Hello, I'm so pretty."]

var oddArray = array.채ㅡ

print(oddArray) // 2, 4, 6, 8
```