# **Face ID**

- #### ```Face ID``` 구현해보기 with Youjin 👩🏻‍💻

### Face ID, 뭐야?

> #### ```생체 인증으로 자체 인증 체계를 보완하여 사용자가 앱의 민감한 부분에 쉽게 액세스할 수 있도록 합니다.```

### 바로 사용해보자! Face ID!
##### 1. Face ID를 사용하기 위하여 Framework를 추가해주자
- ###### 1-1. 파일 네비게이터에서 제일 상위 폴더인 프로젝트 폴더를 클릭한다.
- ###### 1-2. TARGET에서 General -> Frameworks, Libraries, and Embedded Content에 LocalAuthentication.framework를 추가해준다.

<br>

##### 2. Face ID를 사용할 ViewController에서 import 해주자
- ###### 2-1. ```import LocalAuthentication```

<br>

##### 3. 인증 정책 및 액세스 제어를 평가하기 위한 메커니즘, LAContext를 추가해주자

- ###### 3-1. ```let authContext = LAContext()```

##### LAContext가 뭐야?

###### Apple 왈 : ```인증 컨텍스트를 사용하여 Touch ID 또는 Face ID와 같은 생체 인식을 사용하거나 장치 암호를 제공하여 사용자의 ID를 평가합니다.```
###### 그냥 TouchID, FaceID의 모든 기능(인증, 평가)들을 담아놓은 것이라고 생각하면 될 거 같다.



<br>

### 준비는 끝났다. 이제 인증 코드를 짜보자!
###### 난 버튼을 누를 시 인증이 되도록 하기위해 <br> ``` @objc func withdrawalButtonClicked(sender:UIButton){}``` 이 함수 안에 작성하였다.

##### 4. NSError를 참조하는 error 변수를 선언해주자
- ###### 4-1. ```var error: NSError?``` 

<br>

##### 5. Face ID를 지원하는 기기인지 판별하자
- ###### 5-1. ```if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {}```


<br>

##### 6. 인증 여부를 판별해보자
- ###### 6-1. 마지막으로 인증 여부를 판단하고 성공하면 모달을 띄우는 형식으로 진행하였다.
```swift
authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description) { success, error in
                if success {
                    print("인증성공")
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.withdrawalModalView.isHidden = false
                    }
                    
                }else{
                    print("인증실패")
                    print(error?.localizedDescription)
                }
            }
```

##### 7. 마지막으로 Info.plist에 NSFaceIDUsageDescription항목을 추가한다.
##### 위처럼 추가하면 사용자의 동의를 구하는 모달을 띄우는데 Key 값에는 그때 뜰 안내 문구를 적어주면 된다.
- ###### 7-1. ```NSFaceIDUsageDescription```


