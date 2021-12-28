## Tuple

<br>

### Tuple이란?
- ##### 여러 타입들의 묶음
- ##### 유한 개의 사물의 순서있는 열거
- ##### 튜플의 구성 요소들은 서로 같은 타입일 필요가 없다.
- ##### tuple은 Swift의 Collection Type이 아니라 compound type으로, named type뿐만아니라, compound type도 담을 수 있다.
- ##### 아주 간단한 구조체라고 생각하면 편함

<br>

### Tuple 생성하기
###### 데이터 값들을 ()에 묶어서 넣어 주면 된다.
- #### 1. Tuple에 Named types 넣기
```Swift
var tuple = (1, "Hello, world!", true)
```
- #### 2. Tuple에 Compound types의 tuple type넣기
```Swift
var tuple = (1, "Hello, world!", true)
var anotherTuple = (1, (tuple))
```
- #### 3. Tuple에 Compound types의 function type넣기
```Swift
func a() -> Int { return 1 }

func b() -> String { return "Zedd" }

func c() -> Bool { return false }

var functionTuple = (a(), b(), c())
```

<br>

### Tuple 값 사용하기
- #### 1. Tuple의 Named types의 값에 접근하기
###### 튜플의 이름을 작성하고 점(.)을 찍은 후 접근하고 싶은 index를 작성한다.
```Swift
var tuple = (1, "Hello, world!", true)
tuple.0 // 1
tuple.1 // Hello, world!
tuple.2 // true
```
- #### 2. Tuple의 Compound types의 tuple types에 접근하기
###### 위와 동일하게 점(.)으로 접근하고 튜플을 만나면 또 점(.)을 통해 튜플안의 값에 접근한다.
```Swift
var tuple = (1, "Hello, world!", true)
var anotherTuple = (5, (tuple))
anotherTuple.0 // 5
anotherTuple.1.0 // 1
anotherTuple.1.1 // Hello, world!
anotherTuple.1.2 // true
```

- #### 3. Tuple의 Compound types의 function types에 접근하기
###### 함수도 위와 동일한 방법으로 접근한다
```Swift
func a() -> Int { return 1 }
func b() -> String { return "Youjin" }
func c() -> Bool { return false }

var functionTuple = (a(), b(), c())

functionTuple.0 // 1
functionTuple.1 // Youjin
functionTuple.2 // false
```
<br>

### Tuple의 원소에 이름 주기
```Swift
// 방법 1
var namedTuple = (name: "Youjin", age: 18, likes : ["study","iOS"])

// 방법 2
var namedTuple2: (name: String, age: Int, likes: [String]) = ("Youjin", 18, ["study","iOS"])

// 두 방법 모두 아래와 같이 이름으로 원소에 접근할 수 있다.
namedTuple.name // Youjin
namedTuple.age // 18
namedTuple.likes // ["study","iOS"]
```

<br>

### Tuple 반복문 돌리기
###### Tuple은 Sequence라는 프로토콜을 준수하고있지 않기때문에 Tuple 그 자체를 바로 루프를 돌리지는 못한다.
###### Sequence 프로토콜을 따르는 배열에 Tuple을 넣어서 반복문을 돌려보자
```Swift
var tupleInArray = [(1, "youjin", true),(2, "minji", false)]

for index in tupleInArray{
    print(index.0)//1 2
    print(index.1)//"youjin" "minji"
    print(index.2)//true false
}
```

- ##### 이때 넣어주는 tuple의 타입과 순서가 모두 같아야한다.
###### 처음에 Int를 넣어주면 다음 인덱스에 넣는 튜플도 처음에 Int가 들어가야하고 개수도 다 맞춰줘야함
```Swift
var tuple = (1, "Hello, world!", true)
var anotherTuple = (1,(tuple))

var tupleArr = [tuple,tuple]//OK
var errorTupleArr = [tuple,anotherTuple]//error
```

<br>

### Tuple Decomposition문법 써보기
```Swift
var tuple = (1, "youjin", true)

// 차례대로 상수 name, age, height 3개를 생성하고 튜플 멤버 값을 순서대로 저장한다.
var (a,b,c) = tuple
print(a) // 1
print(b) // "youjin"
print(c) // true

// wildcard pattern(_)을 사용하여 무시하고싶은 요소를 생략하고 필요한 요소만 받아올 수 있다.
var (_,b,_) = tuple
```

<br>

### Tuple을 활용하여 여러 타입을 한번에 리턴하기
###### 함수의 리턴 값으로 튜플을 리턴할 수 있다.
```Swift
func someFunction() -> (Int, String, Bool) {
    return (1, "youjin", true)
}

var someTuple = someFunction()
someTuple.0//1
someTuple.1//"youjin"
someTuple.2//true

var (a,b,c) = someFunction()
print(a)//1
print(b)//"youjin"
print(c)//true
```

<br>

### Tuple과 Tupealias 같이 쓰기
```Swift
typealias People = (name: String, age: Int, likes: [String])

var youjin: People = ("youjin", 18, ["iOS", "apple"])
var minzi: People = ("minji", 18, ["giriboy","songgang"])
```

<br>

### Tuple과 Switch문
###### 다음과 같이 case 조건을 Tuple 타입으로 설정할 수 있다.
```Swift
let num = (1, 2)

switch num{
    case(1,2):
        print("1,2")
    default:
        break
}
```

<br>

#### 참고자료
- ###### https://zeddios.tistory.com/238
- ###### https://joycestudios.tistory.com/79
- ###### https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-3/tuples.html
- ###### https://noahlogs.tistory.com/13