# **APNs**

- #### ```APNs``` 사용해보기 with Youjin 👩🏻‍💻

## APNs?

### **APNs**란  `Apple Push Notification Service` 의 약자입니다.

- 이 곳에서 각 디바이스로 보내기 원하는 메세지를 받고 그리고 이곳에서 그 메세지의 신뢰도를 검사해서 각 Device의 앱으로 푸쉬알림을 보내주게 됩니다.

## APNs 환경설정?

> [https://spiralmoon.tistory.com/entry/Apple-Apple-push-notification-service-APNs-설정하기](https://spiralmoon.tistory.com/entry/Apple-Apple-push-notification-service-APNs-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0)


### 1. Apple Developer Account 생성

- [https://ithub.tistory.com/94](https://ithub.tistory.com/94)

### 2. App ID의 Push Notifications 활성화

- [애플 개발자 페이지](https://developer.apple.com/account/resources/identifiers/list)에 접속해서 `**Identifiers`** 에서 푸시 알림을 허용하고 싶은 앱을 클릭한다.
- **`Push Notifications`** 을 체크하고 저장한다.

### 3.  Keychain 인증서 발급

- Command와 Space를 눌러 키체인접근을 실행.
- 화면 좌측 상단에서 **"키체인 접근 >> 인증서 지원 >> 인증 기관에서 인증서 요청"**을 클릭.
- 본인의 이메일을 작성하고 "디스크에 저장됨"을 선택하고 "계속" 클릭.
- **CertificateSigningRequest.certSigningRequest 라는 파일명으로 다운 받아짐**

### 4. APNs 인증서 발급

- Certificates 탭에서 + 버튼 클릭 후 Services의 Apple Push Notification service SSL(개발, 배포 통합)를 선택한다.
- 푸시 알림을 적용할 iOS App ID를 선택하고 Continue 클릭한다.
- 다시 개발자 페이지로 돌아와서 방금 발급받은 키체인 인증서를 업로드 하고 "Continue"를 클릭.
- APNs 인증서가 생성되었다. "Download"를 눌러서 파일로 저장하자.
- **aps.cer**라는 파일명으로 다운 되었다. 더블 클릭해서 키체인 목록에 추가하자.
- Certificates 목록에 인증서가 **Apple Push Services 타입**으로 생성된 것을 확인할 수 있다.

### 5. APNs 키 발급

- Keys 메뉴에서 + 버튼 클릭
- APNs를 체크하고 "Configure" 클릭
- APNs 키가 생성되었다. 생성된 키 파일은 현재 페이지에서 벗어나면 **재다운받을 수 없으니 반드시 다운받아서 잘 보관하도록 하자.** (분실하면 다시 발급해야 한다.)

### 6. iOS 프로젝트에서 Push Notification, Background Modes 활성화

- TARGET의 **"Signing & Capabilities"**에서 **All**을 선택하고 "+ Capability"를 클릭한다.
- Push Notification, Background Modes 추가
- Background Modes에선 **"Background fetch"**와 **"Remote notifications"** 를 활성화 한다.

## APNs 사용방법?

> [http://monibu1548.github.io/2018/05/29/push-cert/](http://monibu1548.github.io/2018/05/29/push-cert/)


### 1. Push Permission 획득

- AppDelegate파일의 didFinishLaunchingWithOptions 메소드에 다음의 코드를 작성합니다.
- Push도 위치정보, 사진정보등과 같이 Native를 활용하기 때문에 사용자의 권한 동의가 필요하기 때문에 동의를 얻는 코드입니다.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }

        return true
    }
```

### 2. Device Token 확인

- 이제 디바이스 토큰 확인을 위해 AppDelegate파일에 didRegisterForRemoteNotificationsWithDeviceToken 메소드를 오버라이드 합니다

```swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let   tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("deviceToken: \(tokenString)")
    }
```

### 3. APN Easy Provider Push Test

- AppStore에서 APN easy Provider를 설치해줍니다.
- Add Tokens.. 버튼을 눌러 전 단계에서 얻었던 Device Token을 등록합니다.
- Device Token 입력 후 Confirm을 선택합니다. Name은 아무거나 등록해주세요.
- 다음은 2.Choose Certificate File 을 클릭합니다. 여기서는 애플 개발자센터에서 생성한 Push Certificate를 등록해야합니다.
- 애플 개발자센터에서 다운받은 Push Certificate 파일을 더블클릭하면 키체인 접근에 등록이 됩니다.
- 인증서를 오른쪽 버튼으로 클릭 후 ~~~ 내보내기를 선택합니다. 파일 확장자를 .cer로 하여 편한 위치에 내보냅니다.
- 이제 다시 APN Easy Provider에서 방금 내보내기로 만든 .cer 형태의 Push certificate를 선택합니다.
- 그리고 3. Connect to:를 클릭합니다. 우측의 드랍다운메뉴는 gateway.sandbox.push.apple.com을 선택합니다.
- apple의 apn server에 연결되면 Status에 아래처럼 뜹니다. 이제 Push 테스트 환경 구축이 끝났습니다.

```
Connecting to gateway.sandbox.push.apple.com
Connected to server, validating identity...
Connected to APN server successfully

```

- Push Noti의 타이틀과 내용을 작성 후 5. Send APN 버튼을 눌러봅니다.

위 과정은 앱에 Push기능을 넣고 제대로 동작하는지 과정일 뿐입니다.
실제 프로젝트에서 Push를 적용하기 위해서는 앱들의 디바이스 토큰을 관리하고 푸시를 발생시킬 서버를 필요로 합니다.

서비스의 로직에 따라 적절한 타이밍에 적절한 Push Noti를 발생시키는 것은 이제 서비스의 역할입니다.

### Firebase를 이용한 Push notification

> [http://monibu1548.github.io/2018/05/31/firebase-push/](http://monibu1548.github.io/2018/05/31/firebase-push/)
