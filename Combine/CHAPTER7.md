# 7. Sequence Operators

이제 우린 **Combine**의 **Operators**들을 거의 모두 알아! 하지만 아직 몇 개의 **Operators**들이 남아있어. 

이번엔 **Sequence** **Operators**라는 걸 배워볼 거야.

**Publisher가 그냥 Sequence다!** 라고 생각하면 **Sequence Operators**를 이해하기 쉬울 거야.

**Sequence Operators**는 **Publisher**의 값들을 가지고 동작해. **Array**나 **Set** 즉 **Sequence**와 같은 값들!

**Sequence Operators**는 다른 연산자와 달리 **Publisher의 개별 값**을 다루는 것이 아닌 **전체**를 주로 다뤄.

또 **Sequence Operators**는 **Swift 표준 라이브러리**의 **Operater**와 비슷한 것들이 많아! 한번 알아보자.

<br>
<br>
<br>

---

<br>
<br>
<br>

## Finding values

이 장의 첫번째 Section은 Publisher가 발산하는 값 중 **특정 값을 찾는 Operator**로 구성되어있어.

이 **Operator**들은 Swift 표준 라이브러리에 포함되어있는 **collection methods**와 비슷해. 그럼 알아보자!

### min

**min Operator**는 **publisher**가 방출한 값 중 **최솟값**을 찾을 수 있어. **Publisher**가 마지막으로 방출한 값이 

최솟값일 수도 있으므로 이 연산자는 **publisher가 완료 이벤트를 방출할 때까지 기다려야해.**

Publisher가 완료되면 min Operator는 최솟값을 내보내!

![스크린샷 2022-11-02 오전 11.22.37.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/38338a25-a18d-4027-9b5b-75b8062cfe42/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-02_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.22.37.png)

```swift
example(of: "min") {
  // 1: 숫자를 방출하는 publisher 생성
  let publisher = [1, -50, 246, 0].publisher

  // 2: min을 사용하여 publisher가 방출하는 값들의 최솟값 찾기
  publisher
    .print("publisher")
    .min()
    .sink(receiveValue: { print("Lowest value is \($0)") })
    .store(in: &subscriptions)
}
```

위의 결과가 보여주듯이, publisher는 모든 값들을 방출하고 완료 돼. 그리고 **min 연산자는 최솟값을 찾고**,

찾은 **최솟값을 downstream으로 전달**한 후 **sink 가 그것을 print** 해.

```
——— Example of: min ———
publisher: receive subscription: ([1, -50, 246, 0])
publisher: request unlimited
publisher: receive value: (1)
publisher: receive value: (-50)
publisher: receive value: (246)
publisher: receive value: (0)
publisher: receive finished
Lowest value is -50
```

그런데 어떻게 Combine은 여러 값 중 최솟값을 찾아낼 수 있는 걸까? 

그 이유는 바로 숫자 값들이 Comparable protocol을 준수하고 있기 때문이야.

그래서 publisher가 방출하는 값들이 Comparable 하다면 인자없은 min operator를 바로 사용할 수 있어.

그럼 만약 publisher가 방출하는 값들이 Comparable 하지 않다면 어떻게 해야할까?

그럴 땐 **min(by:) Operator**를 사용해서 자체적으로 클로저에 비교 조건을 생성할 수 있어.

```swift
example(of: "min non-Comparable") {
  // 1: 여러 값들을 Data로 형변환 하여 값을 방출하는 publisher 생성
  let publisher = ["12345",
                   "ab",
                   "hello world"]
    .map { Data($0.utf8) } // [Data]
    .publisher // Publisher<Data, Never>

  // 2: publisher가 방출하는 값이 Comparable하지 않기 때문에 min(by:) 사용
  publisher
    .print("publisher") // 바이트 수가 가장 적은 객체 찾기
    .min(by: { $0.count < $1.count })
    .sink(receiveValue: { data in
      // 3: 가장 바이트 수가 적은 개체를 다시 문자열로 변환하고 출력
      let string = String(data: data, encoding: .utf8)!
      print("Smallest data is \(string), \(data.count) bytes")
    })
    .store(in: &subscriptions)
}
```

이전 예와 마찬가지로 publisher가 모든 값을 방출한 후 완료된 후에 min(by:) Operator가 실행되어 

가장 작은 바이트 크기를 가진 값을 찾아 downstream으로 전달하고 sink가 출력해.

```
——— Example of: min non-Comparable ———
publisher: receive subscription: ([5 bytes, 2 bytes, 11 bytes])
publisher: request unlimited
publisher: receive value: (5 bytes)
publisher: receive value: (2 bytes)
publisher: receive value: (11 bytes)
publisher: receive finished
Smallest data is ab, 2 bytes
```

<br>
<br>
<br>

---

<br>
<br>
<br>

### max

publisher가 방출한 값 중 **최댓값**을 찾습니다.

![스크린샷 2022-11-02 오전 11.45.57.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/96f991d8-0837-4d49-88d5-c743d4132735/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-02_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.45.57.png)

```swift
example(of: "max") {
  // 1: 여러 값을 방출하는 publisher 생성
  let publisher = ["A", "F", "Z", "E"].publisher

  // 2: max 연산자를 사용하여 최댓값 찾기
  publisher
    .print("publisher")
    .max()
    .sink(receiveValue: { print("Highest value is \($0)") })
    .store(in: &subscriptions)
}
```

max는 min과 마찬가지로 **publisher가 값을 모두 방출할 때까지 기다려야합니다.**

max 또한 **non-Comparable values를 위한 max(by:) 연산자**를 가지고 있습니다.

```
——— Example of: max ———
publisher: receive subscription: (["A", "F", "Z", "E"])
publisher: request unlimited
publisher: receive value: (A)
publisher: receive value: (F)
publisher: receive value: (Z)
publisher: receive value: (E)
publisher: receive finished
Highest value is Z

```

<br>
<br>
<br>

---

<br>
<br>
<br>

### first

max와 min과 달리 이 섹션의 나머지 연산자는 **특정 위치에서 방출된 값을 찾는 것**을 다룹니다.

first Operator는 **lazy** 하므로 **Publisher가 끝날 때 까지 기다리지 않고** 첫번째 값을 받을 때 **구독을 취소**합니다.

![스크린샷 2022-11-02 오후 12.11.05.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/82ee21a7-d90b-4b54-897d-6dda716b509e/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_12.11.05.png)

```swift
example(of: "first") {
  // 1: publisher 생성
  let publisher = ["A", "B", "C"].publisher

  // 2: publisher의 첫번째 값을 받은 후 바로 구독 취소
  publisher
    .print("publisher")
    .first()
    .sink(receiveValue: { print("First value is \($0)") })
    .store(in: &subscriptions)
}
```

first 는 publisher의 **첫번째 값을 받자마자** **upstream publisher의 구독을 취소**합니다.

```
——— Example of: first ———
publisher: receive subscription: (["A", "B", "C"])
publisher: request unlimited
publisher: receive value: (A)
publisher: receive cancel
First value is A
```

좀 더 세부적인 제어를 원하는 경우 **first(where:) Operator**를 사용할 수 있습니다.

제공된 **조건과 일치하는 첫 번째 값**을 내보냅니다.

```swift
example(of: "first(where:)") {
  // 1: publisher 생성
  let publisher = ["J", "O", "H", "N"].publisher

  // 2 Hello World 에 해당 값이 포함되어있다면 값 받기
  publisher
    .print("publisher")
    .first(where: { "Hello World".contains($0) })
    .sink(receiveValue: { print("First match is \($0)") })
    .store(in: &subscriptions)
}
```

```
——— Example of: first(where:) ———
publisher: receive subscription: (["J", "O", "H", "N"])
publisher: request unlimited
publisher: receive value: (J)
publisher: receive value: (O)
publisher: receive value: (H)
publisher: receive cancel
First match is H

```

<br>
<br>
<br>

---

<br>
<br>
<br>

### last

max와 min과 같이.. first와 last 짝궁쓰. last는 publisher가 완료되면 마지막 값을 내보냅니다.

first가 where 인자를 가진 메서드를 가진 것과 같이 last 또한 last(where:) 메서드를 가지고 있습니다.

```swift
example(of: "last") {
  // 1: publisher 생성!
  let publisher = ["A", "B", "C"].publisher

  // 2: publisher가 완료되면 last는 publisehr가 방출한 마지막 값을 받아 내려보냅니다.
  publisher
    .print("publisher")
    .last()
    .sink(receiveValue: { print("Last value is \($0)") })
    .store(in: &subscriptions)
}
```

```
——— Example of: last ———
publisher: receive subscription: (["A", "B", "C"])
publisher: request unlimited
publisher: receive value: (A)
publisher: receive value: (B)
publisher: receive value: (C)
publisher: receive finished
Last value is C

```

<br>
<br>
<br>

---

<br>
<br>
<br>

### output(at:)

특정 index의 값을 받습니다.

```swift
example(of: "output(at:)") {
  // 1
  let publisher = ["A", "B", "C"].publisher

  // 2: 1번째 index의 값을 받기
  publisher
    .print("publisher")
    .output(at: 1)
    .sink(receiveValue: { print("Value at index 1 is \($0)") })
    .store(in: &subscriptions)
}
```

```
——— Example of: output(at:) ———
publisher: receive subscription: (["A", "B", "C"])
publisher: request unlimited
publisher: receive value: (A)
publisher: request max: (1) (synchronous)
publisher: receive value: (B)
Value at index 1 is B
publisher: receive cancel
```

<br>
<br>
<br>

---

<br>
<br>
<br>

### output(in:)

제공된 index 범위 내에 있는 값을 내보냅니다.

=컬렉션을 내보내는 것이 아닌 개별 값을 내보냅니다. 제공된 범위 내의 모든 값을 받는 즉시 구독을 취소합니다.

```swift
example(of: "output(in:)") {
  // 1
  let publisher = ["A", "B", "C", "D", "E"].publisher

  // 2: 1...3 인덱스 범위 내에 위치한 값들을 받습니다.
  publisher
    .output(in: 1...3)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print("Value in range: \($0)") })
    .store(in: &subscriptions)
}
```

```
——— Example of: output(in:) ———
Value in range: B
Value in range: C
Value in range: D
finished
```

<br>
<br>
<br>

---

<br>
<br>
<br>

## Querying the publisher

### count

Publisher가 완료 이벤트를 보내면 Publisher가 방출한 값의 개수를 전달합니다.

```swift
example(of: "count") {
  // 1
  let publisher = ["A", "B", "C"].publisher
    
  // 2
  publisher
    .print("publisher")
    .count()
    .sink(receiveValue: { print("I have \($0) items") })
    .store(in: &subscriptions)
}
```

```
——— Example of: count ———
publisher: receive subscription: (["A", "B", "C"])
publisher: request unlimited
publisher: receive value: (A)
publisher: receive value: (B)
publisher: receive value: (C)
publisher: receive finished
I have 3 items

```

<br>
<br>
<br>

---

<br>
<br>
<br>

### contains

Publisher가 방출한 값 중 특정 문자가 있으면 true를 보내고 구독을 취소합니다. 없으면 false를 보냅니다.

contains도 lazy 해서 특정 문자를 찾을 시에는 바로 구독을 취소합니다.

```swift
example(of: "contains") {
  // 1
  let publisher = ["A", "B", "C", "D", "E"].publisher
  let letter = "C"

  // 2
  publisher
    .print("publisher")
    .contains(letter)
    .sink(receiveValue: { contains in
      // 3
      print(contains ? "Publisher emitted \(letter)!"
                     : "Publisher never emitted \(letter)!")
    })
    .store(in: &subscriptions)
}
```

```
——— Example of: contains ———
publisher: receive subscription: (["A", "B", "C", "D", "E"])
publisher: request unlimited
publisher: receive value: (A)
publisher: receive value: (B)
publisher: receive value: (C)
publisher: receive cancel
Publisher emitted C!
```

### contains(where:)

```swift
example(of: "contains(where:)") {
  // 1
  struct Person {
    let id: Int
    let name: String
  }

  // 2
  let people = [
    (123, "Shai Mishali"),
    (777, "Marin Todorov"),
    (214, "Florent Pillet")
  ]
  .map(Person.init)
  .publisher

  // 3
  people
    .contains(where: { $0.id == 800 || $0.name == "Marin Todorov" })
    .sink(receiveValue: { contains in
      // 4
      print(contains ? "Criteria matches!"
                     : "Couldn't find a match for the criteria")
    })
    .store(in: &subscriptions)
}
```

```
——— Example of: contains(where:) ———
Criteria matches!

```

<br>
<br>
<br>

---

<br>
<br>
<br>

### allSatisfy

allSatisfy는 closure를 가지고있으며, 해당 조건과 Publisher가 방출하는 모든 값이 일치하는지 

여부를 판단하여 Bool 값을 내보냅니다. allSatisfy는 모든 값을 체크해야하므로 Publisher가

완료되기까지 기다려야합니다. 만약 조건에 일치하지않으면 false를 내보내고 구독을 취소합니다.

![스크린샷 2022-11-02 오후 4.10.12.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4203fae7-e445-4623-904e-9df341b7d06d/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-02_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.10.12.png)

```swift
example(of: "allSatisfy") {
  // 1
  let publisher = stride(from: 0, to: 5, by: 2).publisher
  
  // 2
  publisher
    .print("publisher")
    .allSatisfy { $0 % 2 == 0 }
    .sink(receiveValue: { allEven in
      print(allEven ? "All numbers are even"
                    : "Something is odd...")
    })
    .store(in: &subscriptions)
}
```

```
——— Example of: allSatisfy ———
publisher: receive subscription: (Sequence)
publisher: request unlimited
publisher: receive value: (0)
publisher: receive value: (2)
publisher: receive value: (4)
publisher: receive finished
All numbers are even

```

<br>
<br>
<br>

---

<br>
<br>
<br>

### reduce

Swift 표준 라이브러리의 reduce와 동일하게 동작합니다. closure에서 누적된 값과 현재 값을 받을 수 있습니다.

최종 누적 값을 내보냅니다.