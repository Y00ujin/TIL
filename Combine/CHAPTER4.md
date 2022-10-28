# 4. Filtering Operators

### Filter

- filter는 Bool을 반환하는 closure를 통해 조건과 일치한 값만 전달합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a0442d33-00d2-4631-85d1-9bcd79918d71/Untitled.png)

### Filter Example

```swift
example(of: "filter") {
  // 1 : 1 부터 10 까지 숫자를 방출하고 나서 완료되는 publisher를 생성합니다.
  let numbers = (1...10).publisher
  
  // 2 : filter operator를 이용해서 3의 배수에 해당하는 숫자만 print 되도록 합니다.
  numbers
    .filter { $0.isMultiple(of: 3) }
    .sink(receiveValue: { n in
      print("\(n) is a multiple of 3!")
    })
    .store(in: &subscriptions)
}
```

```swift
3 is a multiple of 3!
6 is a multiple of 3!
9 is a multiple of 3!
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### removeDuplicates()

- 여러 번 발생하는 액션을 무시할 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b842f935-bafb-4fbf-8558-532bd8de3ab2/Untitled.png)

```swift
example(of: "removeDuplicates") {
  // 1: Array<String> 형태의 문장을 단어 단위로 분리하여 publisher로 만들었습니다.
  let words = "hey hey there! want to listen to mister mister ?"
                  .components(separatedBy: " ")
                  .publisher
  // 2: words publisher에 removeDuplicates() 를 적용합니다.
  words
    .removeDuplicates()
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

반복되는 단어는 제거된 채로 출력됩니다.

```swift
——— Example of: removeDuplicates ———
hey
there!
want
to
listen
to
mister
?
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### CompactMap

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e76fa7dd-6f1f-432f-985d-54a55f0f551a/Untitled.png)

```swift
example(of: "compactMap") {
  // 1 : 유한한 문자 배열을 방출하는 publisher를 생성합니다.
  let strings = ["a", "1.24", "3",
                 "def", "45", "0.23"].publisher
  
  // 2 : compactMap 을 이용하여 각 문자열을 Float 타입으로 변경합니다. 
// 만약 문자열을 Float 로 변경할 수 없다면 nil 을 반환하겠죠.
  strings
    .compactMap { Float($0) }
    .sink(receiveValue: {
      // 3 : Float 으로 변환이 된 아이들만 print 합니다.
      print($0)
    })
    .store(in: &subscriptions)
}
```

```swift
——— Example of: compactMap ———
1.24
3.0
45.0
0.23
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### ignoreOutput

• publisher가 어떤 값을 내는지는 중요하지 않고 값 방출을 끝냈는지만 알고 싶을 때가 있습니다. 이럴 때는 `ignoreOutput` 을 사용할 수 있어요.

다이어그램에서 확인할 수 있듯이 어떤 값이 얼마나 나오든 신경쓰지 않습니다. 오직 완료 이벤트가 방출되었을 때만 알려주죠. 다음 코드를 살펴봅시다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/81354858-04de-4ac4-a646-968174879ac3/Untitled.png)

```swift
example(of: "ignoreOutput") {
  // 1 : 1 부터 10000 까지 10,000 개의 값을 방출하는 publisher를 생성합니다.
  let numbers = (1...10_000).publisher
  
  // 2 : ignoreOutput operator를 추가하여 방출하는 모든 값은 무시하고 완료 이벤트만 받도록 합니다.
  numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```
——— Example of: ignoreOutput ———
Completed with: finished
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### first(where:)

이 operator는 lazy 합니다. 즉, 조건에 일치하는 값을 찾는데 필요한 만큼의 값만 취합니다.

일치하는 것을 찾으면 subscription을 취소하고 완료시킵니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b107e86e-fa50-40be-b4fe-ed3b09bca8c0/Untitled.png)

```swift
example(of: "first(where:)") {
  // 1: 1 부터 9 까지 숫자를 방출하는 새로운 publisher를 생성합니다.
  let numbers = (1...9).publisher
  
  // 2: first(where:) 를 이용하여 짝수 에 해당하는 첫 번째 방출 값을 찾습니다.
  numbers
    .first(where: { $0 % 2 == 0 })
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```swift
——— Example of: first(where:) ———
2
Completed with: finished
```

앞서 설명한 것처럼 값을 찾으면 정말 구독이 취소되는지 확인해보겠습니다.

아래 코드를 추가해봅시다.

```swift
print("numbers")
```

보시다시피 `first(where:)` 가 일치하는 값을 찾으면 subscription을 통해 취소를 전송하여 더 이상 값을 방출하지 않습니다. 편리하네요!****

```
——— Example of: first(where:) ———
numbers: receive subscription: (1...9)
numbers: request unlimited
numbers: receive value: (1)
numbers: receive value: (2)
numbers: receive cancel
2
Completed with: finished
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### last(where:)

조건에 해당하는 값을 찾기 위해서 모든 값이 방출될 때까지 기다립니다.

왜냐면 조건에 부합하는 마지막 값을 찾는 것이기 때문에 맨 마지막 값이 조건에 부합할 수도 있기 때문

이 때문에 upstream publisher는 반드시 특정시점에 종료되는 아이여야 합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e1edc422-0229-4cc3-aa30-ea2f7fed716b/Untitled.png)

```swift
example(of: "last(where:)") {
  // 1 : 1 부터 9 까지 숫자를 방출하는 새로운 publisher를 생성합니다.
  let numbers = (1...9).publisher
  
  // 2 : last(where:) 를 이용하여 마지막 짝수 값을 확인합니다.
  numbers
    .last(where: { $0 % 2 == 0 })
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```
——— Example of: last(where:) ———
8
Completed with: finished
```

publisher가 반드시 완료되어야 하기 때문에 아래와 같이 완료 이벤트를 보내줘야 last가 작동합니다.

```swift
example(of: "last(where:)") {
  let numbers = PassthroughSubject<Int, Never>()
  
  numbers
    .last(where: { $0 % 2 == 0 })
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
  
  numbers.send(1)
  numbers.send(2)
  numbers.send(3)
  numbers.send(4)
  numbers.send(5)

  numbers.send(completion: .finished) // 필수~
}
```

```
——— Example of: last(where:) ———
4
Completed with: finished
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### dropFirst

• `dropFirst` operator는 기본 값은 `1` 이며 1일 경우 생략가능한 `count` parameter를 가지고 있습니다. `count` 에 해당하는 개수의 값들은 무시하고 그 다음 값부터 방출합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0013afb9-893f-4cdf-8e28-a5a77ba483c9/Untitled.png)

```swift
example(of: "dropFirst") {
  // 1 : 1 부터 10 까지의 숫자를 방출하는 publisher를 생성합니다.
  let numbers = (1...10).publisher
  
  // 2 : dropFirst(8) 을 이용하여 처음 8개의 값은 무시하고 그 다음 값인 9 와 10 만 방출되게 합니다.
  numbers
    .dropFirst(8)
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```
——— Example of: dropFirst ———
9
10
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### drop(while:)

closure 내 구현한 조건이 충족되는 시점부터 값이 통과되기 시작합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/54311793-ca43-4520-89df-38cb99827fc1/Untitled.png)

```swift
example(of: "drop(while:)") {
  // 1: 1 부터 10 까지의 숫자를 방출하는 publisher를 생성합니다.
  let numbers = (1...10).publisher
  
  // 2: drop(while:) 을 사용하여 첫 번째 5의 배수가 나올 때까지 기다리도록 합니다.
// 조건에 부합하는 값이 나오는대로 값은 흐르기 시작하고 더 이상 값을 무시하지 않습니다.
  numbers
    .drop(while: { $0 % 5 != 0 })
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```
——— Example of: drop(while:) ———
5
6
7
8
9
10
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### drop(untilOutputFrom:)

filtering 계열 중 가장 정교한 operator입니다. 

한 번 상황을 상상해볼까요? 사용자가 버튼을 여러 번 탭하고 있어요. 하지만 여러분들은 `isReady`
 라는 publisher가 어떤 결과를 방출하기 전까진 이 모든 액션을 무시하고 싶습니다. 이런 상황에 이 녀석은 아주 유용합니다.

`drop(untilOutputFrom:)` 은 두 번째 publisher가 값 방출을 시작하기 전까진 방출되는 값을 무시합니다.

가장 위에는 `isReady` 스트림이 있구요, 두 번째가 사용자의 탭 이벤트 스트림인데 이벤트들을 `drop(untilOutputFrom:)` 를 통해 `isReady` publishe 를 argument로 뒀습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d42a23c7-4774-42de-9965-56bdd2faf0e7/Untitled.png)

```swift
example(of: "drop(untilOutputFrom:)") {
  // : 값을 보낼 2개의 PassthroughSubject 를 생성합니다. 
// 하나는 isReady 로 또 다른 subject로 사용자의 탭 이벤트가 발생할 동안 기다릴 녀석이죠.
  let isReady = PassthroughSubject<Void, Never>()
  let taps = PassthroughSubject<Int, Never>()
  
  // 2: drop(untilOutputFrom:) 을 이용하여 
// isReady 가 최소한 한 개 이상의 값을 방출하기 전까진 어떠한 탭 이벤트도 무시하도록 합니다.
  taps
    .drop(untilOutputFrom: isReady)
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
  
  // 3: 위 다이어그램에서 표현한 것처럼 다섯 개의 "탭" 이벤트를 보낼건데요, 
// 3개의 탭을 보낸 후에는 isReady 에게도 값을 보내주세요.
  (1...5).forEach { n in
    taps.send(n)
    
    if n == 3 {
      isReady.send()
    }
  }
}
```

```
——— Example of: drop(untilOutputFrom:) ———
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

### prefix(_:)

조건이 충족될 때까지 값을 수신한 후 publisher가 완료되도록 합니다.

예를 들어 양을 알 수 없는 값을 방출할 때 하나의 값만 원하고 나머지는 신경쓰고 싶지 않은 상황 같은 것이죠.

선언한 갯수만큼의 값을 수신한 뒤 완료됩니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/feca3012-6aa8-4be9-be08-5bd11b72aa8e/Untitled.png)

```swift
example(of: "prefix") {
  // 1: 1 부터 10 까지 숫자를 방출하는 publisher를 생성합니다.
  let numbers = (1...10).publisher
  
  // 2: prefix(2) 를 사용하여 최초 2개의 값만 받도록 합니다. 
// 해당하는 갯수의 값이 방출되는대로 publisher는 완료됩니다.
  numbers
    .prefix(2)
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```
——— Example of: prefix ———
1
2
Completed with: finished
```

first(where:) 처럼 이 operator도 lazy합니다. 즉 필요한만큼의 값만 받고 종료됩니다.

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### prefix(while:)

`prefix(while:)` 은 upstream publisher가 closure 내부 조건을 `true` 로 통과하는 값을 방출할 동안만 값을 받습니다. `false` 에 해당하는 값이 나오자마자 publisher 는 종료됩니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f6fc2c44-d447-4438-aa0a-4c5ea5affe26/Untitled.png)

```swift
example(of: "prefix(while:)") {
  // 1: 1 부터 10 까지 값을 방출하는 publisher 를 생성합니다.
  let numbers = (1...10).publisher
  
  // 2: prefix(while:) 을 통해 3 보다 작은 값이 나오는 동안은 값을 받지만 
// 그 이상의 값이 나오는 즉시 publisher는 완료됩니다.
  numbers
    .prefix(while: { $0 < 3 })
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
}
```

```
——— Example of: prefix(while:) ———
1
2
Completed with: finished
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

### prefix(untilOutputFrom:)

두 번째 publisher가 값 방출하기 전까진 값을 무시했던 `drop(untilOutputFrom)` 의 반대 개념으로 `prefix(untilOutputFrom)` 은 두 번째 publisher가 값을 방출할 때까지 값을 *수신*합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/53c97acb-686f-4b7d-bc44-1ee31437cfa5/Untitled.png)

```swift
example(of: "prefix(untilOutputFrom:)") {
  // 1: 두 개의 PassthroughSubject 를 생성합니다.
  let isReady = PassthroughSubject<Void, Never>()
  let taps = PassthroughSubject<Int, Never>()
  
  // 2: prefix(untilOutputFrom: isReady) 를 통해
// isReady 가 최소 하나의 값을 방출할 동안 탭 이벤트를 받도록 합니다.
  taps
    .prefix(untilOutputFrom: isReady)
    .sink(receiveCompletion: { print("Completed with: \($0)") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
  
  // 3: 위 다이어그램과 동일하게 다섯 개의 "탭" 이벤트를 보낼건데요, 
// 두 개를 보낸다음엔 isReady 에도 값을 보내주세요.
  (1...5).forEach { n in
    taps.send(n)
    
    if n == 2 {
      isReady.send()
    }
  }
}
```

```
——— Example of: prefix(untilOutputFrom:) ———
1
2
Completed with: finished
```

<br>
<Br>
<Br>

---

<br>
<Br>
<Br>

## **Summary**

- filtering operator를 사용하면 upstream publisher가 방출한 값을 downstream, 다른 operator 들에게 보낼 수 있습니다.
- 값 자체에 신경 쓰지 않고 완료 이벤트만을 원할 경우엔 `ignoreOutput` 을 쓸 수 있습니다.
- `first(where:)` `last(where:)` 를 사용하여 조건과 일치하는 첫 번째 또는 마지막 값을 찾을 수 있습니다.
- `first` 계열의 operator는 *lazy* 합니다. 필요한만큼의 값만 취한 다음 완료해버립니다. `last` 스타일의 operator 는 욕심쟁이죠. 조건을 충족시키는 마지막 값을 결정하기 위해 방출하는 값의 전체 범위를 모두 알아야 합니다.
- `drop` 계열의 operator를 사용하여 downstream 에 값을 보내기 전에 upstream publisher가 방출한 값들을 무시할 수 있습니다.
- 마찬가지로 `prefix` 계열 operator를 사용하여 완료 전에 upstream publisher가 방출할 수 있는 값의 개수를 제어할 수 있습니다.