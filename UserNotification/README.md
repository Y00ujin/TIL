# **UserNotification**

- #### **Push알림 구현해보기 with Code** 👩🏻‍💻

<br>

##### **🛠 1. UserNotification을 사용하기 위한 import**
###### UserNotifications을 사용하려면 import가 필요하다.
```swift
import UserNotifications
```

###### Podfile에 넣고 import를 하는데 자꾸 에러가 났다..
```Swift
"File 'ViewController.swift' is part of module 'UserNotifications'; ignoring import"
```

###### 그리고 검색을 통해 이러한 자료를 발견했다.

- ###### https://seikousyahenomichi.com/file-viewcontroller-swift-is-part-of-module/

###### 프로젝트와 import할 요소의 이름이 같을 때 발생하는 오류였다!

###### 그래서 UserNotification였던 프로젝트 이름을 UserNotification_Tutorial로 변경하니 잘 작동했다!

<br>

##### **🛠 2.  Push 알림에 들어갈 내용들을 구조체안에 선언해주자!**
```Swift
struct MyReminder {
    let title: String
    let data: Date
    let identifier: String
}
```

##### **🛠 3. 구조체를 변수에 담아주자**
```Swift
    var models = [MyReminder]()
```

###### 버튼을 누르고 몇 초 뒤에 알림이 오게 하기 위해서, 버튼을 생성해줘야한다.

```Swift
    var testButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "doc.append"), for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
```

##### **🛠 4. 사용자에게 알림허락을 받아보자**
- ###### 그런데 알림을 보내주기 전에 사용자에게 허락을 받아야 한다.
###### 사용자에게 허락을 받고, 허락을 했으면 알람을 보내고, 거절했으면 에러를 출력하게 했다.<br>앱을 열었을 때 바로 알림 허용 팝업이 뜨게 했다.


```Swift
    override func viewDidLoad() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound], completionHandler: { success, error in
            print(success)
        })
    }
```

##### **🛠 5. 버튼이 클릭되었을 때 알림을 호출해보자!**
- ###### 먼저 Push알림의 내용물을 채워줍시다!

```Swift
    // UNMutableNotificationContent클래스의 객체 생성
    let content = UNMutableNotificationContent()

    // Push알림의 제목 설정
    content.title = "This is title"

    // Push알림의 소제목 설정
    content.subtitle = "This is Subtitle"

    // Push알림의 소리 설정
    content.sound = .default

    // Push알림의 내용 설정
    content.body = "This is boooooooooooooooody"
```
- ###### 그리고 이 알림을 언제 실행시킬지 알려줘야해요 -> trigger를 설정해줘야함!
###### UNNotificationTrigger에는 총 4가지가 있어요

###### - ```UNTimeIntervalNotificationTrigger```
###### : 지정된 시간이 경과 한 후 알림이 전달되도록하는 트리거 조건
###### - ```UNCalendarNotificationTrigger```
###### : 특정 날짜 및 시간에 알림이 전달되도록하는 트리거 조건

###### - ```UNLocationNotificationTrigger```
###### : 사용자의 기기가 지정된 지역에 들어 오거나 나갈 때 알림이 전달되도록하는 트리거 조건
###### - ```UNPushNotificationTrigger```
###### : 알림이 Apple 푸시 알림 서비스 (APN)에서 전송되었음을 나타내는 트리거 조건


###### 저희는 UNCalendarNotificationTrigger(특정 날짜 및 시간 알림)를 사용해보려고해요
```Swift
// 현재시간에 5초를 더한 시간을 targetDate에 저장합니다.
let targetDate = Date().addingTimeInterval(5)

// 특정 날짜와, 반복여부를 설정해줍니다.
// 특정 날짜 : dateComponents[년, 월, 날, 시간, 분, 초]
// 반복 여부 : false 놉
let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
```

- ###### 이 알람을 이때 호출해달라고 예약을 해봅시다!
```Swift
let request = UNNotificationRequest(identifier: "push_alert_id", content: content, trigger: trigger)
```

- ###### 알림을 호출해봅시다
```Swift
UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
    if error != nil{
        print("something went wrong")
    }
})
```

### ⏰ Push알림 호출 성공!

