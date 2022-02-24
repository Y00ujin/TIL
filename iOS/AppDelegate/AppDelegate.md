## AppDelegate

<br>
<br>

> ##### 아래 작성된 내용은 iOS 13 이후 버전의 AppDelegate에 대한 설명이며, iOS 12 이하 버전의 AppDelegate는 문서 맨 하단에 정리해놓았다.

### AppDelegate.swift의 역할
#### iOS 13 이후 application은 1 process & multiple user interface를 지원하게 되면서 AppDelegate의 일부 역할을 SceneDelegate에게 넘겨주었고, AppDelegate은 새로운 역할을 하나 더 맡게 되었다. (iOS 13 이후 SceneDelegate가 등장했다..!)
- ##### 1. Process Lifecycle의 이벤트 발생을 알려준다.
###### 앱이 실행되거나 꺼지거나 할 때 시스템은 App Delegate로 알린다.
- ##### 2. session life-cycle을 application에게 알려준다.
###### 새로운 씬 세션이 생성되거나 이미 존재하는 씬이 버려질 때 알려준다.

<br>
<br>

### AppDelegate의 메소드
##### 아래와 같은 메소드들을 사용하면 application가 app delegate와 통신할 수 있다.
##### 앱상태가 전환되는 동안(앱실행, 백그라운드 전환 및 앱 종료) application 객체는 위 메소드들 중 해당하는 delegate 메소드를 호출하여 앱이 응답할 수 있는 기회를 제공한다.
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
func applicationWillResignActive(_ application: UIApplication)
func applicationDidEnterBackground(_ application: UIApplication)
func applicationWillEnterForeground(_ application: UIApplication)
func applicationDidBecomeActive(_ application: UIApplication)
func applicationWillTerminate(_ application: UIApplication)
```

<br>
<br>

### iOS 12 이하 버전의 AppDelegate의 역할
#### iOS 12 이하 버전에서 Application은 1개의 process와 1개의 user interface 인스턴스를 가졌다.
- ##### 1. Process Lifecycle의 이벤트 발생을 알려준다.
###### 앱이 실행되거나 꺼지거나 할 때 시스템은 App Delegate로 알린다.
- ##### 2. UI의 상태변화를 알려주었다.
###### willEnterForeground, willResignActive와 같은 메소드들을 통해 알릴 수 있었다.


#### 참고자료
- ###### https://zeddios.tistory.com/218
- ###### https://baechukim.tistory.com/26
- ###### https://sueaty.tistory.com/135