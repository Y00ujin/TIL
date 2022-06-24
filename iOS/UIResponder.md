## UIResponder

<br>
<br>

### UIResponer란?
- ##### 이벤트에 응답하고 처리하기 위한 추상 인터페이스
- ##### UIResponder의 인스턴스 즉 UIApplication, UIViewController, UIView 객체 등은 이벤트를 다룰 수 있다.
- ##### 특정 타입의 이벤트를 처리하려면, 리스폰더가 해당 메소드를 override해야한다.
###### 예를 들어 터치 이벤트를 처리하기 위해 리스폰더는 `touchesBegan(_:with:), touchesMoved(_:with:), touchesEnded(_:with:), touchesCancelled(_:with:)`를 구현한다.


<br>
<br>

### Responder Chain
> ##### Responder Chain은 responder 객체들이 이벤트나 액션 메시지를 핸들링할 책임을 앱의 다른 객체들에게 전송할 수 있도록 해준다.
> ##### 메시지는 처리될 때까지 계속 chain의 상위 객체들로 이동하고 마지막까지 처리되지 않을 경우, 앱이 해당 메시지를 버린다.
###### 아래는 UIResponder의 리스폰더 체인을 관리해주는 메소드들이다.
```Swift
var next: UIResponder?

var isFirstResponder: Bool

var canBecomeFirstResponder: Bool

var canResignFirstResponder: Bool

func becomeFirstResponder() -> Bool

func resignFirstResponder() -> Bool
```

<Br>

- ##### becomeFirstResponder
###### 이 메소드를 호출한 객체를 window의 첫번째 리스폰더로 만들기 위해 UIKit에 요청한다.
###### 키보드를 호출하기 위해서 아래와 같이 텍스트필드로 이 메소드를 호출한다.
###### UITextField가 최초 리스폰더가 될 경우에 키보드가 나타나기 때문에 아래와 같은 메소드를 사용하면 키보드가 호출된다.
###### 다른 객체가 최초 리스폰더가 되면 키보드는 사라진다.
```Swift
myTextField.becomeFirstResponder()
```

<Br>

- ##### resignFirstResponder
###### window의 최초 리스폰더로서의 상태를 양도하도록 요청한다.
###### 그러므로 UITextField에서 resingFirstResponder()를 호출하면 키보드가 사라진다.
```Swift
myTextField.resignFirstResponder()
```

<br>


### UIKit과 UIResponder
- ##### 이벤트가 발생하면 UIKit은 이를 처리할 수 있도록 앱의 UIResponder의 인스턴스들에게 전달한다.
- ##### 전달받은 리스폰더가 이벤트를 처리하지 않으면, 리스폰더 체인의 다음 이벤트로 해당 이벤트를 전달한다.
