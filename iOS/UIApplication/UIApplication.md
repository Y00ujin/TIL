## UIApplication

<br>
<br>

### UIApplication
##### 들어오는 사용자 이벤트의 초기 라우팅을 처리한다.
##### 컨트롤 객체(UIControl의 인스턴스)가 적절한 target 객체에 전달한 action 메세지를 전달한다.
##### application 객체는 열린 window(UIWindow의 객체)의 목록을 유지관리하며 이를 통해 앱의 UIView 객체를 검색할 수 있다.
##### UIApplication class는 UIApplicationDelegate 프로토콜을 준수하고, 일부 프로토콜 메소드를 구현해야하는 delegate를 정의한다.
##### application 객체는 delegate에게 중요한 런타임 이벤트(앱 시작, 메모리 부족 경고, 앱 종료)를 알리고, 적절히 응답 할 기회를 제공한다.