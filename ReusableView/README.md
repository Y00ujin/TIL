# **ReusableView**

- #### reusableView를 사용하여 ```EZY TopView```를 구현해보자 
###### with Code 👩🏻‍💻

##### iOS는 한정된 메모리로 애플리케이션을 구동한다. <br>이때 반복되는 코드를 계속 만들어내지 않고 ``` 재사용```한다면 메모리 낭비를 방지하고 성향은 향상될 것이다 🦾

> ###### 재사용 뷰를 사용하는 것은 쉽다. 재사용 뷰를 생성하고 사용하면 끝이다.

#### **시작해보자** 👉🏻

##### 👩🏻‍💻 1. TopView 생성
- ###### UIView를 채택한 swift 파일을 하나 만들자.
```Swift
import UIKit

class TopView: UIView {
    
}
```

- ###### 뷰의 구성요소를 생성해보자
##### TopView에는 ```뒤로가기 버튼```과 ```페이지 제목```이 있다.
```Swift
import UIKit

class TopView: UIView {
    lazy var backButton = UIButton()
    lazy var titleLabel = UILabel().then {
        $0.dynamicFont(fontSize: 22, currentFontName: "Poppins-SemiBold")
    }
}
```