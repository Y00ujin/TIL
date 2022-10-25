이 책은 Combine을 설명하고있으며, declarative, reactive 앱을 만드는 것을 목표로 합니다.

### **Asynchronous programming**

단일 쓰레드 언어에서는 한 줄씩 순차적으로 코드가 실행됩니다.

동기식 코드는 이해하기 쉽습니다. 특히 Data의 상태를 설명하기 쉽습니다.

하지만 코드가 다른 코어에서 동시에 실행될 때는 코드의 어떤 부분이 먼저 수정되거나 실행될지 알 수 없습니다.

비동기적으로 동시에 실행되는 코드를 실행하는 순간 변경 가능한 상태 관리는 필수적입니다.

### Foundation and UIKit/AppKit

애플은 아래와 같은 비동기 프로그래밍 방식을 지속적으로 개선해왔습니다.

NotificationCenter, Delegate Pattern, GCD and Operations, Closure

또 하나의 문제점으로는 앱 하나에 여러개의 비동기 API를 사용한다는 것입니다.

대부분의 일반적인 코드는 일부 작업을 비동기식으로 수행하고 모든 UI 이벤트는 본질적으로 비동기식이므로 

코드가 실행될 순서를 추측하는 것은 불가능한 일입니다. 또 하나의 문제점은 위에 표시된 것과 같이 각각 고유한

인터페이스를 가진 다양한 종류의 비동기 API를 모두 사용한다는 사실입니다.

Combine은 비동기 코드를 설계하고 작성하기 위해 Swift 에코시스템에 공통의 고급 언어를 도입합니다.

---

### Combine의 장점

- **콤바인을 사용하면 코드에 통합하기 쉬움**

애플은 Combine API를 Foundation Framework에 긴밀하게 통합하고 있음

Timer나 NotificationCenter, Core Data에서는 이미 Combine을 사용하여 설계됨

RxSwift와 같은 것과 달리 서드파티가 아니라서 접근성 굿! 서드파티 의존성 낮출 수 있음

- **아래와 같은 것들이 Combine에 의존하고 있음**

**SwiftUI :** @State, @Binding, @observedObject

**Core Date :** FetchedRequest, NSManagedObject

**Foundation :** Timer, NotificationCenter

- **Combine + SwiftUI =**  $GREAT!$

SwiftUI와 함께 사용하기에 좋게 설계됨

---

### Swift’s Modern Concurrency

Swift 5.5는 비동기 및 동시성 코드를 위한 다양한 API를 도입했습니다. → async, await?

이는 네트워크 응답 대기, 여러 작업을 병렬로 실행하는 등의 고전적인 비동기 문제를 해결해줍니다.

이와 같은 API도 좋지만 Combine은 많은 연산자를 가지고 있습니다. 연산자는 복잡한 연산들을 쉽게 합니다.

반응형 Obserators는 네트워킹, 데이터 처리 및 UI 이벤트 처리와 관련된 문제를 해결할 수 있으므로, 

보다 복잡한 앱의 경우 Combine을 사용하여 개발하면 많은 이점을 얻을 수 있습니다.

### Combine $..!$

콤바인의 핵심은 **Publishers**, **Operators**, **Subscribers** 입니다. 

물론 다른 것들도 많지만 이 세개 없이는 $앙~$! 대요

---

### Combine의 Publisher

Publishers는 시간이 지남에 따라 값을 방출할 수 있는 타입입니다. 값들을 Subscriber에게 전달하는 프로토콜

Publishers는 성공적으로 완료되거나 오류로 인해 완료되는 경우 다른 이벤트를 내보내지 않습니다

Publishers는 아래와 같은 이벤트를 방출할 수 있습니다.

- **Completion :** successful completion
- **Failure :** completion with an error
- **Output :** value, event

Publisher 프로토콜은 두 가지 타입이 제네릭합니다. 

- **Publisher.Output :** 이는 Publisher가 발행하는 값의 타입입니다.
- **Publisher.Failure :** 오류가 발생한 경우 Publisher가 발생시킬 수 있는 오류 타입입니다. 만약 오류가 절대절대 발생하지 않는다면 Never 오류 타입을 사용하면 됩니다.

---

### Combine의 **operators**

연산자는 동일하거나 새로운 Publisher를 반환하는 Publisher Protocol 내부에 선언된 메서드입니다.

Operator들을 체이닝해서 사용할 수 있기 때문에 유용합니다. 비동기 작업의 순서를 정의할 수 있습니다.

이 Operator들은 독립적이고 조합가능하기 때문에, 복잡한 로직을 구현하는데 사용 가능합니다.

각 Operator들은 Input과 Output을 가지기 때문에 위에서 소개했던 동시성 이슈를 피할 수 있습니다.

Operator는 이전 Operator로부터 받은 데이터로 작업하고 체인의 다음 Operator에게 출력을 제공합니다. 

즉 비동기적으로 실행되는 다른 코드는 작업 중인 데이터를 변경할 수 없습니다. 

---

### Combine의 **subscribers**

Subscriber는 일반적으로 방출된 value 또는 완료 이벤트로 **“$뭔가$”** 를 수행합니다.

현재 Combine은 데이터 스트림을 쉽게 사용할 수 있는 두 가지 기본 제공 Subscribers를 제공합니다.

- **Sink  : closure**에서 새로운 값이나 종료 이벤트에 대해 처리합니다.

```swift
_ = just
    .sink(
      receiveCompletion: { // 종료 이벤트
        print("Received completion", $0)
      },
      receiveValue: { // 새로운 값
        print("Received value", $0)
	  })
```

- **Assign  : 새로운** 값을 key path를 통해 프로퍼티에 값을 할당할 수 있습니다.

Assign Subscriber는 주어진 값이 꼭 있어야 하기 때문에 Sink와는 달리 **Publisher의 Failure Type**이 **Never** 여야 합니다.

```swift
_ = publisher
    .assign(to: \.value, on: object)
```

---

### Combine의 Subscriptions

책에서 Subscription이라는 용어가 나오면 **아래 중 하나를 뜻하는 거**라고 생각하면 됩니다.

- subscription 프로토콜
- subscription 프로토콜을 채택한 객체
- publisher, operator, subscriber의 전체 chain

subscription의 끝에 subscriber를 추가하면 publisher를 활성화할 수 있습니다.

subscriber가 없으면 publisher는 어떤 value도 전달하지 않습니다.

이 Subscription은 subscriber와 publisher의 연결을 나타내며 이것을 통해 publisher의 elements를 요구하거나 더 이상 값을 받지 않겠다고 할 수도 있습니다.

### Subscriptions의 장점

1. Subscription은 비동기 이벤트들의 체인을 커스텀 코드와 에러 핸들링과 함께 한방에 선언 가능.
2. Full-Combine 이면, 앱 전체의 로직을 subscription 들로 표현 가능.
3. Subscription이 한번 선언되고 나면 콜백을 호출할 필요 없이 시스템이 다 알아서 해줌.

---

### Combine을 $왜$ 사용할까?

Combine 사용안해도 심지어 CoreData, URLSession UIKit 또한 사용안해도 앱 만들 수 있습니다.

그러나 이러한 프레임워크를 사용하면 추상화된 것들을 직접 구축하는 것보다 더 **편리하고 안전하며 효율적!**

Combine은 비동기 코드에 추상화를 추가하는 것을 목표로 합니다. Combine을 채택하면 다음과 같은 혜택!

- 모든 비동기 작업이 동일한 인터페이스인 `Publisher` 를 사용하여 이루어진다면 재사용성 증가
- delegate, closure 만들 필요 없음. 실수 가능성 낮아짐
- 비동기 코드에서도 비즈니스 로직에 집중할 수 있음.
- 시스템 레벨에 통합되어 있음
- operator를 조합하기 좋음

---

## Cancellable

`Cancellable` protocol 덕분에 **subscription**을 메모리 관리할 필요가 없습니다.

시스템에서 제공하는 두 subscriber는 모두 **Cancelable** 프로토콜을 준수하고있습니다. 

객체가 메모리에서 해제될 때마다 **전체 구독이 취소**되고 리소스를 메모리로부터 해제합니다.

## App architecture

Combine은 앱 구조에 영향을 주는 framework가 아닙니다. MVC, MVVM, VIPER 등 어디서든 사용 가능

- 코드에서 개선하려는 부분에서만 Combine 코드를 선택적으로 추가할 수 있음.
- Combine & SwiftUI의 경우에는 MVC에서 C가 필요 없음.

## Key points

1. Combine은 시간이 지남에 따라 비동기 이벤트를 처리하기 위한 선언적이고 반응적인 Framwork
2. 비동기 프로그래밍 도구를 통합하고 변경 가능한 상태를 처리하고 에러 처리와 같은 문제를 해결하려는 목적
3. Combine = publisher (이벤트 발행) -> operator (이벤트 처리, 조작) -> subscriber (결과물 소비)