# 3. Transforming Operators

## Opterator는 publisher

combine에서는 publisher를 통해 전달되는 값을 제어하는 활동을 하는 method들을 Operator라고 합니다.

이 Operator는 실제로 publisher를 반환합니다. 일반적으로 publisher는 upstream의 값을 받고 잘 조작한 데이터를 downstream으로 보냅니다.

operator의 목적이 error 처리가 아니라면 일반적으로 upstream에서 error를 수신했을 때 해당 error를 downstream에 그대로 전달합니다.

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## Operator: Collect()

Collect Operator는 publisher에서 방출하는 개별 값 stream을 array로 반환합니다.

- collect는 개별 값들을 버퍼로 갖고 있다가 upstream publisher가 완료되면 downstream에 array 형태로 방출합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/49c1de6e-2a27-4e32-94f6-0ade664cc657/Untitled.png)

### Collect() Example

publisher를 생성하고, sink Subscriber를 이용하여 Subscription을 추가했습니다.

( 아직 collect operator를 사용하지 않은 상태!! )

```swift
example(of: "collect") {
   ["A", "B", "C", "D", "E"].publisher
     .sink(receiveCompletion: { print($0) },
           receiveValue: { print($0) })
     .store(in: &subscriptions)
 }
```

```swift
——— Example of: collect ———
 A
 B
 C
 D
 E
 finished
```

이제 collect Operator를 sink 전에 넣어보겠습니다.

```swift
["A", "B", "C", "D", "E"].publisher
   .collect()
   .sink(receiveCompletion: { print($0) },
         receiveValue: { print($0) })
   .store(in: &subscriptions)
```

```
——— Example of: collect ———
 ["A", "B", "C", "D", "E"]
 finished
```

collect() 처럼 buffer를 가지는 operator를 사용할 때는 개수 제한이 없는 것을 주의하세요.

수신된 값을 저장하기 위해 무한한 양의 메모리를 사용하기 때문!

collect()로 특정 개수만큼 묶어서 array로 만들고 싶을 땐 다음과 같이 입력하면 됩니다.

특정 개수를 채우지 못하고 upstream publisher가 종료되었을 때는 부족한 대로 array를 구성해서 배출합니다.

```swift
.collect(2)
```

```
 ——— Example of: collect ———
 ["A", "B"]
 ["C", "D"]
 ["E"]
 finished
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## Operator: map(_:)

방출하는 값이 publisehr 형태라는 것만 제외하면 Swift 기본 map과 동일하게 작동합니다.

- map이 각 값에 2를 곱하는 closure를 갖는 것을 볼 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5a52187f-620d-4519-ac53-cb002ca990e8/Untitled.png)

### map(_:) Example

`123` 과 같은 숫자를 `백이십삼` 과 같은 String 타입으로 바꿔줍니다.

요기선 언어를 설정해주지 않아서 기본값인 영어로 나옴.

```swift
example(of: "map") {
   // 1 : 숫자를 개조시키기위해 formatter 생성, 스타일 spellOut으로 설정
   let formatter = NumberFormatter()
   formatter.numberStyle = .spellOut
   
   // 2 : publisher 생성
   [123, 4, 56].publisher
     // 3 : map 내부에서 formatter를 이용하여 123 -> 백이십삼으로 변경
     .map {
       formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
     }
     .sink(receiveValue: { print($0) })
     .store(in: &subscriptions)
 }
```

```swift
——— Example of: map ———
 one hundred twenty-three
 four
 fifty-six
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### tryMap(_:)

map을 포함한 여러 operator들은 error를 던져주는 closure를 가지는 try로 시작하는 이름을 가진 Operator들을 제공합니다.

```swift
example(of: "tryMap") {
   // 1 : Just를 사용해서 Publisher를 생성합니다.
   Just("Directory name that does not exist")
     // 2 : tryMap을 사용하여 존재하지 않는 dictionary 를 받도록 합니다.
     .tryMap { try FileManager.default.contentsOfDirectory(atPath: $0) }
     // 3 : 나오는 값이나 완료 이벤트를 print 하도록 합니다.
     .sink(receiveCompletion: { print($0) },
           receiveValue: { print($0) })
     .store(in: &subscriptions)
 }
```

```swift
——— Example of: tryMap ———
 failure(..."The folder “Directory name that does not exist” doesn't exist."...)
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### flatMap(maxPublishers:_:)

이건 여러 개의 upstream publisehr들을 하나의 downstream publisher로 병합할 수 있습니다.

이건 publisehr들을 값으로 방출하는 publisher를 subscribe할 때 자주 쓰입니다.

그럼 일단 publisher를 값으로 방출할 수 있는 publisher를 만들어보겠습니다.

먼저 publisher와 String 타입 프로퍼티를 가진 구조체를 선언합니다.

```swift
public struct Chatter {
   public let name: String
   public let message: CurrentValueSubject<String, Never>
   
   public init(name: String, message: String) {
     self.name = name
     self.message = CurrentValueSubject(message) // 초기값 설정!
   }
 }
```

```swift
example(of: "flatMap") {
   // 1 : Chatter 객체 2개 생성
   let charlotte = Chatter(name: "Charlotte", message: "Hi, I'm Charlotte!")
   let james = Chatter(name: "James", message: "Hi, I'm James!")
   
   // 2 : charlotte을 초기값으로 갖는 chat publisher를 생성합니다.
   // 그럼 chat은 publisher 값을 가진 publisher가 됨!
   let chat = CurrentValueSubject<Chatter, Never>(charlotte)
   
   // 3 : chat을 subscribe하고 chatter struct로부터 받는 메세지를 print 하게됩니다.
   chat
     .sink(receiveValue: { print($0.message.value) }
     .store(in: &subscriptions)
 }
```

```swift
——— Example of: flatMap ———
 Charlotte wrote: Hi, I'm Charlotte!
```

이렇게 해볼까요

```swift
// 4 : charlotte의 message(publisher)의 value를 변경합니다.
 charlotte.message.value = "Charlotte: How's it going?"

 // 5 : chat publisher의 현재 값을 james로 변경합니다.
 chat.value = james
```

그럼 이런 출력문이 나옵니다.

```swift
Charlotte wrote: Hi, I'm Charlotte!
 James wrote: Hi, I'm James!
```

우린 chat 이라는 publisher를 방출하는 publisher를 구독했어요.

그 chat은 publisher인 charlotte를 초기값으로 가지고있으니 초기값을 받아 출력했고,

그 이후에 value에 할당된 james가 있죠!

이 james도 sink가 받아서 출력을 해준 겁니다!

그럼 charlotte의 message 퍼블리셔의 값은 왜 받지 못했을까요?

그 이유는 단순히 우리가 구독을 하지 않았기 때문!

message 퍼블리셔 구독 안했자나요 우리

chat만 구독했자나용

그래서 위와 같은 출력문이 나온다~!

그럼 만약 모든 chat의 message를 subscribe하고싶다면? flat map!

위에서 아래로 변경해봅시다.

```swift
chat
   .sink(receiveValue: { print($0.message.value) })
   .store(in: &subscriptions)

... 

chat
   // 6
   .flatMap { $0.message }
   // 7
   .sink(receiveValue: { print($0) })
   .store(in: &subscriptions)
```

chat은 자신이 가진 publisher 즉, charlotte와 james 값을 가지고 있는 상태입니다.

flatMap은 그 publisher들의 message를 sink에게 전달합니다.

그래서 sink는 그 publisher들의 message를 각각 구독하게 됩니다!

이제 charlotte의 새 메시지가 출력됩니다.

```swift
Hi, I'm Charlotte!
 Charlotte: How's it going?
 Hi, I'm James!
```

그리고 flatMap의 메모리 사용을 관리하기 위해 몇개의 publisher만 받아 버퍼로 둘지 설정할 수 있습니다.

요롷게 하면 publisehr 2개만 받고 나머지 빠이빠이

```swift
.flatMap(maxPublishers: .max(2)) { $0.message }
```

자 그림..! 드디어 그림….

그림을 보고 이해해봅시다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fe46b0c4-7841-4ef9-884b-9f0fe680f50b/Untitled.png)

flatMap은 3개의 퍼블리셔를 받습니다.

각 퍼블리셔들은 value property를 갖고 있고 이 value 또한 publisher입니다.

flatMap은 P1, P2의 value publisher를 방출하지만 P3는 무시합니다.

왜냐하면 maxPublisher를 2로 설정해주었기 때문입니다.

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## ****upstream output 바꾸기****

map 예제에서 ?? 연산자를 사용해서 nil 값을 nil이 아닌 값으로 변환해주었는데요.

```swift
   [123, 4, 56].publisher
     // 3 : map 내부에서 formatter를 이용하여 123 -> 백이십삼으로 변경
     .map {
       formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
     }
```

Combine에 그런 기능을 가진 연산자가 있따고 하네요.

### replaceNil(with:)

- 이친구는 옵셔널 값을 받고 있고 nil이면 설정한 값으로 변환해주네요.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7e7a58cf-198b-4902-97a3-68dd6c1aa58d/Untitled.png)

```swift
example(of: "replaceNil") {
   // 1 : 옵셔널 문자 배열 publisher 선언
   ["A", nil, "C"].publisher
     .replaceNil(with: "-") // 2 : nil 값을 nil이 아닌 값으로 바꿔줍니다.
     .sink(receiveValue: { print($0) }) // 3
     .store(in: &subscriptions)
 }
```

출력하면

```swift
——— Example of: replaceNil ———
 Optional("A")
 Optional("-")
 Optional("C")
```

넵 여기서 정신 똑바로 차려야합니다.

저희는 옵셔널 값을 옵셔널이 아닌 값으로 변경하는 것이 아니라

nil값을 nil이 아닌 값으로 전환하는 것이기 때문에

옵셔널 타입인 건 여전하므로~ 저렇게 Optional로 꽁꽁 싸매서 나오는 거랍니다.

여기서 옵셔널이 아닌 값으로 바꿔주고 싶으면

그냥 map으로 강제 언래핑해조야 합니다.

```swift
["A", nil, "C"].publisher
    .replaceNil(with: "-")
    .map { $0! }
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
```

그럼 ?? 랑 replaceNil이랑 차이점이 머냐??

?? 연산자는 다른 optional값을 반환할 수 있지만 replaceNil은 optional 값을 반환할 수 없다고 하네요.

```swift
.replaceNil(with: "-" as String?)
```

요롷게 옵셔널타입 넣으면   $빽빽!!!! 옵셔널 타입 넣지마러!!!!$   하구 오류남

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### replaceEmpty(with:)

publisher가 값 방출 없이 완료되었을 때 이 연산자를 이용해서 값 방출 없음을 값으로 전환하거나 값 자체를 삽입해줄 수 있습니다.

그림을 보면 publisher가 방출 없이 완료된 후 replace엠띠 연산자가 값을 넣어준 후

 downstream으로 보내주네요.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/10f84f10-45f2-48a8-8708-2fdd381ed887/Untitled.png)

코오드를 보잡

```swift
example(of: "replaceEmpty(with:)") {
   // 1 : 즉시 완료 이벤트를 방출하는 빈 publisher를 생성합니다.
   let empty = Empty<Int, Never>()
   
   // 2 : 이를 구독하고 받은 이벤트를 print 합니다.
   empty
     .sink(receiveCompletion: { print($0) },
           receiveValue: { print($0) })
     .store(in: &subscriptions)
 }
```

Empty publisher가 나왔어요.

이 타입은 즉시 완료이벤트를 방출하는 publisher를 생성하는 친구여요.

또 원래 완료 이벤트가 전달이 되잖아요? 근데 그것마저도 전달하지 말라고

completeImmediately parameter를 false로 설정할 수 있다고….하네요.

참고로 `completeImmediately`의 기본값은 `true`!

이 publisher는 데모나 테스트 목적으로 사용하거나 subscriber에게 완료 이벤트만 전달하고 싶을 때 유용합니다. 라고 하네요.

이 놈을 삽입하면 어떻게 될까요

```swift
.replaceEmpty(with: 1)
```

넵

1 찍히고

finished 됩니다.

이번 예제에서는 완료 이벤트를 받기로(true)해서 완료 이벤트까지 깔꼼하게 나왔네용.

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### 와!!!! 마지막이다 !!!! **Incrementally transforming output!!!!!!!!!**

### scan(_:_:)

이놈은 설명을 들으면 안됨 바로 예제로 가야댐

초기값 0을 설정해 준다음! 받은 값들을 0에 축적해서 더해줄 수 있음! reduce로 합치는 것 같당 ㅎ

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1e171bd2-c2c1-4558-8eee-2b59046754f7/Untitled.png)

```swift
example(of: "scan") {
   // 1 : -10부터 10 사이의 정수를 랜덤으로 생성하는 property를 생성합니다.
   var dailyGainLoss: Int { .random(in: -10...10) }

   // 2 : 이 놈을 이용해서 한 달동안 가상의 일일 주가 변동을 
// 나타내는 임의의 정수 array publisher를 생성합니다.
   let august2019 = (0..<22)
     .map { _ in dailyGainLoss }
     .publisher

   // 3 : 시작 값으로 50을 가지는 scan을 사용하여 매일 변경 사항을 주가에 추가합니다. 
		// max를 사용하면 가격은 음이 아닌 값을 유지하게 됩니다.
   august2019
     .scan(50) { latest, current in
       max(0, latest + current)
     }
     .sink(receiveValue: { _ in })
     .store(in: &subscriptions)
 }
```

그러니까 한달 대충 30개의 일일 주가 변동의 값을 가진 publisher가 있어용.

그리고 우리는 한달동안의 주가 그래프를 그려볼 거예요

주가 그래프는 50에서 시작하고!

publisher에서 일일 주가 변동 값을 받아서

그 값을 초기값 50에 더해요! 일일 주가 변동 값은 음수 또는 양수이기때문에 

좀 떨어질 때도 있고 올라갈 때도 있겠죵

그렇게 계속해서 값을 축적하는 거죠!

그리고 max를 사용하면 주가 값이 음이 아닌 값을 유지하게 된다네요.

<br>
<Br>
<Br>

--

<br>
<Br>
<Br>

## **Summary**

- publisher의 output을 통해 작업을 수행하는 method를 operator라고 합니다.
- operator도 publisher입니다.
- transforming operator는 upstream publisher의 input을 downstream이 사용하기에 적합한 output 형태로 변환합니다.
- 마블 다이어그램은 각 operator들의 작동 방식을 시각화하는 좋은 방법입니다.
- 메모리 문제를 피하려면 `collect`, `flatMap`과 같이 값을 버퍼로 두는 operator를 사용할 때 주의하세요.
- Swift의 기존 라이브러리에서 적용되던 지식을 Combine에 그대로 적용하면 안됩니다. 비슷한 이름의 Combine operator는 비슷하게 동작할 수 있지만 그 외 operator는 완전히 다르게 작동합니다.
- 하나의 subscription에 여러 operator를 함께 연결할 수 있습니다.