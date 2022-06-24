## iOS 면접질문 정리
<br>
<br>
<br>


- ### 런타임(Runtime)과 컴파일타임(Compiletime), 컴파일에러, 런타임에러에 대해 설명하시오.
##### 개발자가 작성한 소스코드는 기계어 코드로 변환 되어 실행 가능한 프로그램이 되는데, 이러한 편집과정을 컴파일 타임이라고 합니다. 컴파일 과정을 마친 프로그램은 사용자에 의해 실행되어지며, 이러한 응용프로그램이 동작되어지는 때를 런타임이라고 합니다. 컴파일에러는 프로그램이 성공적으로 컴파일링되는 것을 방해하는 신택스에러나 파일참조 오류와 같은 문제를 말하며, 이런 경우 컴파일러는 컴파일[에러를 발생시키고 일반적으로 문제를 일으킨 소스코드 라인을 지시해줍니다. 만약 어떤 소스코드가 이미 실행가능한 프로그램으로 컴파일 되었다 할지라도 이것은 여전히 프로그램의 실행중에 버그를 일으킬 수 있습니다. 예상치 못한 오류 또는 충돌로 동작하지 않을 수 있는데, 이렇게 프로그램이 실행중에 발생하는 형태의 오류를 런타임오류라고 합니다.
<br>
<br>

- ### MVC에 대해 설명하시오.
##### 일반적인 MVC 패턴은 Controller가 다리 역할이 되어 View의 입력을 Model에 반영하고 Model의 변화에 맞게 View를 갱신합니다. 이때 Model은 프로그램에서 사용되는 실제 데이터 및 데이터 조작 로직을 처리하는 부분이며 View는 사용자에게 제공되어 보여지는 UI, Controller는 사용자의 입력을 받고 처리하는 부분입니다. 하지만 실제 Apple에서의 MVC는 View와 Controller가 강하게 연결되어있기 때문에 ViewController가 거의 모든 일을 하게 되어있습니다. 이러한 MVC패턴은 설계가 단순하기 때문에 가장 쉽고 빠르게 개발이 가능하며 애플에서 MVC를 지향하고있기 때문에 기본 LifeCycle에 맞는 개발이 가능하지만 Controller의 역할이 방대해져서 모듈화하는 부분이 무의미해질 수 있습니다.
<br>
<br>

- ### MVVM에 대해 설명하시오.
##### 
<br>
<br>

- ### MVP에 대해 설명하시오.
##### 
<br>
<br>

- ### VIPER에 대해 설명하시오.
##### 
<br>
<br>

- ### VIP에 대해 설명하시오.
##### 
<br>
<br>

- ### Bounds와 Frame의 차이점을 설명하시오.
##### Bounds와 Frame 둘다 CGRect 타입으로 동일하지만 Bounds는 superView즉 자신의 부모뷰를 기준으로 origin(좌표)을 나타내고, Frame은 자기 자신만의 좌표계를 기준으로 origin(좌표)를 나타냅니다.
<br>
<br>

- ### 실제 디바이스가 없을 경우 개발 환경에서 할 수 있는 것과 없는 것을 설명하시오.
##### Simulator를 사용할 시에는 카메라나 마이크, 전화, 블루투스 기능을 이용할 수 없고 줌인 줌아웃 등의 기능을 테스트할 수 없습니다. 또한 GPS나 가속도, 가압계, 주변광 센서 기능을 이용할 수 없습니다. 페이스 아이디를 통한 얼굴인식은 불가능하지만 인식 여부 처리는 가능합니다. Handoff, MessageUI 기능 또한 지원하지 않습니다. 의외로 BackgroundMode 기능은 사용할 수 있으며 메모리 사용량이나 CPU를 체크할 수 있고 UI 레이아웃 테스트도 가능합니다.
<br>
<br>

- ### 앱 화면의 콘텐츠를 표시하는 로직과 관리를 담당하는 객체를 무엇이라고 하는가?
##### UIViewController입니다. UIViewController는 데이터 변화에 따라 view를 업데이트하고 view와 함께 사용자와의 상호작용에 응답합니다. 또한 view를 리사이징하고 레이아웃을 관리하며 다른 뷰컨트롤러와 함께 앱을 구성합니다.

<br>
<br> 

- ### App thinning에 대해서 설명하시오.
##### 앱 스토어와 운영체제가 사용자의 기기 환경에 맞게 앱의 설치를 최적화 하는 것 입니다. App thinning을 통해 최소한의 디스크 사용과 빠른 다운로드를 제공할 수 있으며 기술 구성요소로는 슬라이싱, 비트코드, ODR이 있습니다.
<br>
<br>

- ### 슬라이싱을 설명하시오.
##### 슬라이싱이란 앱이 지원하는 여러 디바이스에 대해 각각 조각 애플리케이션 번들을 생성하고, 해당 디바이스에 가장 적합한 조각을 전달하는 기술입니다.

<br>
<br>

- ### 비트코드를 설명하시오.
##### 비트코드란 기계언어로 변역되기 이전 단계의 중간단계 코드를 말합니다. 비트코드와 같은 중간언어는 다양한 방식으로 다시 컴파일하는데 사용할 수 있는 앱의 추상 인코딩으로, 앱스토어가 각 환경 별 바이너리를 생성하는데 사용합니다.
<br>
<br>

- ### ODR에 대해 설명하시오.
##### ODR란 유저가 요청할 때 앱스토어에서 더 많은 리소스를 가져오는 것 입니다. 앱스토어에 IPA와 별도로 저장되며, 기기의 앱 번들에 저장되지 않고, 시스템에서 관리되는 메모리에 저장되기 때문에 여러 앱에서 ODR을 캐싱할 수 있습니다.
<br>
<br>

- ### View 객체에 대해 설명하시오.
##### View는 UIView 또는 UIView 하위 클래스의 인스턴스입니다. 이 공간에는 여러가지 요소들이 담길 수 있고, frame, bounds를 사용하여 사이즈와 위치를 지정할 수 있습니다. 또한 터치와 같은 이벤트를 처리할 수 있습니다.
<br>
<br>

- ### 앱이 시작할 때 main.c 에 있는 UIApplicationMain 함수에 의해서 생성되는 객체는 무엇인가?
##### UIApplicationMain 함수는 싱글톤 UIApplication 객체를 생성합니다. 그 후 공유 클래스 메서드를 호출하여 객체에 접근합니다.
<br>
<br>

- ### @Main에 대해서 설명하시오.
##### Swift 기반으로 된 iOS 프로젝트는 main.c파일이 없는대신 @main을 선언하여 iOS 앱의 진입점을 컴파일러가 합성합니다. @Main을 선언해줌으로써, UIKit 앱의 진입점은 해당 클래스임을 암시합니다. Swift 5.3부터 프로그램의 entry point를 알려주는 속성이 @UIApplicationMain에서 @main으로 변경되었습니다.
<br>
<br>

- ### 앱이 foreground에 있을 때와 background에 있을 때 어떤 제약사항이 있나요?
##### Foreground mode는 메모리 및 리소스에 높은 우선순위를 가지며 시스템은 이러한 리소스를 사용할 수 있도록 필요에 따라 background 앱을 종료합니다. background mode는 가능한 적은 메모리 공간을 사용해야합니다.
<br>
<br>

- ### 앱이 In-Active 상태가 되는 시나리오를 설명하시오.
##### 특정 알림창이 화면을 덮어서 앱이 실질적으로 사용자의 event를 받지 못할때 In-Active 상태가 됩니다.

<br>
<br>

- ### scene delegate에 대해 설명하시오.
##### iOS 13부터 window의 개념이 scene으로 대체되고 하나의 앱에서 여러개의 scene을 가질 수 있게 되면서 SceneDelegate가 등장하였습니다. SceneDelegate는 기존의 AppDelegate 역할이었던 UILifeCycle에 대한 부분을 SceneDelegate가 하게 되었으며, 화면에 무엇(scene/window)을 보여줄지 관리하는 역할을 합니다.

<br>
<br>

- ### App의 Not running, Inactive, Active, Background, Suspended에 대해 설명하시오.
##### Not running은 앱이 아예 실행되지 않았거나 시스템에 의해 종료되었을 때의 상황입니다. Inactive는 앱이 foreground 상태이기는 하나 이벤트를 받지 못한 상태입니다. Active는 앱이 foreground에서 실행 중이며 이벤트를 받았을 때의 상황입니다. background는 앱이 background에 있으며 코드를 실행하고 있는 상태입니다. suspended는 앱이 background에 있으며 앱이 메모리에 남아있긴 하나 코드를 실행하고있지 않은 상태입니다.

<br>
<br>

- ### iOS 앱을 만들고, User Interface를 구성하는 데 필수적인 프레임워크 이름은 무엇인가?
##### UIKit 입니다.

<br>
<br>

- ### ViewController의 생명주기를 설명하시오.
##### 먼저 loadView()를 통해 화면에 띄워줄 view를 생성하거나 불러와 메모리에 로드합니다. 뷰컨트롤러가 메모리에 로드되고 난 후 viewDidLoad가 호출되고 뷰가 로드 된 후 뷰가 나타기 직전 viewWillAppear가 호출됩니다. 뷰가 화면에 나타난 직후에 viewDidAppear가 호출되고, 뷰가 사라지기 직전 viewWillDisappear가 호출됩니다. 뷰가 사라지면 viewDidDisappear가 호출됩니다.

<br>
<br>

- ### TableView와 CollectionView의 차이점을 설명하시오.
##### TableView는 리스트 형식으로 데이터를 표현하고 수직 스크롤만 가능하고 CollectionView는 그리드와 스택, 타일 등 다양한 방식으로 데이터 표현이 가능하고 수직/수평 스크롤이 모두 가능합니다.

<br>
<br>

- ### prepareForReuse에 대해서 설명하시오.
##### 셀은 재사용 되었지만, 셀 안에 들어가는 데이터의 조건은 각각 다를 수 있기때문에 재사용 셀을 사용할 때에는 반드시 초기화하는 과정이 필요하고, 그때 사용하는 함수가 prepareForReuse입니다.

<br>
<br>

- ### TableView Cell을 화면에  출력하기 위해 최소한 구현해야 하는 DataSource 메서드를 설명하시오.
##### 섹션안에 있는 행의 개수를 지정하기위해 numberOfRowsInSection 메서드를 구현해야하고 특정 위치에 삽입할 셀의 데이터 소스를 요청하기 위해 cellForRowAt 메서드를 구현해야합니다.

<br>
<br>

- ### UIWindow 객체의 역할은 무엇인가?
##### UIWindow는 사용자 인터페이스에 배경을 제공하고, 이벤트 처리 행동을 제공합니다.
<br>
<br>

- ### 모든 View Controller 객체의 상위 클래스는 무엇이고 그 역할은 무엇인가?
##### UIViewController입니다. UIViewController는 뷰와 사용자 상호 작용에 응답하고, 뷰의 콘텐츠를 업데이트하며 인터페이스의 레이아웃을 관리합니다.
<br>
<br>

- ### clipsToBounds, masksToBounds를 설명하고 차이를 설명하시오.
##### clipsToBounds는 UIView에 속해있으며 subview들이 view의 bounds에 가둬질 수 있는 지를 판단하는 Boolean 값입니다. 즉, true로 설정하면 subview가 view의 경계를 넘어갈 시 잘리며 false로 설정하면 경계를 넘어가도 잘리지 않게 되는 것입니다. masksToBounds는 CALayer에 속해있으며 subLayer가 view의 바깥 영역에서 그려져도 되는지를 판단하는 Boolean 값입니다. false로 설정할 시에는 superlayer 영역 이외의 subLayer도 draw 하고, true로 설정할 시에는 superlayer 영역 이외의 sublayer는 draw하지 않습니다. 
<br>
<br>

- ### UIView 에서 Layer 객체는 무엇이고 어떤 역할을 담당하는지 설명하시오.
##### CALayer는 Core Animation에 속해있으며, UIView는 시각적 행위를 직접 처리하지 않고 CALayer에게 위임합니다. 모든 UIView는 layer 프로퍼티를 가지고 있으며 Layer를 사용하여 그림자, 테두리, 3D변형, 마스킹, 애니메이션 등의 작업을 처리할 수 있습니다.
<br>
<br>

- ### Foundation은 무엇이고 포함되어 있는 클래스들은 어떤 것이 있는지 설명하시오.
##### Foundation은 String, Int, Double과 같은 원시 데이터 타입과 Array, Dictionary, Set과 같은 컬렉션 타입을 제공하며 운영체제 서비스를 사용해 애플리케이션의 기본적인 기능을 관리하는 프레임워크입니다. Data Formatting이나 Filter, Sorting과 같은 작업도 지원하며 파일 및 데이터 관리, 네트워킹 작업도 지원합니다.
<br>
<br>


- ### Delegate란 무언인가 설명하고, retain 되는지 안되는지 그 이유를 함께 설명하시오.
##### Delegate은 하나의 객체가 처리해야 할 일 중 일부를 다른 객체에 넘기는 것입니다. Delegate는 객체 간의 작업이기 때문에 참조값을 사용합니다. 따라서 retain이 된다고 할 수 있습니다.
<br>
<br>

- ### ViewController의 종류에 대해 설명하시오.
##### 일반적으로 UIViewController를 직접 서브클래싱하여 생성하는 Content View Controller가 있습니다. 이 ViewController는 뷰 리사이징, 레이아웃 관리, 다른 객체들과 상호작용, 유저 인터랙션 처리 등의 역할을 수행합니다. Container View Controller는 다른 뷰 컨트롤러로부터 정보를 수집하거나 뷰 사이의 이동을 돕는 역할을 합니다. UIKit에서 제공하는 UITabBarController, UINavigationController, UIPageViewController 등이 모두 Container view controller입니다.
<br>
<br>

- ### UINavigationController 의 역할이 무엇인지 설명하시오.
##### UINaviagtionController는 Stack기반의 containerViewController이고, 1개 이상의 ViewController를 관리할 수 있습니다. Stack기반이므로 최상단에 있는 하나의 ViewController만이 보여지게 되고 ViewController를 push혹은 pop을 통해 보여질 ViewController를 결정하게 됩니다. 네비게이션 바 또는 툴바를 보여줄 수도 있습니다.
<br>
<br>

- ### 하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.
##### 파라미터로 받는 tableView를 객체 비교를 통해 구분하거나 테이블 뷰의 Tag를 설정하고 비교하여 구분합니다.
<br>
<br>

- ### 자신만의 Custom View를 만들려면 어떻게 해야하는지 설명하시오.
##### Xib를 이용하거나 코드로 작성하는 방법이 있습니다. xib 파일과 연결할 Swift파일을 생성한 후 Xib와 Swift 파일을 연결하고 Custom View를 구성한 뒤 Swift파일에서 초기화를 진행한 후 사용합니다. 코드로는 UIView를 상속받는 클래스를 생성해 코드로 원하는 작업들을 설정합니다. 
<br>
<br>

- ### App Bundle의 구조와 역할에 대해 설명하시오.
##### 실제 앱 이름에서 .app 확장자를 뗀 MyApp 실행파일이 있습니다. 그리고 홈 화면이나 앱이 보여질 때 가장 먼저 보여지는 Application icons가 있습니다. 번들 ID, 버전 넘버, 디스플레이 네임과 같은 앱의 정보를 담고있는 info.plist파일과 앱의 initial interface를 보여주는 Launch Images와 런치타임에 앱을 로드하기 위한 기본 인터페이스 오브젝트를 포함한 MainWindow.nib파일과 Settings.bundle, Custom resource files이 있습니다.
<br>
<br>

- ### UIKit 클래스들을 다룰 때 꼭 처리해야하는 애플리케이션 쓰레드 이름은 무엇인가?
##### Main Thread이다.
<br>
<br>

- ### iOS의 계층구조를 설명하시오
##### Application, 화면의 그래픽 UI및 터치의 기능을 제공하는 Cocoa Touch 와 그래픽이나 오디오, 비디오 등 멀티미디어 기능을 제공하는 Media, GPS 나침반, 가속도 센서 등 하드웨어적 기능들이 제공되는 Core Service, 데이터 처리, 네트워크, 파일 접근등의 기능을 수행하는 Core OS로 구성되어있습니다.
<br>
<br>

- ### iOS의 Thread 종류를 설명하시오.
##### iOS의 Thread에는 Main Thread, Global Thread가 있습니다. 먼저 Main Thread은 오직 한 개만 존재하며 개발자가 일반적으로 작성한 코드가 여기서 동작합니다. 왜냐면 작성된 코드가 Cocoa에서 실행되는데, 이 Cocoa가 코드를 Main Thread에서 호출하기 때문입니다. 또 이 Main Thread는 Main Queue에서 실행되는데 이 Main Queue는 Serial Queue입니다. Global Thread는 주로 화면에 나타나지 않는 작업을 담당한다. Global Thread는 Global Queue에서 실행되며, 이 Global Queue는 Concurrent Queue입니다.
<br>
<br>

- ### Serial Queue와 Concurrent Queue를 설명하시오.
##### Serual Queue는 작업을 다른 한개의 스레드에서 처리하는 큐입니다. Concurrent는 작업을 다른 여러개의 스레드에서 처리하는 큐입니다.
<br>
<br>

- ### Synchronous와 Asynchronous를 설명하시오.
##### 동기는 요청에 대한 응답이 동시에 발생해야 합니다. 즉, 내 작업이 끝나기 전까진 다른 작업을 수행하지 못하는 것입니다. 비동기는 요청에 대한 응답이 동시에 발생하지 않습니다. 즉, 내 작업이 끝나지 전에 다음 작업을 실행하는 것입니다.
<br>
<br>

- ### atomic과 nonatomic을 설명하시오.
##### atomic은 멀티 쓰레드 환경에서, 한 쓰레드가 프로퍼티의 값을 변경하고있을 때 다른 쓰레드들은 접근할 수 없게 Lock 기능을 제공하는 것입니다. 어떤 프로퍼티를 두 개의 스레드가 참조하고 있는 상황에서 atomic하지 않다면 값을 읽고 쓰는데 있어서 오류가 발생할 수 있습니다. 이런 경우에는 atomic하게 설정해야합니다. 이 경우는 일반적인 경우에는 고려할 필요가 없으며 성능을 저하시킬 수 있으므로 대부분 nonatomic으로 선언합니다.
<br>
<br>

- ### Thread Safe를 설명하시오.
##### 멀티 스레드 프로그래밍에서 일반적으로 어떤 함수나 변수, 혹은 객체가 여러 스레드로부터 동시에 접근이 이루어져도 프로그램의 실행에 문제가 없음을 뜻합니다. 하나의 함수가 한 스레드로부터 호출되어 실행 중일 때, 다른 스레드가 그 함수를 호출하여 동시에 함께 실행되더라도 각 스레드에서의 함수의 수행 결과가 올바로 나오는 것으로 정의합니다.
<br>
<br>

- ### UI 작업을 Main Thread에서 해야하는 이유를 설명하시오.
##### 먼저 UIKit의 속성을 Thread-safe하게 설계하면, 성능저하가 발생할 수 있기 때문에 그렇게 설계할 수 없습니다. (정보추가) 메인 런루프가 뷰의 업데이트를 관리하는 View Drawing Cycle을 통해 뷰를 동시에 업데이트 하는데, 만약 Background Thread에서 각자의 런루프로 업데이트 하게 되었을 때, View가 제멋대로 동작할 수 있습니다. 또 iOS가 그림을 그리는 렌더링 프로세스가 있는데 여러 쓰레드에서 각자의 뷰의 변경사항을 GPU로 보내면 GPU는 각각의 정보를 다 해석해야하니 비효율적입니다.
<br>
<br>

- ### iOS의 렌더링 프로세스를 설명하시오.
##### CoreAnimation, Render Server, GPU, Present의 순서로 진행됩니다.
<br>
<br>

- ### Run Loop를 설명하시오.
##### Run Loop는 입력 소스를 처리하는 이벤트 처리 루프입니다. Thread를 생성할 때 RunLoop가 생성되며 비동기 이벤트인 Input Source와 동기 이벤트인 Timer Source를 수신합니다. Main Thread에서는 자동으로 Main Run Loop를 설정하고 실행하지만 Global Thread에서는 직접 RunLoop를 실행해야합니다.
<br>
<br>

- ### URLSession에 대해서 설명하시오.
##### URLSession은 iOS에서 제공하는 HTTP를 이용한 네트워킹을 통해 데이터를 주고받을 수 있게 도와주는 API를 제공하는 클래스입니다. URLSession은 Thread-Safty하기 때문에 어떤 스레드에서든 자유롭게 Session과 Task를 생성할 수 있습니다.
<br>
<br>

- ### ARC란 무엇인지 설명하시오.
##### ARC는 Automatic Referencing Counting의 준말으로 메모리의 참조 카운트를 자동으로 관리해주는 애플의 메모리 관리 기법입니다. ARC는 컴파일 타임에 자동으로 retain, release 등을 코드에 삽입하고, 런타임 때 이들을 실행하여 reference count를 증감시킵니다. reference count가 0이 되면 deinit을 통해 메모리에서 해제합니다.
<br>
<br>

- ### Retain Count 방식에 대해 설명하시오.
##### 인스턴스를 생성한 후, retain 메소드를 사용하여 수동으로 Retain Count를 증가시킵니다.
<br>
<br>


- ### Strong 과 Weak 참조 방식에 대해 설명하시오.
##### Strong은 해당 인스턴스의 소유권을 가지며 자신이 참조하는 인스턴스의 retain count를 증가시킵니다. 값 지정 시점에 retain이 되고, 참조가 종료되는 시점에 release가 됩니다. 선언할 때 아무것도 적어주지 않으면 default로 strong이 되며, 메모리 누수가 발생할 수 있으므로 적절히 사용해야합니다. 메모리 누수를 방지하는 해결책이 바로 Weak 참조 방식입니다. Weak은 해당 인스턴스의 소유권을 가지지 않고, 주소값만 가지고 있는 포인터 개념입니다. 자신이 참조하는 인스턴스의 retain Count를 증가시키지 않으며, 변수로만 사용하고 자신이 참조하던 인스턴스가 메모리에서 해제된다면 nil이 될 수 있으므로 옵셔널로 선언해야합니다.
<br>
<br>


- ### 순환 참조에 대하여 설명하시오.
##### 순환 참조란 두 가지 이상의 객체가 서로에 대한 Strong Reference상태를 가지고 있을 때 발생하며, 순환 참조가 발생하게 되면 서로에 대한 참조가 해제되지 않기 때문에 메모리에서 유지되며 이로 인해 메모리 릭이 발생하게 됩니다.
<br>
<br>


- ### 강한 순환 참조 (Strong Reference Cycle) 는 어떤 경우에 발생하는지 설명하시오.
##### 클래스 인스턴스가 강한참조의 카운트가 0이 되는 시점을 얻지 못하는 코드를 작성할 가능성이 있습니다. 이는 두개의 클래스 인스턴스들이 서로를 붙잡고 있을 때 발생할 수 있으며 이때 두개의 인스턴스는 계속 메모리 상에서 유지됩니다. 
<br>
<br>


- ### Swift Standard Library의 map, filter, reduce, compactMap, flatMap에 대하여 설명하시오.
##### Map은 Sequence, Collection 프로토콜을 따르는 타입은 모두 사용할 수 있으며, 맵을 사용하면 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환합니다. 기존의 컨테이너의 값은 변경되지 않고 새로운 컨테이너가 생성되어 반환됩니다. 기존의 for-in구문과 유사하지만 map을 사용하면 코드가 간결해지고 재사용이 용이합니다. 
```Swift
var a = ["a","b"]

print(a) // ["a","b"]
print(a.map{$0.uppercased()}) // ["A","B"]
```
<br>

##### filter는 컨테이너 내부의 값을 걸러서 추출하는 역할을 합니다. 맵과 마찬가지로 새로운 컨테이너의 값을 담아 변환합니다. 이 함수의 매개변수 isIncluded는 요소가 반환된 배열에 포함되어야 하는지 여부를 나타내는 부울 값을 반환하는 클로저입니다.
<br>

##### reduce는 컨테이너 내부의 요소들을 하나로 합치는 기능을 하는 고차합수입니다.
<br>

##### compactMap은 map과 동일하게 컨테이너 안의 값으로 작업을 수행하고 다시 포장하여 반환하는데 nil이 아닌 값들만 반환합니다.
<br>

##### flatMap은 시퀀스의 각 요소들에 매개변수로 전달된 클로저를 적용하여 연속적인 값을 가지는 배열을 반환합니다. 즉, 일차원 컬렉션으로 반환받고자 할 때 사용합니다.

<br>
<br>

- ### ARC 대신 Manual Reference Count 방식으로 구현할 때 꼭 사용해야 하는 메서드들을 쓰고 역할을 설명하시오.
##### 인스턴스를 새로 생성하는 경우를 제외하고 RC값이 증가해야 할 때 Retain을 사용해주어야 하며 Reference count가 감소되는 시점에 Release를 사용해주어야 합니다.
<br>
<br>