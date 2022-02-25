## SceneDelegate

#### iOS 12 이하 버전
- ##### App 하나는 오로지 각 하나의 Process와 UI를 유지 (AppDelegate에서 모두 관여)
#### iOS 13 이상 버전
- ##### App 하나에 여러 UI 인스턴스 존재 가능, 앱 델리게이트의 일부 역할을 씬 델리게이트가 담당
- ##### window의 개념이 scene으로 대체되었다.


<br>
<br>

### SceneDelegate의 역할
- ##### UILifeCycle을 관리한다.