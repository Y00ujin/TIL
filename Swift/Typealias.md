## Typealias

<br>

### Typealias란?
- ##### 기존에 선언되어있는 유형에 새로운 유형의 별칭을 사용함으로써 코드를 더 읽기 쉽도록, 이해하기 쉽도록 명확하게 만드는 문법이다.

<br>

### Typealias 사용 예시
###### String 유형을 Youjin이라는 별칭으로 사용한다고 선언한다.
###### typealias로 선언한 후에는 선언한 이름으로 프로그램의 모든 곳에서 사용할 수 있다.
###### typealias는 새로운 타입을 만드는 것이 아니라 단순이 별명이 기존 유형을 참조하도록 허용한 것이다.
###### typealias의 주요 목적은 코드를 이해하기 쉽도록 하고, 명확하게 만드는 것이다.

<br>

- #### 1. Built-in type `(String, Int, Float ..)`
###### Stirng, Int, Float등 모든 내장 데이터 유형에 대해 typealias로 사용할 수 있다.
###### 아래의 선언을 통해 YoujinString을 String대신 모든 곳에서 사용할 수 있다.
```Swift
typealias (붙여줄 별명) = (존재하는 타입)

typealias YoujinString = String

// 같은 String 타입이다.
let name: YoujinString = "youjin"
let school: String = "광주소프트웨어마이스터고등학교"
```

<br>


- #### 2. user defiend types `(Class, Struct, Enum ..)`
###### 프로그래밍을 하면서 자신만의 데이터 유형을 만드는 많은 경우가 있다. 이때 유저가 정의한 class, struct, enum에 typealias를 사용할 수 있다.
###### Student Class를 Typealias를 통해 Students라는 Student 클리스 배열로 선언한다.
```Swift
class Student{

}

typealias Students = [Student]

// 이때 Students라는 타입은 Array<Student>, [Student] 타입과 같은 타입이 됩니다.
var students: Students = []
```

<br>

- #### 3. complex types
 `(Closure)`
###### Closure를 입력 매개 변수로 사용하는 함수를 typealias를 사용하여 깔끔하게 만들 수 있습니다.
```Swift
// 기존의 Closure를 입력 매개 변수로 사용하는 함수
func upload(success: ((Int) -> Int)?, failure: ((Error) -> Void)?, progress: ((Double) -> Void)?) {
}
// (Int) -> (String) 클로저의 input과 return값을 typealias로 별명을 만들어 준다.
typealias Success = (Int) -> Int
typealias Failure = (Error) -> Void
typealias Progress = (Double) -> Void

func upload(success: Success?, failure: Failure?, progress: Progress?) {
}
```

<br>

- #### 4. generic parameters
###### 제네릭 파마리터를 사용하여 기존 제네릭 타입에 이름을 부여할 수 있다.
###### 기존에 존재하는 제네릭 파라미터의 타입 전체나 몇 개의 타입을 공급할 수 있다.
```Swift
typealias StringDictionary<Value> = Dictionary<String, Value>
typealias StirngDictionary2<Value> = [String : Value]

// dictionary1, dictionary2는 같은 타입이다
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]

// generic parameters로 서언할 때에는 정확한 타입을 넣어야 한다.
typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>
// typealias 와 정확한 타입은 서로 바꾸어 사용할 수 있으며 typealias는 추가적인 일반적인 제약을 도입할 수 없다.

// 또한 typealias는 정확한 타입의 generic parameters는 생략할 수 있다.
typelalias Diccionario = Dictionary
// Diccionario typealias는 Dictionary와 동일한 일반 매개벼수와 제약 조건을 갖는다.
```
<br>

- #### 5. 프로토콜 선언 시
###### 프로토콜 선언에서 typealias는 자주 사용되는 형식에 더 짧고 편리한 이름을 제공할 수 있다.
```Swift
protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    typealias Element = Iterator.Element
}

func sum<T: Sequence>(_ sequence: T) -> Int where T.Element == Int{
    // ...
}

// typealias가 없다면 T.Iterator.Element로 사용해야하지만 typealias로 T.Element로 짧게 사용할 수 있다.
```
###### 프로토콜의 결합
```Swift
struct DataModel: Codable{
    var name: String
    var description: String
}

// Codable역시 Decodable과 Encodable의 결합체이다.
public typealias Codable = Decodable & Encodable

public typealias CollectionviewDelegate = UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout

extension ViewController: CollectionViewDelegate{
    // 메서드 ...
}
```

<br>

#### 참고자료
- ###### https://ginjo.tistory.com/20
- ###### https://brody.tistory.com/103
- ###### https://taekki-dev.tistory.com/33