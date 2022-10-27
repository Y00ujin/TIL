# 2. ****Publishers & Subscribers****

## Publisher

이 **Publisher** Protocol은 하나 이상의 Subscriber 들에게 연속되는 값을 전송할 수 있는 타입이 필요로 하는 것

들을 정의하고 있습니다. 즉, **Publisher**는 Subscriber에게 특정 **값을 가진 이벤트를 전송할 수 있는 타입**이다!

시간 경과에 따라 일련의 값을 하나 혹은 복수의 Subscriber에 동기, 비동기로 전송할 수 있다!

Publisher는 값과 완료 이벤트를 방출합니다.

Publisher는 일반적인 완료 또는 에러로 나타날 수 있는 완료 이벤트는 한개만 내보낼 수 있습니다. 

Publisher가 완료 이벤트를 내보내면 더 이상 이벤트를 내보낼 수 없습니다.

### Publisher Protocol

Publisher Protoocl 과 extension을 살펴보겠습니다.

```swift
public protocol Publisher {
 	// 1 : publisher가 생성할 수 있는 값 타입
 	associatedtype Output

 	// 2 : publisher가 발생시킬 수도 있는 error 타입. 
	//     만약 error를 발생시키지 않는다고 보장할 수 있다면 Never.
 	associatedtype Failure : Error

 	// 4 : 구독 요청을 받아서 Subscription instance를 반환한다.
 	func receive<S>(subscriber: S)
 		where S: Subscriber,
 		Self.Failure == S.Failure,
 		Self.Output == S.Input
 }
 
 extension Publisher {
 	// 3 : subscriber는 publisher의 subscribe(_:) 을 호출할 수 있습니다.
 	public func subscribe<S>(_ subscriber: S)
 		where S : Subscriber,
 		Self.Failure == S.Failure,
 		Self.Output == S.Input
 }
```

<br>
<br>
<br>

---

<br>
<br>
<br>

### NotificationCenter

Publisher를 NotificationCenter와 같은 것이라도 생각할 수 있습니다.

실제로 NotificationCenter에는 알림을 발송할 수 있는 **Publisher** 타입의 **publisher(for:object:)** 존재

```swift
example(of: "Publisher") {
  // 1 : notification의 이름을 생성했습니다.
  let myNotification = Notification.Name("MyNotification")

  // 2 : 리턴 값을 publisher에 넣고있음
  let publisher = NotificationCenter.default
    .publisher(for: myNotification, object: nil)
}
```

### NotificationCenter와 Combine

사실 notification center에서 publisher 없이 notification을 broadcast 할 수 있습니다.

publisher와 같이 Combine의 Publisher 타입을 반환하는 함수가 존재하는 이유는 

NotificationCenter와 같은 기존 API에 Combine과 같은 새로운 기술을 적용해놓으면

NotificationCenter와 같은 이전 방법에서 Combine과 같은 새로운 방법으로 연결될 수 있기 때문!

<br>
<br>
<br>

---

<br>
<br>
<br>

## Subscriber

Subscriber는 Publisher로부터 input을 받을 수 있는 타입을 선언하는 프로토콜입니다.

지금 알림을 보내도 알림을 사용할 Subscriber가 없기 때문에 Publisher가 알림을 내보내지 않습니다.

```swift
example(of: "Subscriber") {
	 let myNotification = Notification.Name("MyNotification")

	 let publisher = NotificationCenter.default
 	.publisher(for: myNotification, object: nil)

		let center = NotificationCenter.default
		
	// 이렇게 알림을 발송하는 코드를 작성해도, 알림을 내보내지 않음.
    // center.post(name: myNotification, object: nil)
 }
```

### **Subscriber Protocol**

```swift
public protocol Subscriber: CustomCombineIdentifierConvertible {
 	// 1 : subscriber가 받을 수 있는 값 타입
 	associatedtype Input

 	// 2 : subscriber가 받을 수 있는 error 타입 
    //     또는 subscriber가 error를 받지 않는다면 Never
 	associatedtype Failure: Error

 	// 3 : publisher가 subscription을 전달하기 위해 
	//     subscriber의 receive(subscription:)을 호출합니다.
 	func receive(subscription: Subscription)

 	// 4 : publisher가 방출하는 새로운 값들을 전달하기 위해 
    //     subscriber의 receive(_:)를 호출합니다.
 	func receive(_ input: Self.Input) -> Subscribers.Demand

 	// 5 : publisher가 값 생성이 종료되었거나 error가 발생하였을 때 
    //     종료를 알리기 위해 subscriber의 receive(completion:)을 호출합니다.
 	func receive(completion: Subscribers.Completion<Self.Failure>)
 }
```

<br>
<br>
<br>

---

<br>
<br>
<br>

## Basic Subscriber : Sink

NotificationCenter의 publisher를 sink로 subscribe하는 것을 구현해보겠습니다.

sink Subscriber는 Publisher가 내보내는 만큼의 값을 계속 받게 됩니다.

```swift
example(of: "Subscriber") {
    let myNotification =  Notification.Name("MyNotification")
    let publisher = NotificationCenter.default.publisher(for: myNotification, object: nil)
    let center = NotificationCenter.default
    
    let subscription = publisher.sink { _ in
        print("Notification received from a publisher!")
    }
    
    center.post(name: myNotification, object: nil)
    subscription.cancel()
}
```

```r
——— Example of: Subscriber ———
Notification received from a publisher!
```

이번에는 **sink Subscriber**가 제공하는 **두 개의 클로저**를 사용해보겠습니다.

하나는 **완료 이벤트(성공 또는 실패) 수신을 처리**하고 다른 하나는 수신 값을 처리합니다.

```swift
example(of: "Just") {
  // 1
  let just = Just("Hello world!")
  
  // 2
  _ = just
    .sink(
      receiveCompletion: {
        print("Received completion", $0)
      },
      receiveValue: {
        print("Received value", $0)
    })
}
```

**값을 받은 후 완료 이벤트가 발생**하므로 아래와 같이 출력됩니다.

```r
——— Example of: Just ———
Received value Hello world!
Received completion finished
```

<br>
<br>
<br>

---

<br>
<br>
<br>

## Basic Subscriber : assign

`**assign(to:on:)**` 는 **새로운 값을 `keyPath` 에 따라 주어진 인스턴스의 `property` 에 할당**합니다.

UI 구성요소에도 직접 값을 할당할 수 있기 때문에 UIKit or AppKit에서 작업할 때 특히 유용합니다.

```r
example(of: "assign(to:on:)") {
 // 1
 class SomeObject {
 	var value: String = "" {
   		didSet {
     		print(value)
   		}
 	}
 }
 
 // 2
 let object = SomeObject()
 
 // 3
 let publisher = ["Hello", "world!"].publisher
 
 // 4
 _ = publisher
 	.assign(to: \.value, on: object)
 }
```

```r
——— Example of: assign(to:on:) ——
Hello
world!
```

<br>
<br>
<br>

---

<br>
<br>
<br>

 

## Subscription Protocol

publisher와 subscriber는 subscription을 통해 연결됩니다. 아래의 Subscription protocol을 확인합시다.

```swift
public protocol Subscription: Cancellable, CustomCombineIdentifierConvertible {
	// subscriber는 request(_:)을 호출하여 최대 또는 무제한의 값을 받을 수 있음을 나타낼 수 있습니다.	
	func request(_ demand: Subscribers.Demand)
}
```

<br>
<br>
<br>

---

<br>
<br>
<br>

## ****Cancellable****

Cancellable 프로토콜은 특정 연산이 취소가 가능함을 의미합니다. 

Subscriber를 직접 구현한다면 이 Cancellable을 채택해서 작업을 취소할 수 있도록 해줘야 합니다.

이 구현은 Subscriber가 가지고 있는 Subscription 객체를 대상으로 cancel() 메서드를 호출하고,

Subscriber가 가지고 있는 참조를 없애는 것으로 간단하게 구현할 수 있습니다.

이는 Subscription 프로토콜이 Cancellable 객체를 상속 받기 때문입니다.

참고로 Apple이 제공하는 Subscriber인 Sink와 Assign은 이미 Cancellable이 구현되어 있습니다.

<br>
<br>
<br>

---

<br>
<br>
<br>


### Combine 흐름

**1  :**  Subscriber가 Publisher를 Subscribe 합니다.

**2  :**  Publisher가 Subscription을 생성하고 Subscriber에게 전달합니다.

**3  :**  Subscriber가 값을 요청합니다.

**4  :**  Publisher가 값을 전달합니다.

**5  :**  Publisher가 완료를 전송합니다.

<br>
<br>
<br>

---

<br>
<br>
<br>


## Hello Future

Future는 결국 하나의 값을 만들어 완료되거나 실패될 publisher 입니다.

이는 값이나 error가 있을 때 closure를 호출하여 이를 수행하며, 해당 closure를 promise 라고 합니다.

promise는 Future가 방출한 단일 값 또는 error를 포함하는 Result를 받는 closure에 대한 typealias입니다.

```swift
final public class Future<Output, Failure> : Publisher
 	where Failure: Error {
 	public typealias Promise = (Result<Output, Failure>) -> Void
 	...
 }
```

### Future Example

Future은 기본적으로 제공되는 Publisher로 단일 결과를 비동기적으로 생성한 다음 완료할 수 있습니다.

Int 값과 TimeInterval 값을 인자로 받아 Future를 반환하는 함수를 만들었습니다.

```swift
example(of: "Future") {
 	func futureIncrement(
 		integer: Int,
 		afterDelay delay: TimeInterval) -> Future<Int, Never> {

 	}
 }
```

반환될 Future를 정의하며, 함수 호출 시 지정한 값을 이용하여 delay 후 Int를 증가시킬 것입니다.

```swift
Future<Int, Never> { promise in
 	DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
 		promise(.success(integer + 1))
 	}
 }
```

Future를 생성하고 subscription 들을 저장할 subscriptions 묶음을 추가합니다.

장시간 실행되는 비동기 작업의 경우 subscription을 저장하지 않으면 현재의 코드 범위가 종료되는 즉시

subscription이 취소되기 때문입니다.

```swift
// 1 : 3초 지연 후 전달받은 정수를 증가시키도록 하는 기능을 사용하여 Future 생성
 let future = futureIncrement(integer: 1, afterDelay: 3)

 // 2 : 수신된 값과 완료 이벤트를 subscribe 및 print하고 결과도 받은 subscription을
 //     subscriptions set에 저장합니다.
 future
 	.sink(receiveCompletion: { print($0) },
 		receiveValue: { print($0) })
 	.store(in: &subscriptions)
```

```swift
——— Example of: Future ———
2
finished
```

다시 한 번 subscription을 future에 추가하고, futureIncrement함수 내에 출력문을 추가하겠습니다.

그리고 실행시켜보면 입력한 지연 시간 이후 두 번째 subscription이 같은 값을 받은 것을 확인할 수 있습니다.

즉, Future는 promise를 다시 실행하지 않고 이전 출력 값을 share하거나 replay 한 것입니다.

```swift
future
 	.sink(receiveCompletion: { print("Second", $0) },
 		receiveValue: { print("Second", $0) })
   	.store(in: &subscriptions)

...

func futureIncrement(
    integer: Int,
    afterDelay delay: TimeInterval) -> Future<Int, Never> {

      Future<Int, Never> { promise in
        print("Original") // 수정된 부분
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
          promise(.success(integer + 1))
        }
      }
  }
```

<br>
<br>
<br>

---

<br>
<br>
<br>


## PassthroughSubject

PassthroughSubject는 publisher의 일종입니다. 차이점은 밖에서 값을 방출할 수 있다는 점입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f75dd2dd-2da8-4783-973c-c5bfaedc27ed/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/09ff7692-8d87-4401-b474-55f2825a66fa/Untitled.png)

subject는 Combine으로 작성되지 않은 코드가 Combine의 subscriber에게 값을 보낼 수 있도록 중간자 역할을 하는 아이입니다.

 입력이 "World" 일 때 최대값이 3(기존 최대값 + 1)으로 설정됩니다.

```swift
example(of: "PassthroughSubject") {
 	// 1 : 사용자 error 타입을 정의합니다.
 	enum MyError: Error {
     	case test
     }

   	// 2 : String 값과 MyError error를 받을 사용자 subscriber를 정의합니다.
   	final class StringSubscriber: Subscriber {
     	typealias Input = String
     	typealias Failure = MyError
     	
     	func receive(subscription: Subscription) {
       		subscription.request(.max(2))
     	}
     	
     	func receive(_ input: String) -> Subscribers.Demand {
       		print("Received value", input)
       		// 3 : 수신할 값에 따라 Demand 를 조정합니다.
       		return input == "World" ? .max(1) : .none
     	}
     	
     	func receive(completion: Subscribers.Completion<MyError>) {
       		print("Received completion", completion)
     	}
   	}
   	
   	// 4 : 사용자 subscriber 객체를 생성합니다.
   	let subscriber = StringSubscriber()
 }
```

Passthrough Subject를 사용하면 필요에 따라 새로운 값을 게시할 수 있습니다. 

다른 publisher와 마찬가지로 값과 error 타입을 선언해야합니다.

subscriber가 해당 Passthrough Subject를 subscribe 하려면 해당 유형을 자신의 Input 및 Failure 유형과 일치시켜야 합니다.

```swift
// 5 : String과 MyError를 갖는 PassthroughSubject 객체를 생성합니다.
  let subject = PassthroughSubject<String, MyError>()

  // 6 : subject가 subscriber를 구독하도록 합니다.
  subject.subscribe(subscriber)

  // 7 : sink를 이용하여 subscription을 생성합니다.
  let subscription = subject
    .sink(
      receiveCompletion: { completion in
        print("Received completion (sink)", completion)
      },
      receiveValue: { value in
        print("Received value (sink)", value)
      }
    )
```

이제 값과 subcription을 통해서 받을 수 있는 Passthrough Subject를 만들었으니 값을 보내야겠죠. 

```swift
subject.send("Hello")
subject.send("World")
```

```swift
——— Example of: PassthroughSubject ———
 Received value Hello
 Received value (sink) Hello
 Received value World
 Received value (sink) World
```

두번째 구독을 취소합니다. 그래서 값을 보내도 한줄만 찍힙니다.

```swift
// 8 : 두번째 구독을 취소합니다.
subscription.cancel()

// 9 : 다른 값을 보냅니다.
subject.send("Still there?")
```

```swift
——— Example of: PassthroughSubject ———
Received value Hello
Received value (sink) Hello
Received value World
Received value (sink) World
Received value Still there? // 첫번째 Subscriber만 값을 받는 모습
```

구독이 취소된 subscriber는 완료 이벤트도 값도 받지 못하고,

구독이 되어있는 subscriber는 완료 이벤트만 받을 수 있다.

완료 이벤트를 받으면 이어서 값을 받을 수 없기 때문입니다.

```swift
subject.send(completion: .finished)
subject.send("How about another one?")
```

완료 이벤트를 보내기 전에 에러 완료 이벤트를 보내보겠습니다.

```swift
subject.send(completion: .failure(MyError.test))
```

에러 완료를 수신한 이후에 성공 완료를 수신하지 않는 걸로 봐서 에러 또는 성공을 수신받은 후에는 Publisher가 종료된다는 것을 나타냅니다.

```swift
——— Example of: PassthroughSubject ———
 Received value Hello
 Received value (sink) Hello
 Received value World
 Received value (sink) World
 Received value Still there?
 Received completion failure(...MyError.test)
```

<br>
<br>
<br>

---

<br>
<br>
<br>


## CurrentValueSubject

CurrentValueSubject는 publisher의 일종입니다. Publisher를 생성할 때 꼭 초기값을 줘야합니다.

CurrentValueSubject는  `value` 속성에 접근하여 현재 값을 얻을 수 있습니다.

```swift
example(of: "CurrentValueSubject") {
	var subscriptions = Set<AnyCancellable>()

 	// 1 : Int와 Never 타입을 갖는 CurrentValueSubject를 생성합니다. 
	//     여기서 초기값을 0으로 두었습니다.
 	let subject = CurrentValueSubject<Int, Never>(0)
   	
   	// 2 : subject에 subcription을 생성하고 받은 값을 print할 수 있도록 합니다.
   	subject
     	.sink(receiveValue: { print($0) })
     	.store(in: &subscriptions) // 3 : subscription을 구독권묶음에 저장합니다.
																				이 set은 사본이 아니라 동일한 set이 업데이트
																				되도록 inout 파라미터를 사용합니다.
 }
```

새 subscriber는 즉시 초기값 또는 해당 subject에 의해 방출된 값을 받습니다.

```swift
——— Example of: CurrentValueSubject ———
 0
```

이제 새 값을 전송합니다. 출력값은 초기값인 0, 전달받은 1, 2가 됩니다.

```swift
subject.send(1)
subject.send(2)
```

Passthrough Subject와는 달리 Current Value Subject는 값을 언제든 확인할 수 있습니다. 

다음 코드를 추가하여 subject의 현재 값을 확인해봅시다.

마지막에 보낸 값을 출력합니다.

```swift
print(subject.value) // 2
```

CurrentValueSubject Publisher는 값을 두가지 방법으로 방출할 수 있습니다.

그런데 완료 이벤트는 value에 담지 못하고 send로 담아 보내야합니다.

```swift
subject.value = 3
subject.send(3)
subject.value = .finished // error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subject.send(completion: .finished)

receive finished
receive finished
```

새로운 Subscription을 current value subject에 생성합니다.

```swift
subject
 	.sink(receiveValue: { print("Second subscription:", $0) })
 	.store(in: &subscriptions)
```

앞서 subscription 묶음이 subscription을 자동으로 취소해준다고 했는데 확인해봅시다.

subject에 print 하면 모든 방출 이벤트를 콘솔에 기록할 수 있습니다.

```swift
subject
   	.print()
   	.sink...
```

```swift
...

 receive cancel
 receive cancel
// 구독이 취소되는 것을 확인할 수 있음.
```

<br>
<br>
<br>

---

<br>
<br>
<br>


## **Summary**

- Publisher는 시간이 지남에 따라 일련의 값을 하나 이상의 subscriber에게 동기적 또는 비동기적으로 전송합니다.
- Subscriber는 값을 받기 위해 publisher를 subscribe 할 수 있습니다. 그러나 subscriber의 input 과 failure 유형은 publisher의 output과 failure 유형과 반드시 일치해야 합니다.
- publisher를 구독하는데 사용할 수 있는 내장 연산자는 `sink(_:)` 와 `assign(to:go:)`가 있습니다.
- subscriber는 값을 받을 때마다 값에 대한 수요를 증가시킬 수 있지만 감소시킬 수는 없습니다.
- 리소스를 확보하고 원하지 않는 부작용을 방지하려면 각 subscription이 완료될 때 취소해야합니다.
- subscription을 `AnyCancellable` 객체 또는 collection에 저장하여 할당 해제 시점에 자동 취소되도록 할 수 있습니다.
- Future는 나중에 단일 값을 비동기적으로 받고자 할 때 사용할 수 있습니다.
- Subject는 외부 호출자가 초기값의 유무와 관계없이 subscriber에게 여러 개의 값을 비동기적으로 보낼 수 있는 publisher입니다.
- type 삭제는 호출자가 기존 type의 추가 세부 정보에 엑세스할 수 없도록 합니다.
- `print()` operator를 사용하여 방출되는 모든 이벤트 로그를 콘솔을 통해 확인할 수 있습니다.