## UIWindow

<Br>
<br>

### UIWindow란?
- ##### UIWindow는 사용자 인터페이스에 배경(backdrop)을 제공하고, 중요한 이벤트 처리 행동을 제공하는 객체이다.
- ##### iOS앱은 모든 View들의 컨테이너 역할을 하는 UIWindow 인스턴스를 하나 가지는데, UIWindow는 UIView의 하위클래스이므로 Window 그 차제로 View라고 할 수 있다.
- ##### UIWindow는 View라는 사진을 끼워넣는 액자라고 할 수 있다.

<br>
<br>

### UIWindow의 역할
- ##### 앱이 보여주는 콘텐츠들을 포함하는 역할을 한다.
- ##### 뷰를 포함한 다른 앱 내 오브젝트들에게 이벤트를 전달해주는 핵심적인 역할을 한다.
- ##### 앱의 뷰 컨트롤러와 화면 방향전환(landscape & portrait)을 유용하게 하기 위해 협업한다.
- ##### 윈도우는 뷰 컨트롤러와 함께 동작하면서 이벤트를 핸들링하고 앱의 동작에 필수적인 작업들을 수행한다.

<br>
<br>

### UIWindow를 사용하는 경우
- ##### 1. 당연히.. 앱의 콘텐츠를 화면에 보여주기 위하여 Main window를 제공해야할 때
- ##### 2. 추가적인 콘텐츠를 보여주기 위해 추가적인 window를 생성해야 할 때 (external display를 사용할 경우)

<img width="836" alt="스크린샷 2022-01-19 오후 5 41 22" src="https://user-images.githubusercontent.com/71479613/150094601-c61f890d-92f0-43b6-bf2b-e6a6888a9ff5.png">


<br>
<Br>

### KeyWinow 관련하여
##### KeyWindow란?
- ##### 시스템이 생성한 윈도우에서 생성된 이벤트를 받는 윈도우
- ##### 키 윈도우는 isKeyWindow라는 속성을 통해 확인할 수 있다.
- ##### 하나의 시점에는 오직 한 개의 윈도우만이 키 윈도우가 될 수 있다.
- ##### 앱에서 External Display가 없는 경우 윈도우는 1개 이기 때문에 대부분의 경우, 앱의 메인 윈도우가 키 윈도우이다.
<br>

##### KeyWindow가 사용될 때
###### 예를 들어 키보드 창은 시스템이 생성한 윈도우이다.
###### 키보드 창에서 글자를 입력할 때 발생하는 이벤트들은 앱의 키 윈도우로 전달이 된다.
<img width="882" alt="스크린샷 2022-01-19 오후 5 51 40" src="https://user-images.githubusercontent.com/71479613/150096302-586da689-1699-4168-a266-4ae47cca8b07.png">
<br>
<br>

### UIWindow 객체를 생성하는 경우
> ###### 보통 Xcode는 프로젝트가 생성될 경우 자동으로 AppDelegate에 window 객체를 생성하여 window 객체를 또 생성하거나 상속받는 일은 잘 없다.
> ###### 다음은 window 객체를 새로 만들거나 만들어지는 경우다.
<br>

- ###### 1. 스토리보드를 쓰지 않을 경우에는 메인 window를 직접 생성해야 한다.
- ###### 2. 외부 디스플레이를 지원하는 앱의 경우 새로운 window를 만들어 보여줄 수 있다.
- ###### 3. 보통의 경우 새로운 window는 시스템에 의해 만들어지며 특정 이벤트에 대한 반응을 만들어진다. ( 예: 전화가 오는 경우 )

<br>
<br>

### UIWindow 생성하는 법
> ###### 메인 Window 객체는 프로그래밍 / 인터페이스 빌더 두 가지 방법으로 생성과 설정을 할 수 있고 AppDelegate 객체가 이것을 잡고 있어야 한다. 그리고 이 객체는 앱 상태에 상관없이 앱이 실행될 때는 항상 생성해야 한다. 그러나 추가적인 window 객체는 그것이 필요할 때 생성되도록(lazily created) 해야 한다.
<br>

###### 스토리보드로는 window가 자동으로 생성되니 스토리보드 없이 프로그래밍적으로 메인 Window 객체를 생성하고 뷰 컨트롤러와 연결해보겠다.

<br>

- ##### 1. Info.plist에 Main storyboard file base name의 Main을 지워준다.
###### 프로젝트를 생성할 경우 Xcode는 자동으로 Main.storyboard를 통해 메인 window 객체를 만들고 rootViewController를 결정한다. 그러나 우린 스토리보드를 사용하지 않기 때문에 지워준다.

<br>

- ##### 2. window 객체와 뷰 컨트롤러를 연결한다.
###### AppDelegate에 옵셔널한 window 객체가 있다.
###### 단, SceneDelegate 개념이 등장한 이후에는 SceneDelegate 오브젝트가 window 속성을 가지고 있다.
```Swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

}
```

###### 연결하는 작업은 UIApplicationDelegate 메소드인 DidFinishLaunchingWithOptions에서 해줄 것이다.
###### 아래와 같이 window객체를 생성만 하고 실행하면 에러가 난다.
###### window 객체는 뷰를 보여주는 컨테이너 역할이기 때문에 rootViewController를 무조건 가져야 한다.
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        ...

        return true
}
```

##### 그래서 아래와 같이 생성해둔 UIViewController를 윈도우의 rootViewController로 지정해주면 정상적으로 실행한다.
##### 하지만 검은 화면이 나온다. 우리가 지정한 window가 보이지 않는다는 의미인데 이것은 우리가 window가 keyWindow가 아니라는 뜻이다. (.isKeyWindow로 확인 가능하다.)

###### 여기서 KeyWindow란 키보드 이벤트, 터치와 관련없는 이벤트를 받는 window를 말한다. 터리 이벤트는 터치가 일어난 바로 그 윈도우에게 전달되지만 좌표값이 없는 이벤트는 앱의 keyWindow에 전달이 된다. (하지만 대부분의 경우 메인 윈도우가 keyWindow일 것이다.)
```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let window = window else { return true }
        window.backgroundColor = UIColor.cyan

        var MyViewController = MyViewController()
        MyViewController.backgroundColor = UIColor.red

        window.rootViewController = myViewController

        return true
}
```

###### 우리의 window객체가 keyWindow가 되고 보이게 하기 위해 아래의 코드를 추가해주면 rootViewController의 backgroundcolor인 red가 보이게 될 것이다.

<br>
<br>

### UIWindow가 가진 것
> ###### UIWindow는 타입 프로퍼티로 window가 keyWindow가 되거나 되지 않는지, 화면에 보이는지 안보이는지, 또는 키보드 관련 Notification을 갖고 있어서 감지하고 싶을 경우 옵저버를 추가해 읽으면 된다.
> ###### 그리고 원하는 윈도우의 좌표계로 바꿔주는 convert 인스턴스 메소드를 가지고 있어 윈도우 간 좌표 전환을 하고싶을 때 사용할 수 있다.

<Br>
<Br>

##### 참고자료
- ###### https://wnstkdyu.github.io/2017/12/29/uiwindow/
- ###### https://medium.com/@Alpaca_iOSStudy/uiwindow-5e7a9d72c582
- ###### https://woozzang.tistory.com/143