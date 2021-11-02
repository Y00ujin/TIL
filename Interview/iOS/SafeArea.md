## Safe Area

- ##### iOS 면접 질문 준비하기 `211102` with Youjin🙇🏻‍♀️

<br>

### Safe Area?
> ##### 시스템에 의해 가려질 수 있는 부분의 마진을 자체적으로 가지는 것
> ##### 핸드폰의 전체적인 UI를 통틀어서 컨텐츠가 제대로 보일수 있는 부분에만 뷰를 놓을 수 있도록 도와주는 기능

<br>

#### iOS 7의 topLayoutGuide, bottomLayoutGuide
###### iOS 7에서 애플은 어떤 뷰들(상태 바, 네비게이션 바, 탭 바 등) 이 스크린 영역을 가리지 않게 마진을 주는 UIViewController의 스크린 프로퍼티인 `topLayoutGuide`, `bottomLayoutGuide`를 소개했습니다.

<br>

#### iOS 11의 Safe Area
###### iOS 11에서 이 속성들을 금지 시쳤고 safe area를 소개했습니다. Apple은 safe area 밖에 컨트롤을 배치하지 말것을 권고합니다. 이런 이유로 iOS 11에서는 뷰를 배치시킬때 safe area API를 사용해야합니다.

<br>

##### `iPhonX`의 해상도(resoultion)와 `Safe area`를 지원하기 시작했을때 `UIKit`의 많은 클래스가 새로운 `Safe area` 기능을 가지고 있음을 알았습니다. 이 글의 목표는 `Safe area`를 요약하고 설명하는것입니다

<br>

#### safe area properties와 method를 가지는 클래스
- ##### `UIView`, `UIViewController`, `UIScrollView`, `UITableView`, `UIColelctionView`

<br>

#### `UIView`의 Safe area properties, method
> ###### iOS11에서 UIViewController의 topLayoutGuide, bottomLayoutGuide는 다음의 새로운 UIView의 safe area 속성으로 변경되었습니다.


```Swift
// 화면의 상, 하단 뿐만 아니라 모든 면에서 화면을 가릴수 있음을 의미
// Landscape orientation 때문에 왼쪽과 오른쪽 인셋이 필요
@available(iOS 11.0, *)
open var safeAreaInsets: UIEdgeInsets { get }

@available(iOS 11.0, *)
open var safeAreaLayoutGuide: UILayoutGuide { get }
```