## Types

<br>

> ##### Swift에서 타입은 `Named Types`, `Compound Types`으로 분류되어있다.

### Named Types
- ##### 정의할 때 특정 이름을 부여할 수 있는 타입이다.
##### 클래스, 구조체, 열거형, 프로토콜을 포함
##### Int, String, Double과 같은 기본 데이터 타입도 구조체로 구현이 되어있기 때문에 Named Types에 해당함
```Swift
// Youjin이라는 이름을 붙인 사용자 정의 클래스
class Youjin{

}
```

<br>

### Compound Types
- ##### 이름이 없는 타입으로, Swift 자체에서 정의됩니다.
- ##### `Compound Types`에는 `function type`, `tuple type`이 있다.
##### Compound Types는 named types과 다른 compound Types을 담을 수 있다.
```Swift
// tuple type
// Compound Type중 하나인 typle type에 named type인 Int 타입을 담았다. 즉 named type과 compound Type 둘 다 포함되어있는 경우이다.
(Int, (Int, Int))
```

<br>

### Named Types, Compound Types + ()
###### Named Types나 Compound Types에 괄호를 칠 수 있다.
###### 하지만 한 타입 주위에 괄호를 씌우는 건 아무 효과가 없다.
```Swift
// 아래 두 타입은 정확히 같은 상태다.
(Int) 
Int
```

<br>

#### 참고자료
- ###### https://zeddios.tistory.com/207
- ###### https://xho95.github.io/swift/language/grammar/types/self/2020/02/20/Types.html