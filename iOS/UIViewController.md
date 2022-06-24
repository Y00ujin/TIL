## UIViewController

<br>
<br>

### UIViewController란?
> ###### https://developer.apple.com/documentation/uikit/uiviewcontroller
- ##### UIKit 앱의 뷰 계층 구조를 관리하는 개체

<br>
<br>

### UIViewController의 타입
- #### 1. Content View Controller
###### 일반적으로 흔히 보는 인터페이스 빌더로 생성시 기본으로 생성되는 ViewController이다.
###### 앱의 컨텐트의 일부분을 관리하는 뷰컨, 자신의 모든 뷰를 스스로 관리한다.

<br>

- ##### 2. ContainerViewController
###### NavigationViewController, TabBarViewController 처럼 여러 개의 View Controller를 제어하는 뷰 컨트롤러이다.
###### 다른 뷰 컨트롤러들로부터 정보를 모으고, root view를 관리한다.
###### 직접 자식 뷰컨의 컨텐츠를 관리하지는 않고, root view의 크기조절과 위치조절에 대해서만 관리한다.

<br>
<br>

### UIViewController의 역할
- ##### 1. 데이터 변화에 따른 view 업데이트
- ##### 2. view와 함께 사용자와의 상호작용에 응답한다. (이벤트 핸들링)
- ##### 3. view를 리사이징하고 전체적인 인터페이스의 레이아웃 관리
- ##### 4. 다른 객체(뷰컨트롤러 등)들과 함께 앱을 구성한다.

<br>
<br>

### UIViewController Lifecycle
###### 앱이 실행되는 동안 ViewController들이 만들어지고 사라지면 화면을 띄우고 내리는 작업을 수행한다.
###### 이러한 일련의 과정들은 event에 의해 메소드가 호출됨으로써 진행되게 된다.

<img width="876" alt="스크린샷 2022-02-08 오후 4 11 52" src="https://user-images.githubusercontent.com/71479613/152936372-b000d23e-c7c3-4869-b334-d8978d825f73.png">

<br>

- ##### viewDidLoad()
<br>

- ##### viewWillAppear()
<br>

- ##### viewDidAppear()
<br>

- ##### viewWillDisAppear()
<br>

- ##### viewDidDisAppear()

<br>
<br>


https://melod-it.gitbook.io/sagwa/app-frameworks/uikit/view-controllers/uiviewcontroller
https://o-o-wl.tistory.com/43
https://baked-corn.tistory.com/32