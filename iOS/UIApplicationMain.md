## UIApplicationMain()

<br>
<br>

> #### swift 5.3 부터는 @main 그 이전엔 @UIApplication 이라는 attribute를 사용하는데, 앱이 처음 실행되면 시스템은 이 attribute를 찾아서 UIApplicationMain(::::)를 호출하고 앱을 실행합니다.

### UIApplicationMain() 
##### 앱이 시작되면 시스템은 UIApplicationMain(_:_:_:_:)함수를 호출한다. 이 함수는 다른 task들 중에서 싱글톤 UIApplication객체를 만든다.
##### 그런 다음, shared클래스 메소드를 호출하여 객체에 접근한다.

<br>
<br>

### UIApplicationMain이 하는 것
- ##### UIApplication객체와 Delegate 객체를 만든다.
- ##### info.plist에서 필요한 nib file을 로드한다.
- ##### 메인 이벤트 루프를 실행시킨다.