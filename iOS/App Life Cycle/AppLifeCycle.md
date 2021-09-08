## App Life Cycle

- ##### ```App Life Cycle``` 머리에 넣기 with Youjin 👩🏻‍💻

### 앱의 생명주기란?

##### ```App의 실행/종료``` 및 App이 Foreground/Background 상태에 있을 때, 시스템이 발생시키는 event에 의해 ```App의 상태가 전환되는 일련의 과정```을 뜻합니다.

#### Overview
- ##### 현재 app의 state(상태) 는 어떠한 것을 할 수 있고 없는지를 결정하게 된다.
- ##### 예를 들어 foreground 앱은 user가 사용하고 있기 때문에 user의 관심을 받게되고 따라서 CPU를 포함한 system resource에서 우선순위를 가지게 된다.
- ##### 반면에 background 앱은 화면의 밖의 일이기 때문에 가능한 작업을 수행하지 않는 것이 좋다. 
- ##### 따라서 우리의 앱은 상태가 바뀔 때 마다 이에 대응해서 동작을 조정해야한다.

### 그럼 앱의 상태에는 어떤 것들이 있을까?
### Not Running
> ##### Not Running은 앱이 아직 실행되지 않았거나, 완전히 종료되어 동작하지 않는 상태.

### Foreground - Inactive
> ##### Inactive는 app이 실행중이지만 사용자로부터 event를 받을 수 없는 상태.
> ##### ex) multitasking window로 진입, 앱 스위쳐 사용, 전화, 알림 등에 의해 사용자가 앱을 사용할 수 없게 되는 경우
> ##### 사용자가 앱을 full Controll 할 수 없는 상태
> ##### 외부적인 요인(interrupt)에 의해 InActive 상태가 될 수 있다.

### Foreground - Active
> ##### Active는 app이 실제 실행중이고 사용자 event를 받아서 상호작용할 수 있는 상태. (바로 Active가 되지 않고 Inactive 상태를 거쳐 Active상태가 된다.)

### Backgound - Running
> ##### Background는 홈화면으로 나가거나 다른 app으로 전환되어 현재 app이 실질적인 동작을 하지 않는 상태. 예를 들어 Music app을 닫아도 재생한 음악이 계속 실행되는 경우. 사용자가 app을 사용하지 않는 동안 서버와 데이터를 동기화하거나 타이머가 실행되어야 하는 등의 작업을 이 상태에서 할 수 있습니다.
> ##### 5분 정도만 살 수 있다.

### Backgound - suspended
> ##### Suspended는 app을 다시 실행했을 때 최근 작업을 빠르게 로드하기 위해 메모리에 관련 데이터만 저장되어있는 상태. app이 background 상태에 진입했을 때 다른 작업을 하지 않으면 Suspended 상태로 진입하게 됩니다.(보통 2~3초 이내) Suspended 상태의 app들은 iOS의 메모리가 부족해지면 가장 먼저 메모리에서 해제됨. 따라서 app을 종료시킨 적이 없더라도 app을 다시 실행하려고 하면 처음부터 다시 실행됩니다.

### 상황에 따른 앱의 상태변화를 알아보자.



##### 참고자료
- ###### https://velog.io/@minni/iOS-Application-Life-Cycle
- ###### https://velog.io/@rnfxl92/%EC%95%B1-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0-Application-Life-Cycle
- ###### https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle
- ###### https://www.youtube.com/watch?v=7GlwS2lOKbE
