## UIApplicationMain()

<br>
<br>

### UIApplicationMain() 
##### 앱이 시작되면 시스템은 UIApplicationMain(_:_:_:_:)함수를 호출한다. 이 함수는 다른 task들 중에서 싱글톤 UIApplication객체를 만든다.
##### 그런 다음, shared클래스 메소드를 호출하여 객체에 접근한다.
##### application객체와 application delegate를 만들고 이벤트 사이클을 설정하는 역할을 가지고 있습니다.

<br>
<br>

### UIApplicationMain()의 파라미터
##### 1. argc
- ###### argv의 개수, 대게 main에 해당하는 파라미터입니다.
##### 2. argv
- ###### argument의 변수 목록, 대게 main에 해당하는 파라미터입니다.
##### 3. prinsipalClassName
- ###### UIApplication클래스 또는 하위 클래스의 이름입니다. nil을 지정하면 UIApploication으로 가정됩니다.
##### 4. delegateClassName
- ###### application delegate가 인스턴스화 되는 클래스 이름입니다.

<br>
<br>