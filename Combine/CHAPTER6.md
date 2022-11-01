# 6. Time Manipulation Operators

### delay(for:tolerance:scheduler:options) : Operator

Publisher의 값을 Downstream으로 보내기 전에 일정 시간만큼 기다립니

upstream publisher에서 interval만큼 delay된 시간에 값을 downstream으로 emit한다.

**매개변수**

- **interval:** Downstream으로 값을 내려보내기 전에 기다릴 시간
- **scheduler:** 지연된 이벤트를 전달하는 스케줄러

**원 안의 숫자들은 실제 그들의 값이 아닌 emit 된 count 를 반영한다.**

```swift
let valuesPerSecond = 1.0
let delayInSeconds = 1.5

// 1: Timer 타입의 값을 방출하는 Subject 생성
let sourcePublisher = PassthroughSubject<Date, Never>()

// 2: SourcePublisher에서 값을 지연시키고 기본 스케줄러에서 값을 내보냅니다.
let delayedPublisher = sourcePublisher.delay(for: .seconds(delayInSeconds), scheduler: DispatchQueue.main)

// 3: 메인스레드에서 초당 하나의 값을 전달하는 타이머를 만듭니다.
//    autoconnect()로 값을 방출할 수 있게 해줍니다.
let subscription = Timer
    .publish(every: 1.0 / valuesPerSecond, on: .main, in: .common)
    .autoconnect()
    .subscribe(sourcePublisher) // timer가 값을 보낼 subject
```


<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### **TimerPublisher**?

ConnectablePublisher protocol을 준수하고 있는 TimerPublisher

Timer.publish 하게되면, 지정한 시간마다 현재 날짜를 반복적으로 방출하는 **TimerPublisher**가 만들어집니다.

TimeoPublisher는 ConnectablePublisher protocol을 준수하는 타입이기 때문에, connect() 함수를 

호출하지 않으면 값을 생성하지 않습니다. 이때 자동으로 connect 하기 위한 autoconnect() 함수를 

publish 선언 줄 맨 뒤에 연결해 주면 값이 잘 나오는 것을 확인할 수 있습니다.

```swift
let subscription = Timer
    .publish(every: 1.0 / valuesPerSecond, on: .main, in: .common)
    .autoconnect()
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## Collecting values

### Collect()

특정 시간 간격으로 Publisher로부터 방출되는 값을 수집할 수 있습니다.

```swift
let valuesPerSecond = 1.0
let collectTimeStride = 4
let collectMaxCount = 2

// 1: 타이머가 방출하는 값을 전달하는 Subject
let sourcePublisher = PassthroughSubject<Date, Never>()

// 2: 4초 간격으로 모아둔 값을 담은 배열을 생성합니다.
let collectedPublisher = sourcePublisher
  .collect(.byTime(DispatchQueue.main, .seconds(collectTimeStride)))
  .flatMap { dates in dates.publisher }

// 3: 2개씩 모아서 배열을 생성한다.
let collectedPublisher2 = sourcePublisher
  .collect(.byTimeOrCount(DispatchQueue.main, .seconds(collectTimeStride), collectMaxCount))
  .flatMap { dates in dates.publisher }

//3: 1초마다 Date를 방출하는 TimerPublisher 생성하고 값을 sourcePublisher로 전달합니다.
let subscription = Timer
  .publish(every: 1.0 / valuesPerSecond, on: .main, in: .common)
  .autoconnect()
  .subscribe(sourcePublisher)

let sourceTimeline = TimelineView(title: "Emitted values:")
let collectedTimeline = TimelineView(title: "Collected values (every \(collectTimeStride)s):")

let collectedTimeline2 = TimelineView(title: "Collected values (at most \(collectMaxCount) every \(collectTimeStride)s):")

let view = VStack(spacing: 40) {
  sourceTimeline
  collectedTimeline
  collectedTimeline2
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

sourcePublisher.displayEvents(in: sourceTimeline)
collectedPublisher.displayEvents(in: collectedTimeline)
collectedPublisher2.displayEvents(in: collectedTimeline2)
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## **Holding off on events**

### Debounce

이는 업스트림의 Publisher의 전송 간격과 개수를 제어합니다.

마지막 값이 send된 후 설정한 시간이 지날 때 까지 다른 값이 send되지 않았다면 그 값을 방출합니다.

```swift
// 1: String 값을 방출하는 subject Publisher 생성
let subject = PassthroughSubject<String, Never>()

// 2: 1초 뒤에도 다른 값이 들어오지 않는다면 값 방출
let debounced = subject
  .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
  // 3: 하나의 upstream publisher의 output을 여러 subscriber들이 공유할 수 있도록 해준다.
  .share()

let subjectTimeline = TimelineView(title: "Emitted values")
let debouncedTimeline = TimelineView(title: "Debounced values")

let view = VStack(spacing: 100) {
  subjectTimeline
  debouncedTimeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

subject.displayEvents(in: subjectTimeline)
debounced.displayEvents(in: debouncedTimeline)

// debounced를 사용하지 않은 subject
let subscription1 = subject
  .sink { string in
    print("+\(deltaTime)s: Subject emitted: \(string)")
  }

// debounced를 사용한 subject
let subscription2 = debounced
  .sink { string in
    print("+\(deltaTime)s: Debounced emitted: \(string)")
  }

subject.feed(with: typingHelloWorld)
```

```
+0.0s: Subject emitted: H
+0.1s: Subject emitted: He
+0.2s: Subject emitted: Hel
+0.3s: Subject emitted: Hell
+0.5s: Subject emitted: Hello
+0.6s: Subject emitted: Hello 
+1.6s: Debounced emitted: Hello // !!
+2.1s: Subject emitted: Hello W
+2.2s: Subject emitted: Hello Wo
+2.2s: Subject emitted: Hello Wor
+2.5s: Subject emitted: Hello Worl
+2.5s: Subject emitted: Hello World
+3.5s: Debounced emitted: Hello World // !!
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### **throttle(for:scheduler:latest:)**

일정 시간을 기다린 뒤 해당 시간 동안 수신한 값 중 가장 첫 번째 값이나 최신 값을 Downstream으로 전달한다.

throttle을 사용하면 일정 시간 동안 Upstream Publisher에게 받은 값 중 최신 값 또는 첫 번째 값을

Downstream에 전달할 수 있다

- **interval:** 값을 내려보내기 전에 Upstream Publisher에게 값을 받는 시간 간격입니다.
- **latest:** 일정 시간 동안 받은 값 중 최신 값을 내려보낼지 첫 번째 값을 내려보낼지 결정하는 Bool 값입니다.

latest 인자에 false를 넣으면 특정 주기 안의 첫번째 value가 출력됩니다.

latest 인자에 true를 넣으면 특정 주기 안의 마지막 value가 출력됩니다.

```swift
let throttleDelay = 1.0

// 1: String 값을 방출하는 Subject를 생성합니다.
let subject = PassthroughSubject<String, Never>()

// 2: 1초마다 받은 값들 중 마지막 값을 출력합니다.
let throttled = subject
  .throttle(for: .seconds(throttleDelay), scheduler: DispatchQueue.main, latest: true)
  .share()

let subjectTimeline = TimelineView(title: "Emitted values")
let throttledTimeline = TimelineView(title: "Throttled values")

let view = VStack(spacing: 100) {
  subjectTimeline
  throttledTimeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

subject.displayEvents(in: subjectTimeline)
throttled.displayEvents(in: throttledTimeline)

let subscription1 = subject
  .sink { string in
    print("+\(deltaTime)s: Subject emitted: \(string)")
  }

let subscription2 = throttled
  .sink { string in
    print("+\(deltaTime)s: Throttled emitted: \(string)")
  }

subject.feed(with: typingHelloWorld)
```

latest가 false일 때의 출력, 들어온 값 중 첫번째 value를 방출한다.

```
+0.0s: Subject emitted: H
+0.0s: Throttled emitted: H
+0.1s: Subject emitted: He
+0.2s: Subject emitted: Hel
+0.3s: Subject emitted: Hell
+0.5s: Subject emitted: Hello
+0.6s: Subject emitted: Hello 
+1.0s: Throttled emitted: He
+2.2s: Subject emitted: Hello W
+2.2s: Subject emitted: Hello Wo
+2.2s: Subject emitted: Hello Wor
+2.4s: Subject emitted: Hello Worl
+2.7s: Subject emitted: Hello World
+3.0s: Throttled emitted: Hello W
```

latest가 true일 때의 출력, 들어온 값 중 마지막 value를 방출한다.

```
+0.0s: Subject emitted: H
+0.0s: Throttled emitted: H
+0.1s: Subject emitted: He
+0.2s: Subject emitted: Hel
+0.3s: Subject emitted: Hell
+0.5s: Subject emitted: Hello
+0.6s: Subject emitted: Hello 
+1.0s: Throttled emitted: Hello
+2.0s: Subject emitted: Hello W
+2.3s: Subject emitted: Hello Wo
+2.3s: Subject emitted: Hello Wor
+2.6s: Subject emitted: Hello Worl
+2.6s: Subject emitted: Hello World
+3.0s: Throttled emitted: Hello World
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## Timing out

### timeout

특정 시간안에 이벤트가 없으면 종료됩니다.

특정 시간안에 이벤트가 없으면 지정해놓은 오류가 발생되게 하거나, Publisher를 완료할 수 있습니다.

```swift
enum TimeoutError: Error {
  case timedOut
}

let subject = PassthroughSubject<Void, TimeoutError>()

// 1: 5초 안에 이벤트가 발생하지 않으면 지정해둔 오류 발생되게 하기
let timedOutSubject = subject.timeout(.seconds(5), scheduler: DispatchQueue.main, customError: { .timedOut })

// 1-1: 5초 안에 입네트가 발생하지 않으면 완료되게 하기
// let timedOutSubject = subject.timeout(.seconds(5), scheduler: DispatchQueue.main)

let timeline = TimelineView(title: "Button taps")

let view = VStack(spacing: 100) {
  // 1
  Button(action: { subject.send() }) {
    Text("Press me within 5 seconds")
  }
  timeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

timedOutSubject.displayEvents(in: timeline)
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## Measuring time

### measureInterval

Publisher가 방출한 두 값 사이에 경과된 시간을 측정할 수 있습니다.

```swift
var subscriptions = Set<AnyCancellable>()

let intPublisher = PassthroughSubject<Int, Never>()

intPublisher
    .measureInterval(using: DispatchQueue.main, options: nil)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { nanoSecond in
        print("Measure Time: \(floor(Double(nanoSecond.magnitude) / 1_000_000_000.0))초")
    })
    .store(in: &subscriptions)

// 바로 방출되어서 0초
intPublisher.send(1)

sleep(1)

// 1초 뒤에 방출되어서 1초
intPublisher.send(2)

sleep(2)

// 2초 뒤에 방출되어서 2초
intPublisher.send(3)
```

```
Measure Time: 0.0초
Measure Time: 1.0초
Measure Time: 2.0초
```