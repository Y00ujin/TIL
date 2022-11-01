# 5. ****Combine Operators****

이 operator들을 통해 다른 publisher가 방출하는 이벤트를 결합(combine)하고 다양한 데이터 조합을 만들 수 있습니다.

## Prepending Operators

prepend 계열 operator들은 원래의 publisher의 값보다 먼저 방출되는 값을 준비하여 전달하게 됩니다.

즉, 앞쪽에 값을 추가하여 먼저 방출되고 기존의 publisher의 값이 방출되게 됩니다.

`prepend(Output...)`, `prepend(Sequence)` 및 `prepend(Publisher)` 에 대해 다뤄보겠습니다.

### prepend(Output…)

원래의 publisher와 동일한 output type의 값들을 취하게 되고, 

취한 값들은 원래의 publisher에 앞서 차례로 방출됩니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/86c753bf-15c8-4616-b81a-453bdedd992c/Untitled.png)

```swift
// 1: 3, 4 라는 값을 방출하는 publisher를 선언합니다.
 let publisher = [3, 4].publisher
   
 // 2: prepend 를 활용하여 기존의 pulbisher의 값 방출 이전에 1, 2 라는 값이 방출되도록 합니다.
 publisher
   .prepend(1, 2)
   .sink(receiveValue: { print($0) })
   .store(in: &subscriptions)
```

```
 1
 2
 3
 4
```

 `.prepend(-1, 0)` 를 체인 맨 앞에 넣으면 아래와 같은 출력이 나옵니다.

• 여기서 주목할 것은 operator의 실행 순서입니다. 마지막에 연결된 prepend부터 upstream에 영향을 미치기 때문에 `-1`과 `0`이 앞에 있고, 그 다음에 `1` `2`, 마지막으로 원래의 publisher 값이 출력되게 됩니다.****

```swift
 publisher
   .prepend(1, 2)
   .prepend(-1, 0)
   .sink(receiveValue: { print($0) })
   .store(in: &subscriptions)
```

```swift
-1
 0
 1
 2
 3
 4
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### prepend(Sequence)

이번 operator는 방금 다룬 것과 거의 비슷합니다. 다만 sequence를 받는 것만 다른 점이죠. 예를 들면 `Array`
나 `Set`을 받을 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8d5e84b6-a352-4bcc-b882-9d53ebdcb653/Untitled.png)

```swift
// 1: 5, 6, 7을 방출하는 publisher를 선언합니다.
 let publisher = [5, 6, 7].publisher
   
 // 2: prepend(Sequence) 를 두 번 활용하여 기존의 publisher에 연결합니다. 
// 처음엔 Set, 두 번째에는 Array가 불려질겁니다.
 publisher
   .prepend([3, 4])
   .prepend(Set(1...2))
   .sink(receiveValue: { print($0) })
   .store(in: &subscriptions)
```

```swift
 1
 2
 3
 4
 5
 6
 7
```

보시다시피 최종적으로 선언된 아이부터 upstream에 영향을 미치고 다음 prepend가 차례차례 실행된 다음 원래의 publisher가 값을 방출하게 됩니다.****

```swift
// 1: 5, 6, 7을 방출하는 publisher를 선언합니다.
 let publisher = [5, 6, 7].publisher
   
 // 2: prepend(Sequence) 를 두 번 활용하여 기존의 publisher에 연결합니다. 
// 처음엔 Set, 두 번째에는 Array가 불려질겁니다.
 publisher
   .prepend([3, 4]) // 3
   .prepend(Set(1...2)) // 2
   .prepend(stride(from: 6, to: 11, by: 2))	//얘를 추가해주세요 1
   .sink(receiveValue: { print($0) })
   .store(in: &subscriptions)
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### prepend(Publisher)

publisher의 값 앞에 두 번째 publisher가 방출한 값을 추가하려면 `prepend(Publisher)`를 사용할 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0a921894-7bcb-4676-9a6a-eee412dcdc06/Untitled.png)

```swift
// 1: 두 개의 publisher를 만들었습니다. 하나는 3, 4를 방출하고 다른 하나는 1, 2를 방출하겠네요.
let publisher1 = [3, 4].publisher
let publisher2 = [1, 2].publisher

// 2: publisher2를 publisher1 뒤에 붙입니다. 
// 이로써 publisher1의 값들은 publisher2의 값들이 모두 방출된 다음에 방출될 것입니다.
publisher1
  .prepend(publisher2)
  .sink(receiveValue: { print($0) })
  .store(in: &subscriptions)
```

```
 1
 2
 3
 4
```

한가지 더 알아봅시다• 이 예제는 이전 예제와 비슷하지만, `publisher2`의 타입을 값을 수동으로 푸시할 수 있는 `PassthroughSubject` 로 설정했습니다.

```swift
// 1
let publisher1 = [3, 4].publisher
let publisher2 = PassthroughSubject<Int, Never>()

// 2
publisher1
  .prepend(publisher2)
  .sink(receiveValue: { print($0) })
  .store(in: &subscriptions)

// 3
publisher2.send(1)
publisher2.send(2)
```

```
 1
 2
```

publisher2가 방출한 값만 전달되었습니다.

publisehr2가 값 방출을 끝낸 상태일까요? 다시보면 값을 방출하긴 했는데 완료이벤트는 없습니다.

먼저 진행된 publisher는 반드시 완료되어야합니다. 그래야 다음 publisher가 값 방출을 시작할 수 있겠죠.

- 위 예제의 마지막 코드 뒤에 다음 코드를 추가합시다.
    
    `publisher2.send(completion: .finished)`
    

이렇게 하면 Combine이 `publisher2`가 종료된 것을 인지하고 `publisher1`에서 값이 방출될 수 있도록 할 겁니다. 코드를 실행해볼까요. $얍.$

```
 1
 2
 3
 4
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


## Appending Operator

이번에 다룰 operator들은 publisher가 방출한 이벤트를 다른 값과 연결하는 아이들입니다..

### append(Output…)

원래의 publisher가 `.finished`이벤트로 완료한 후에 항목을 추가하게 됩니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/20bdf122-f002-48fd-971b-3aa844225928/Untitled.png)

```swift
// 1 : 1 하나의 값을 방출하는 publisher를 생성합니다.
 let publisher = [1].publisher
 	
 // 2 : append를 두 번 사용합니다. 첫 번째 append에는 2와 3을 넣어주고 4를 추가하는 두 번째 append를 추가합니다.
 publisher
 	.append(2, 3)
 	.append(4) 
 	.sink(receiveValue: { print($0) })
 	.store(in: &subscriptions)
```

각각의 `append` 연산자들은 upstream이 완료된 후에 자신의 값을 추가하게 됩니닫.

이 것은 곧 upstream이 **반드시 완료(complete)** 되어야 한다는 것을 의미합니다. 그렇지 않으면 Combine이 직전의 publisher가 종료되었다는 것을 알지 못해서 아무런 작동을 하지 않는 것처럼 보일테니까요.

확인을 위해 다음 코드를 작성해봅시다.

```swift
// 1
let publisher = PassthroughSubject<Int, Never>()

publisher
	.append(3, 4)
	.append(5)
	.sink(receiveValue: { print($0) })
	.store(in: &subscriptions)
  
// 2
publisher.send(1)
publisher.send(2)
```

- 위 코드는 앞서 작성한 코드와 유사하지만 두 가지 차이점이 있습니다.
    1. `publisher`가 이제 `PassthroughSubject`가 되었네요, 즉 수동으로 값을 보낼 수 있게 되었습니다.
    2. `PassthroughSubject`를 통해 `1`과 `2`를 보냈습니다.

```
 1
 2
```

두개의 append 연산자는 실행되지 않습니다! 

왜냐면 상위의 publisher가 완료되지 않았기 때문!

앞서 작성한 코드 마지막에 아래 코드를 추가하여 `publisher`를 완료시켜줍시다.

 `publisher.send(completion: .finished)`

그럼 잘 나오네요!

```
 1
 2
 3
 4
 5
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### append(Sequence)

Sequence를 받는 append 연산자입니당

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a7adb4fb-6f2c-40ff-a0b9-84cbbd3c01fb/Untitled.png)

```swift
// 1
let publisher  = [1, 2, 3].publisher

publisher
	.append([4, 5])	//  2
	.append(Set([6, 7]))	// 3
	.append(stride(from: 8, to: 11, by: 2))	// 4
	.sink(receiveValue: { print($0) })
	.store(in: & subscriptions)
```

- 위 코드는 우리가 `prepend(Sequence)`를 확인할 때 작성했던 코드와 유사합니다. 하나씩 따라가보면,
    1. `1`, `2`, `3`을 뱉는 `publisher`를 작성해줍니다.
    2. `4`, `5` 값과 순서를 갖는 `Array`를 append 해줍니다.
    3. `6`, `7` 값과 순서를 갖지 않는 `Set`를 append 해줍니다.
    4. `8`부터 `11`까지 `2`의 간격으로 값을 뱉는 `Striddeable`을 추가해줍니다.
    
- 보시다시피 `append` 연산자들은 상위 `publisher`들이 반드시 완료된 이후에 동작하게 됩니다.
- 주석에 표현한 것처럼 `6`과 `7`은 순서를 보장하지 않으므로 방출 순서가 바뀔 수 있습니다.

```
1
2
3
4
5
7	// 순서가 바뀔 수 있음
6	// 순서가 바뀔 수 있음
8
10
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### append(Publisher)

 `publisher2`를 `publisher1`에 `append` 합니다. 따라서 `publisher2`가 방출하는 모든 값은 `publisher1`의 값이 모두 방출된 이후에 방출될 것입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/48233268-4973-4057-923c-2d13f8ffd0ae/Untitled.png)

```swift
// 1
 let publisher1 = [1, 2].publisher
 let publisher2 = [3, 4].publisher
   
 // 2
 publisher1
 	.append(publisher2)
 	.sink(receiveValue: { print($0) })
 	.store(in: &subscriptions)
```

```swift
 1
 2
 3
 4
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


## 고급 Combining

- 지금까지 appending과 prepending에 대한 모든 내용을 확인했습니다.
- 이제 서로 다른 `publisher`들이 좀 더 복잡하게 결합하는 operator들에 대해 확인해볼 것입니다.

### switchToLatest

- 최신의 publisher가 값을 방출할 때 기존의 publisher의 구독을 취소하고 최신의 publisher로 구독을 전환합니다.
- 따라서 이 연산자는 오직 스스로 publisher들을 방출하는 publisher에게만 사용할 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8b115a20-883c-4856-be55-a95ae3d04865/Untitled.png)

```swift
// 1: 세 개의 PassthroughSubjects를 만들었구요, 정수를 방출하고 에러는 발생시키지 않는 애들입니다.
let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<Int, Never>()
let publisher3 = PassthroughSubject<Int, Never>()
	
// 2; 그 다음엔 다른 PassthroughSubject를 받는 PassthroughSubject를 만들었습니다. 
//예를 들면 앞서 만든 publisher1, publisher2, publisher3를 이 publishers로 넣을 수 있겠네요.
let publishers = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()
	
// 3: switchToLasted를 publishers에 사용합니다. 
// 이제 매번 서로 다른 publisher들이 publishers subject를 통해서 보내질 것이고 
// 이 때마다 새로운 publisher로 전환(switch) 하고 이전의 구독을 취소하게 될거예요. 
publishers
	.switchToLatest()
	.sink(receiveCompletion: { _ in print("Completed!") },
		receiveValue: { print($0) })
	.store(in: &subscriptions)
	
// 4: publisher1을 publishers로 보냅니다. 그리고 publisher1을 통해 1과 2를 보냅니다.
publishers.send(publisher1)
publisher1.send(1)
publisher1.send(2)
	
// 5: 이제 publisher2를 publishers로 보냅니다. 
// 이를 통해 publisher1에 대한 구독은 취소될거예요. 
// 3을 publisher1을 통해 보내줍니다만 이건 무시되겠죠. 
// 그리고 4와 5를 publisher2를 통해 보내줍니다. 이들은 방출될 겁니다. 
// 이제 publisher2가 현재 구독되는 publisher일테니까요.
publishers.send(publisher2)
publisher1.send(3)
publisher2.send(4)
publisher2.send(5)
	
// 6: publisher3을 보내고 이는 publisher2에 대한 구독을 취소시킬겁니다. 
// 이 후에 6을 publisher2를 통해 보내지만 이 역시 무시될겁니다. 
// 이 후 publisher3을 통해 보내지는 6, 7, 8, 9는 구독될겁니다.
publishers.send(publisher3)
publisher2.send(6)
publisher3.send(7)
publisher3.send(8)
publisher3.send(9)
	
// 7: 마지막으로, completion 이벤트를 현재 구독되는 publisher인 
// publisher3을 통해 보내줍니다. 그리고 또 다른 completion 이벤트를
// publishers에게도 보내줍니다. 이를 통해 현재 활성화 상태인 모든 구독은 완료될겁니다.
publisher3.send(completion: .finished)
publishers.send(completion: .finished)
```

이는 실제 앱에서 아래와 같은 상황에서 쓰일 수 있습니다.

네트워크 요청하는 버튼을 사용자가 여러번 클릭할 때, 마지막 요청에 대해서만 처리하고 싶을 때 사용합니다.

```swift
let url = URL(string: "https://source.unsplash.com/random")!
   
 // 1: 이미지를 가져오는 함수를 생성합니다.
 func getImage() -> AnyPublisher<UIImage?, Never> {
 	return URLSession.shared
 		.dataTaskPublisher(for: url)
 		.map { data, _ in UIImage(data: data) }
 		.print("image")
 		.replaceError(with: nil)
 		.eraseToAnyPublisher()
 }
 
 // 2: 사용자의 버튼 탭 액션을 방출하는 subject publisher를 생성합니다.
 let taps = PassthroughSubject<Void, Never>()
 
// 버튼이 탭 되면 taps는 무작위 이미지를 받아오는 네트워크 요청인 getImage()로 매핑될겁니다.
// 즉 Publisher<Void, Never>가 publisher들의 publisher인 
// Publisher<<Publisher<UIImage?, Never>, Never>로 변환할겁니다
 taps
 	.map { _ in getImage() }
 	.switchToLatest() // 4: 이로써 새로운 publisher가 나올 때마다 
										// 직전의 publisher에 대한 구독을 취소하게 될겁니다.
 	.sink(receiveValue: { _ in })
 	.store(in: &subscriptions)
 
 // 5
// DispatchQueue를 활용하여 3개의 버튼 탭 이벤트를 구현합니다.
// 첫 번째 탭은 즉시 발생할거구요, 두 번째 탭은 3초 뒤에,
// 세 번째 탭은 두 번째 탭이 발생하고 0.1초 뒤에 발생할겁니다.
 taps.send()
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
 	taps.send()
 }
 DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
 	taps.send()
 }
```

```swift
image: receive subscription: (DataTaskPublisher)
 image: request unlimited
 image: receive value: (Optional(<UIImage:0x600000364120 anonymous {1080, 720}>))
 image: receive finished
 image: receive subscription: (DataTaskPublisher)
 image: request unlimited
 image: receive cancel // 취소됨!!!!!!!!!!!!!!!!
 image: receive subscription: (DataTaskPublisher)
 image: request unlimited
 image: receive value: (Optional(<UIImage:0x600000378d80 anonymous {1080, 1620}>))
 image: receive finished
```

• 여기서 주목해야할 것은 실제 2개의 이미지만 가져왔다는겁니다. 왜냐하면 두 번째 탭 0.1초 뒤에 불린 세 번째 탭으로 인해 두 번째 탭에 대한 구독은 취소되었기 때문입니다. 이 것이 `image: receive cancel`라고 표현된 것이죠.

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### merge(with:)

이 연산자는 서로 같은 타입의 publisher를 **교차**하며 나타낼 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/add9378e-9dd0-45b9-a407-e52901b37a78/Untitled.png)

```swift
// 1: 두 개의 PassthroughSubject를 만들어줍니다. 둘다 Int 타입을 받고 에러는 방출하지 않습니다.
 let publisher1 = PassthroughSubject<Int, Never>()
 let publisher2 = PassthroughSubject<Int, Never>()
 
 // 2: publisher1과 publisher2를 합쳐(Merge) 줍니다. 
// Combine을 통해 이러한 방식으로 최대 8개의 서로 다른 publisher를 merge 할 수 있습니다.
 publisher1
 	.merge(with: publisher2)
 	.sink(receiveCompletion: { _ in print("Completed") },
       		receiveValue: { print($0) })
 	.store(in: &subscriptions)
 
 // 3: 1과 2를 publisher1에서 보내주고 3을 publisher2로, 
// 그리고 다시 4를 publisher1에 넣어주고 마지막으로 5를 publisher2를 통해 전달합니다.
 publisher1.send(1)
 publisher1.send(2)
 
 publisher2.send(3)
 
 publisher1.send(4)
 
 publisher2.send(5)
 
 // 4: 두 publisher에 완료 이벤트를 보냅니다.
 publisher1.send(completion: .finished)
 publisher2.send(completion: .finished)
```

```
1
2
3
4
5
Completed
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### CombineLatest

이를 사용하면 서로 다른 publisher들을 결합시킬 수 있습니다. 또한 결합되는 publisher들이 같은 타입일 필요 x

단, 상호 교차하며 서로 다른 타입을 방출하는 것이 아니라 이런 타입을 tuple 형태로 묶어서 방출하게 됩니다.

또 combineLatest로 결합된 모든 publisehr들은 최소 한 번은 값을 방출해야합니다.!!!!!!!!!!!!!!!!!!!!!!!!!

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bdf8c365-a47c-4b60-80cd-c6cc95828a46/Untitled.png)

```swift
// 1: 두 개의 PassthroughSubject를 만들어줍니다. 
// 하나는 Int 타입을 받구요, 다른 하나는 String 타입을 받습니다. 둘다 에러는 없네요.
let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<String, Never>()
	
// 2: publisher2를 publisher1과 결합시켜줍니다. 
// Combine을 통해서는 한 번에 최대 4개의 서로 다른 publisher들을 결합할 수 있습니다.
publisher1
	.combineLatest(publisher2)
	.sink(receiveCompletion: { _ in print("Completed") },
		receiveValue: { print("P1: \($0), P2: \($1)") })
	.store(in: &subscriptions)
	
// 3: publisher1에 1, 2를 보내고 publisher2에 "a"와 "b"를 보냅니다.
// 그리고 publisher1에 3을, publisher2에 "c"를 보내보죠.
publisher1.send(1)
publisher1.send(2)
  
publisher2.send("a")
publisher2.send("b")
  
publisher1.send(3)
  
publisher2.send("c")
	
// 4
publisher1.send(completion: .finished)
publisher2.send(completion: .finished)
```

```swift
P1: 2, P2: a
 P1: 2, P2: b
 P1: 3, P2: b
 P1: 3, P2: c
 Completed
```

- 보시면 `publisher1`이 방출한 `1`은 `combineLatest`를 통해서는 보여지지 않는 것을 확인할 수 있습니다.
- 이는 `combineLatest`는 모든 publisher들이 최소 1개의 값을 방출한 다음부터 동작하기 때문입니다.
- 여기서는 `"a"`가 방출되었을 때 가장 최신의 `publisher1` 값은 `2`였기 때문에 `(2, "a")`가 방출된 것입니다.

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>


### zip………..>@#R%T^&*(*&^@#!@@!!!!!!!!!!!!!!!!!

같은 index 상에 있는 값들을 tuple로 조합하여 방출하게 됩니다. zip은 각각의 publisher 모두가 값을 방출하길 기다렸다가 tuple로 조합하게 됩니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/187c7d7d-a6fe-4b2e-a694-59f9d38836df/Untitled.png)

```swift
// 1
let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<String, Never>()
	
// 2
publisher1
	.zip(publisher2)
	.sink(receiveCompletion: { _ in print("Completed") },
		receiveValue: { print("P1: \($0), P2: \($1)") })
	.store(in: &subscriptions)
	
// 3
publisher1.send(1)
publisher1.send(2)
publisher2.send("a")
publisher2.send("b")
publisher1.send(3)
publisher2.send("c")
publisher2.send("d")
	
// 4
publisher1.send(completion: .finished)
publisher2.send(completion: .finished)
```

```
 P1: 1, P2: a
 P1: 2, P2: b
 P1: 3, P2: c
 Completed
```

• 주목해야할 것은 zip으로 결합된 publisher는 다른 publisher가 값을 방출할 때까지 기다린다는 점입니다.