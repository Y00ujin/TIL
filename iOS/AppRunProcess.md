## App Run Process

##### C언어에 뿌리를 둔 모든 애플리케이션은 main()함수로부터 시작된다. 이를 엔트리 포인트라고 한다.

![image](https://user-images.githubusercontent.com/71479613/155274372-6bfb26c6-f432-48e7-8fc0-053ce3d2ba68.png)

#### 1. 사용자가 앱을 클릭한다.
#### UIKit은 main() 함수를 호출하고 main()에서 UIApplicationMain() 함수를 호출한다.
- ###### Objc에서는 main.m에서 UIApplicationMain을 호출했지만, Swift에서는 appDelegate.swift에서 AppDelegate 클래스 앞에 어노테이션으로 붙은 @UIApplicationMaindmf 통해 UIApplicationMain을 호출한다.
#### 호출된 UIApplicationMain이 application 객체를 만들고, delegate도 만든다.
#### AppDelegate 클래스의 인스턴스를 만들고, 이 인스턴스를 위해서 만든 application 객체에 할당한다...
- ###### appDelegate와 application 객체가 연결된것
#### 


### Object-c의 앱 실행과정

#### 1. 앱이 실행되면서 main()함수가 실행된다.
#### 2. main()함수는 UIApplicationMain()함수를 호출한다.
##### 2-1. UIApplication 객체를 생성한다.
##### 2-2. AppDelegate를 생성한다.
##### 2-3. 메인스토리보드와 nib 파일을 로드한다.
##### 2-4. SceneDelegate를 생성한다.
##### 2-5. window 객체를 생성한다.
##### 2-6. ViewController의 view가 로드된다.

##### UIApplication 객체는 앱의 본체에 해당한다.
#### 4. UIApplication 객체는 info.plist 파일로부터 앱 구성에 필요한 정보들을 로드한다.
#### 5. 이벤트 루프 및 초기설정을 진행한다.
#### 6. 실행 완료 직전에 앱 델리게이트의 application(_:didFinishLaunchingWithOptions:) 메소드가 호출된다.

<br>
<br>

### Swift의 앱 실행과정

> #### 스위프트는 main()함수가 없지만 @main이라는 어노테이션 표기가 있다. 이 표기를 통해서 object-c의 1~5 과정이 대체된다.
> #### 만약 생성된 앱 프로젝트에서 @main 어노테이션을 지울 경우 빌드에 실패한다. 앱의 시작 진입점을 알 수 없기 때문이다.
#### 1. @main 어노테이션을 찾고 그 클래스를 실행한다.
#### 2. AppDelegate 클래스의 application(_:didFinishLaunchingWithOptions:)메소드를 호출한다
##### 앱이 실행될때 처리할 내용이 있으면 여기에 작성한다.
#### 3. 이벤트 루프 실행, 작성한 코드들이 실행된다.
#### 4. 앱이 종료될때 앱에 대한 메모리 제거를 위해서 ApplicationWillTerminate(_:) 메소드를 호출
##### 앱이 종료될때 처리할 내용이 있으면 여기에 작성


<br>
<br>

https://velog.io/@ellyheetov/ios-entrypoint
https://velog.io/@kimjk3381/ios-%EC%95%B1%EC%9D%B4-%EC%8B%9C%EC%9E%91%ED%95%A0-%EB%95%8C-main.c-%EC%97%90-%EC%9E%88%EB%8A%94-UIApplicationMain-%ED%95%A8%EC%88%98%EC%97%90-%EC%9D%98%ED%95%B4%EC%84%9C-%EC%83%9D%EC%84%B1%EB%90%98%EB%8A%94-%EA%B0%9D%EC%B2%B4%EB%8A%94-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80
https://zeddios.tistory.com/539
