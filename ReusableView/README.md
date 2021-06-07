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

- ###### 뷰의 구성요소에 값을 넣어줄 함수를 작성해보자!
##### 이 TopView를 사용하는 곳에서 이 함수를 호출하여, 때에 맞는 이미지와 text를 넣어 사용할 수 있다.
```Swift
    func topViewDataSetting(backButtonImage: UIImage, titleLabelText: String, textColor: UIColor){
        backButton.setImage(backButtonImage, for: .normal)
        
        titleLabel.text = titleLabelText
        titleLabel.textColor = textColor
    }
```

- ###### 뷰의 구성요소의 layout을 잡아보자!
##### 이 함수를 호출하여 현재 스크린의 높이와 넓이를 보내주면 기기에 맞춰 layout이 잡힌다.
```Swift
        func topViewLayoutSetting(screenHeight: Double, screenWeight: Double){
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(screenHeight/47.7)
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview().dividedBy(33.8/2)
            make.height.equalTo(backButton.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton)
            make.top.equalTo(backButton.snp.bottom).offset(screenHeight/30)
        }
    }
```

##### 👩🏻‍💻 2. TopView 호출
- ###### 생성된 TopView를 호출해보자!
> ###### SettingViewController에서 TopView를 호출한다.

```Swift
import UIKit

class SettingViewController: UIViewController {
    
    lazy var topView = TopView()
    
    func topViewSetting(){
        self.view.addSubview(topView)
        topView.addSubview(topView.backButton)
        topView.addSubview(topView.titleLabel)

        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        topView.topViewDataSetting(backButtonImage: UIImage(named: "EZY_SettingBackButton")!, titleLabelText: "설정",
                                   textColor: UIColor(red: 175/255, green: 173/255, blue: 255/255, alpha: 1))

        topView.topViewLayoutSetting(screenHeight: Double(self.view.bounds.height), screenWeight: Double(self.view.bounds.width))
        
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalToSuperview().dividedBy(8)
        }
    }
}

```