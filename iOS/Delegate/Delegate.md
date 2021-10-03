## Delegate 

- ##### ```Delegate``` 머리에 넣기 with Youjin 👩🏻‍💻

<br>

### 현재 상황 

##### 1. 태그 관리VC에서 태그를 선택하여 태그 설정 VC로 화면전환한다.
##### 2. 태그 설정VC에서 태그 이름을 수정한다.
##### 3. 완료 버튼을 클릭하여 Pop하고, **수정된 태그 이름을 태그 관리VC로 전달한다.** `(Delegate!!!!)`

<br>

> ##### Delegate를 사용해서 Data를 전달해보자!
<img width="796" alt="스크린샷 2021-10-03 15 47 31" src="https://user-images.githubusercontent.com/71479613/135743253-915a3310-7c01-4c45-86d7-c9e71dcd7ce8.png">

<br>

### TagSettingViewController (데이터를 보내는 VC)
- #### 1. didTagCompleteButton() 함수를 갖는 SendChangedTagName `프로토콜`을 먼저 만들어주었다.

```swift

protocol SendChangedTagName{
    func didTagCompleteButton(changedTagName: String)
}

class TagSettingViewController: UIViewController {
        ...
}
```

- #### 2. 일을 위임할 delegate 변수를 선언해주자.

```swift
class TagSettingViewController: UIViewController {
    var delegate: SendChangedTagName?
}
```

- #### 3. SendChangedTagName의 함수에 보낼 데이터를 넣고 보내버리자.
> ###### delegate 변수의 자료형으로 SendChangedTagName 프로토콜을 사용함으로써 이 delegate 변수, 즉 위임자가 SendChangedTagName의 함수에 접근할 수 있다.

```swift
    @objc func completeButtonClicked(sender:UIButton){
        delegate?.didTagCompleteButton(changedTagName: tagNameTextField.text!)
            
        navigationController?.popViewController(animated: true)
    }
```

<br>

### TagManagementViewController (데이터를 받는 VC)

- #### 1. SendChangedTagName 프로토콜을 채택하고 함수를 구현해보자!
```swift
extension TagManagementViewController: SendChangedTagName{
    func didTagCompleteButton(changedTagName: String) {
        print("changedTagName : \(changedTagName)")
    }
}
```

- #### 2. 대리자 위임 고
```swift
    let nextViewController = TagSettingViewController()
    nextViewController.delegate = self
```
