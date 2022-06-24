## Subject 

- ##### ```Subject  of Combine``` 머리에 넣기 with Youjin 👩🏻‍💻

<br>

### 현재 상황 

##### 1. 태그 관리VC에서 태그를 선택하여 태그 설정 VC로 화면전환한다.
##### 2. 태그 설정VC에서 태그 삭제 버튼을 클릭한다.
##### 3. 삭제 버튼 클릭 시 Pop하고, **태그 관리VC에서 삭제 이벤트를 인식하고 해당 태그를 삭제한다.** `(Combine!!!!)`

<br>

> ##### Combine을 사용해서 삭제 버튼 이벤트를 다른 VC에서 받아보자!!
<img width="796" alt="스크린샷 2021-10-03 15 47 31" src="https://user-images.githubusercontent.com/71479613/135743253-915a3310-7c01-4c45-86d7-c9e71dcd7ce8.png">

<br>

#### TagSettingViewController (삭제 이벤트가 발생하는 VC)

- ##### 1. Combine의 Subject를 사용하기 위해 Combine을 import해주자!
```swift
    import Combine
```

- ##### 2. UIButton값(Delete 버튼)을 받아서 다른곳에 전달해주는 변수를 생성해주자
```swift
class TagSettingViewController: UIViewController {
    var passDeleteEventButton = PassthroughSubject<UIButton, Never>()
}
```

- ##### 2. UIButton값(Delete 버튼)을 passDeleteEventButton를 통해 보내버리자.
```swift
    @objc func modalDeleteButtonClicked(sender:UIButton){
        passDeleteEventButton.send(sender)
        self.navigationController?.popViewController(animated: true)
    }
```
#### TagManagementViewController (삭제 이벤트가 발생하는 VC)

- ##### 1. 똑같이 Combine을 import해주자!
```swift
    import Combine
```

- ##### 2. 변수를 생성해주자!
`var bag = Set<AnyCancellable>()`

- ##### 3. TagSettingVC로 화면전환하는 부분에 삭제 이벤트를 인식하는 코드를 작성해주자.
```swift
nextViewController.passDeleteEventButton.sink { [weak self] button in
    // TableView cell 삭제 기능 구현
}
.store(in: &bag)
```