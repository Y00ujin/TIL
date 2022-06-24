# **StackView**

- #### ```StackView``` 공부해보기 with Code 👩🏻‍💻

### StackView란?
- ##### UIStackView는 수평(horizontal) 또는 수직(vertical) 뷰의 스택을 만드는데 필요한 제약조건(constraint)를 만들거나 관리합니다
- ##### 열이나 행에 뷰 컬렉션을 배치하기 위한 간소화된 인터페이스입니다.

#### 간단히 말해서, 열이나 행에 맞춰 여러가지 뷰를 배치할 때 사용하면 좋은 것..!

### StackView 바로 사용해볼까?
- ###### Storyboard없이 코드로만 사용한다.
#### 1. StackView와 내용물들을 생성해준다.
##### 저는 StackView와 내용물(UIView객체 2개, UIButton객체 1개)을 생성했어요.
```swift
    var subView1: UIButton = {
        let v = UIButton()
        v.setTitle("subView1", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 10)
        v.layer.cornerRadius = 20
        v.backgroundColor = .red
        
        return v
    }()
    
    var subView2: UIButton = {
        let v = UIButton()
        v.setTitle("subView1", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 10)
        v.layer.cornerRadius = 20
        v.backgroundColor = .orange
        return v
    }()
    
    var subView3: UIButton = {
        let v = UIButton()
        v.setTitle("subView1", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 10)
        v.layer.cornerRadius = 20
        v.backgroundColor = .yellow
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [subView1, subView2, subView3])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        return sv
    }()
```

##### 1-1. 먼저 StackView부터 볼까요?
```swift
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [subView1, subView2, subView3])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        return sv
    }()
```
- ###### StackView에 subView1, subView2, subView3을 담았어요.
```let sv = UIStackView(arrangedSubviews: [subView1, subView2, subView3])```
- ###### axis의 값을 .vertical 즉, 수직으로 줬어요.
```sv.axis = .vertical```
- ###### distribution의 값을 .fillEqually로 줬어요.
###### fillEqually : 내용물의 크기를 같게 하는 것
- ###### spacing을 주면 StackView 안쪽에 공간이 생겨요

<br>

### 결과적으로 이런 StackView가 만들어져요!
<img width="300" alt="스크린샷 2021-09-19 22 44 59" src="https://user-images.githubusercontent.com/71479613/133929839-4762859e-9446-42cc-b923-2a218350b668.png">