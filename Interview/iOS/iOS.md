## iOS 면접질문 정리

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

- ### 앱의 콘텐츠나 데이터 자체를 저장/보관하는 특별한 객체를 무엇이라고 하는가?
##### Core Data입니다. Core Data는 객체를 관리하는데 사용되는 프레임워크이자 객체의 라이프 사이클이나 영속성 관리를 위한 기능을 제공하는 객체 그래프 관리자입니다.

<br>
<br>

- ### 앱 화면의 콘텐츠를 표시하는 로직과 관리를 담당하는 객체를 무엇이라고 하는가?
##### UIViewController입니다. UIViewController는 데이터 변화에 따라 view를 업데이트하고 view와 함께 사용자와의 상호작용에 응답합니다. 또한 view를 리사이징하고 레이아웃을 관리하며 다른 뷰컨트롤러와 함께 앱을 구성합니다.

<br>
<br> 

- ### App thinning에 대해서 설명하시오.
##### 앱 스토어와 운영체제가 사용자의 기기 환경에 맞게 앱의 설치를 최적화 하는 것 입니다. App thinning을 통해 최소한의 디스크 사용과 빠른 다운로드를 제공할 수 있으며 기술 구성요소로는 슬라이싱, 비트코드, ODR이 있습니다.

- ###### 슬라이싱이란 앱이 지원하는 여러 디바이스에 대해 각각 조각 애플리케이션 번들을 생성하고, 해당 디바이스에 가장 적합한 조각을 전달하는 기술입니다.
<br>

- ###### 비트코드란 기계언어로 변역되기 이전 단계의 중간단계 코드를 말합니다. 비트코드와 같은 중간언어는 다양한 방식으로 다시 컴파일하는데 사용할 수 있는 앱의 추상 인코딩으로, 앱스토어가 각 환경 별 바이너리를 생성하는데 사용합니다.

<br>

- ###### ODR란 유저가 요청할 때 앱스토어에서 더 많은 리소스를 가져오는 것 입니다. 앱스토어에 IPA와 별도로 저장되며, 기기의 앱 번들에 저장되지 않고, 시스템에서 관리되는 메모리에 저장되기 때문에 여러 앱에서 ODR을 캐싱할 수 있습니다.

<br>
<br>

- ### View 객체에 대해 설명하시오.
##### View는 UIView 또는 UIView 하위 클래스의 인스턴스입니다. 이 공간에는 여러가지 요소들이 담길 수 있고, 여러 components를 보여주는 용도로도 사용됩니다. frame, bounds를 사용하여 사이즈와 위치를 지정할 수 있습니다. 또한 터치와 같은 이벤트를 처리할 수 있습니다.

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
##### Foreground mode는 메모리 및 기타 시스템 리소스에 높은 우선순위를 가지며 시스템은 이러한 리소스를 사용할 수 있도록 필요에 따라 background 앱을 종료합니다. background mode는 가능한 적은 메모리 공간을 사용해야합니다.

<br>
<br>

- ### 상태 변화에 따라 다른 동작을 처리하기 위한 앱델리게이트 메서드들을 설명하시오.
##### 앱이 처음 시작될 때 application(_:didFinishLaunching:) 메서드가 실행됩니다. 앱이 active에서 inactive로 이동될 때 applicationWillResignActive: 메서드가 실행되며

<br>
<br>

- ### 앱이 In-Active 상태가 되는 시나리오를 설명하시오.
##### 특정 알림창이 화면을 덮어서 앱이 실질적으로 사용자의 event를 받지 못할때 In-Active 상태가 됩니다.

<br>
<br>

- ### scene delegate에 대해 설명하시오.
##### iOS 13부터 window의 개념이 scene으로 대체되고 하나의 앱에서 여러개의 scene을 가질 수 있게 되면서 SceneDelegate가 등장하였다. SceneDelegate는 기존의 AppDelegate 역할이었던 UILifeCycle에 대한 부분을 SceneDelegate가 하게 되었으며, 화면에 무엇(scene/window)을 보여줄지 관리하는 역할을 합니다.

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

<br>ㅌ
<br>

- ### prepareForReuse에 대해서 설명하시오.
##### 셀은 재사용 되었지만, 셀 안에 들어가는 데이터의 조건은 각각 다를 수 있기때문에 재사용 셀을 사용할 때에는 반드시 초기화하는 과정이 필요한데, 그때 사용하는 함수가 prepareForReuse입니다.

<br>
<br>

- ### TableView를 동작 방식과 화면에 Cell을 출력하기 위해 최소한 구현해야 하는 DataSource 메서드를 설명하시오.
##### 섹션안에 있는 행의 개수를 지정하기위해 numberOfRowsInSection 메서드를 구현해야하고 특정 위치에 삽입할 셀의 데이터 소스를 요청하기 위해 cellForRowAt 메서드를 구현해야합니다.

<br>
<br>

- ### UIWindow 객체의 역할은 무엇인가?
##### UIWindow는 사용자 인터페이스에 배경을 제공하고, 이벤트 처리 행동을 제공합니다.
<br>
<br>

- ### 모든 View Controller 객체의 상위 클래스는 무엇이고 그 역할은 무엇인가?
##### UIViewController입니다. UIViewController는 뷰와 사용자 상호 작용에 응답하고, 뷰의 콘텐츠를 업데이트하고 인터페이스의 레이아웃을 관리합니다.
<br>
<br>

- ### UIView 에서 Layer 객체는 무엇이고 어떤 역할을 담당하는지 설명하시오.
##### UIView는 화면에 그리는 작업과 애니메이션 등의 시각적 행위를 직접 처리하지 않고 Core Animation 클래스인 CALayer에게 위임하는데, 모든 UIView는 해당 타입의 layer 프로퍼티를 가지고 있다. Layer는 그림자, 테두리, 3D변형, 마스킹, 애니메이션 등의 작업을 처리한다.
<br>
<br>

- ### Foundation은 무엇이고 포함되어 있는 클래스들은 어떤 것이 있는지 설명하시오.
##### Cocoa Touch Framework에 포함된 Foundation은 String, Int, Double과 같은 원시 데이터 타입 Array, Dictionary, Set과 같은 컬렉션 타입 및 운영체제 서비스를 사용해 애플리케이션의 기본적인 기능을 관리하는 프레임워크입니다. Data Formatting이나 Filter Sorting과 같은 작업도 지원하며 파일 및 데이터 관리, 네트워킹 작업도 지원합니다.
<br>
<br>


- ### Delegate란 무언인가 설명하고, retain 되는지 안되는지 그 이유를 함께 설명하시오.
##### Delegate은 객체지향 프로그래밍에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리해야 할 일 중 일부를 다른 객체에 넘기는 것입니다. Delegate는 객체 간의 작업이기 때문에 참조값을 사용합니다. 따라서 retain이 된다고 할 수 있습니다.
<br>
<br>

- ### UINavigationController 의 역할이 무엇인지 설명하시오.
##### 네비게이션 스택을 이용하여 다른 뷰 컨트롤러를 관리합니다. container view controller로 계층구조로 구성된 content를 순차적으로 보여줍니다. 또 네비게이션 바 또는 툴바를 보여줄 수 있습니다. LIFO방식으로 네비게이션바를 통해 뷰를 이동할 때 스택 구조로 쌓입니다.
<br>
<br>

- ### 하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.
##### UITableViewCell 에서 파라미터로 받는 tableView를 객체 비교를 통해 구분하거나 테이블 뷰의 Tag를 등록, 비교해서 구분합니다.
<br>
<br>

- ### 자신만의 Custom View를 만들려면 어떻게 해야하는지 설명하시오.
##### Xib를 이용하거나 코드로 작성하는 방법이 있습니다. xib 파일과 연결할 Swift파일을 생성한 후 Xib의 File's Owner에 Swift 파일을 연결하고 Custom View를 구성한 뒤 Swift파일에서 초기화를 진행한 후 사용합니다. 코드로는 UIView를 상속받는 클래스를 생성해 코드로 원하는 작업들을 설정합니다. 
<br>
<br>

- ### App Bundle의 구조와 역할에 대해 설명하시오.
##### 실제 앱 이름에서 .app 확장자를 뗀 MyApp 실행파일이 있다. 그리고 홈 화면이나 앱이 보여질 때 가장 먼저 보여지는 Application icons가 있다. 번들 ID, 버전 넘버, 디스플레이 네임과 같은 앱의 정보를 담고있는 info.plist파일과 앱의 initial interface를 보여주는 Launch Images와 런치타임에 앱을 로드하기 위한 기본 인터페이스 오브젝트를 포함한 MainWindow.nib파일과 Settings.bundle, Custom resource files이 있씁니다.
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
##### 동기는 요청에 대한 응답이 동시에 발생해야 한다 즉, 내 작업이 끝나기 전까진 다른 작업을 수행하지 못하는 것이다. 비동기는 요청에 대한 응답이 동시에 발생하지 않는다. 즉, 내 작업이 끝나지 전에 다음 작업을 실행하는 것이다.
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
##### 먼저 UIKit의 속성을 Thread-safe하게 설계하면, 성능저하가 발생할 수 있기 때문에 그렇게 설계할 수 없습니다. 런루프가 뷰의 업데이트를 관리하는 View Drawing Cycle을 통해 뷰를 동시에 업데이트 하는데, 만약 Background Thread에서 각자의 런루프로 업데이트 하게 되었을 때, View가 제멋대로 동작할 수 있습니다. 또 iOS가 그림을 그리는 렌더링 프로세스가 있는데 여러 쓰레듣에서 각자의 뷰의 변경사항을 GPU로 보내면 GPU는 각각의 정보를 다 해석해야하니 비효율적입니다.
<br>
<br>

- ### iOS의 렌더링 프로세스를 설명하시오.
##### CoreAnimation, Render Server, GPU, Present의 순서로 진행됩니다.

- ### Run Loop를 설명하시오.
#####
<br>
<br>

- ### View Drawing Cycle를 설명하시오.
#####
<br>
<br>

- ### setNeedsLayout와 setNeedsDisplay의 차이에 대해 설명하시오.
#####
<br>
<br>


- ### NSOperationQueue 와 GCD Queue 의 차이점을 설명하시오.
#####
<br>
<br>

- ### GCD API 동작 방식과 필요성에 대해 설명하시오.
<br>
<br>

- ### Global DispatchQueue 의 Qos 에는 어떤 종류가 있는지, 각각 어떤 의미인지 설명하시오.
<br>
<br>

- ### NotificationCenter 동작 방식과 활용 방안에 대해 설명하시오.
<br>
<br>

- ### NSCache와 딕셔너리로 캐시를 구성했을때의 차이를 설명하시오.
<br>
<br>

- ### URLSession에 대해서 설명하시오.
<br>
<br>

- ### 다크모드를 지원하는 방법에 대해 설명하시오.
<br>
<br>

