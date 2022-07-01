## Sequence

<br>
<br>

### Sequence란?
- ##### 해당 요소에 대한 순차 반복 액세스를 제공하는 Protocol이다.
- ##### 문자 그대로 개개의 원소들을 순서대로 하나씩 순회할 수 있는 타입을 의미한다.
- ##### Swift 기본 타입에 대해서 모든 집합 타입이 Sequence를 따르고있다.

<br>
<br>

### Sequence Protocol을 채택하는 타입 사용하기
##### Sequence Protocol을 따르는 개체는 for-in loop를 사용할 수 있다.
```Swift
let oneTwoThree = 1...3
for number in oneTwoThree{
    print(number)
}

// 1
// 2
// 3
```


<br>
<br>

### Sequence Protocol을 채택하는 법
##### 먼저 내맘대로 custom type Youjin을 만들어보자.
##### 그대로 Youjin의 인스턴스를 for-in loop 에 넣어보면 오류가 난다.
```Swift
struct Youjin {}

let youjin = Youjin()

for value in youjin {} // 🚨 // error! for-in loop requires 'Youjin' to conform to 'Sequence'
```
<br>

##### for-in loop를 사용할 수 없는 이유는, Youjin이 Sequence를 conform하고 있지 않기 때문이다. Sequence를 conform 해보자.
```Swift
struct Youjin: Sequence {}
```
<br>

##### 이 Sequence Protocol을 채택하면 구현해줘야하는 메소드가 있는데 그것이 바로 makeIterator() 메소드다.
##### 그런데 이 메소드를 만드려면 IteratorProtol을 conform하는 타입을 만들어야 한다.
```Swift
struct YoujinIterator: IteratorProtocol {
    typealias Element = Int
    var current = 1
    
    mutating func next() -> Element? {
        defer { current += 1 }
        return current
    }
}

struct Youjin: Sequence {
    
    func makeIterator() -> some IteratorProtocol {
        return YoujinIterator()
    }
}
```
<br>

##### 하지만, 타입이 Sequence, IteratorProtocol 모두 conform 한다면 타입 자체가 Iterator로 행동할 수 있게 되기 때문에 makeIterator()를 구현해주지 않아도 되어 아래처럼 작성할 수 있다.
```Swift
struct Youjin: Sequence, IteratorProtocol {
    
    typealias Element = Int
    var current = 1
    
    mutating func next() -> Int? {
        if current > 10 { return nil }
        // Iterator에서 nil을 반환하는 것은 완료를 의미한다.
        defer { current += 1 }
        return current
    }
}
```
<br>

##### 그럼 아래와 같이 Sequence 채택이 완료되어 for-in loop를 문제없이 사용하는 모습을 볼 수 있다.
```Swift
let youjin = Youjin()
for value in youjin { ✅
    print(value)
}
```




<br>
<br>

### 참고자료
- ##### https://zeddios.tistory.com/1340