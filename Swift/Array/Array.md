## Array

<br>

> ##### Swift에서는 값을 저장하기 위한 세 가지 Primary(기본) Collection type을 제공한다. 이번 장에서는 Primary Collection type(Dictionary, Array, Set) 중 Array를 알아보겠다!

<br>
<br>

### Array란?
- ###### 여러 데이터를 한번에 묶어서 처리할 때 편리한 데이터 유형
- ###### 순서가 있는 컬렉션

<br>
<br>

### Array 생성하기
- ##### 1. 배열 생성 정식 문법
###### (let or var) 배열 이름: Array<배열의 타입>
```Swift
let arr1: Array<Int>        // 상수형 정수 배열
var arr1: Array<String>     // 변수형 문자열 배열
```
<br>

- ##### 2. 배열 생성 단축 문법
###### 단축 문법은 정식 문법보다 훨씬 간단하며 대괄호 사이에 배열의 타입을 명시해주기만 하면 된다.
```Swift
let arr1: [Int]             // 상수형 정수 배열
var arr2: [String]          // 변수형 문자열 배열
```
<br>

- ##### 3. 타입 유추 (형식 추론)
###### 아래와 같이 선언과 동시에 값을 할당해주면 Xcode의 컴파일러(Apple LLVM/Clang)가 배열에 들어가는 값이 무엇인지 확인하고 타입을 유추하여 배열의 타입을 결정해줍니다.
```Swift
let arr1 = [1,2,3,4,5]      // 상수형 정수 배열
var arr2 = ["one","two"]    // 변수형 문자열 배열
```
###### 선언과 동시에 값을 할당한다면 타입을 생략해도 된다. 하지만 빈 배열을 만들 경우에는 반드시 타입을 명시해야한다.
```Swift
let emptyArr = [] // error!
```
<br>

- ##### 4. 빈 배열 생성
###### 빈 배열은 컴파일러가 타입을 유추할 수 없으므로 타입을 꼭 명시해야합니다.
```Swift
let emptyArray: [Int] = []

// 정식 문법 사용
let emptyArray2 = Array<Int>()

// 단축 문법 사용
let emptyArray3 = [Int]()
```
<br>

- ##### 5. Array 생성과 값 할당
###### 대입 연산자(=)의 뒤에는 대괄호 사이의 배열의 타입과 일치하는 값을 넣어줘야 합니다.
```Swift
// 정식 문법
let strArray1: Array<String> = ["정식", "문법", "돈까스 정식"]

// 단축 문법
let strArray2: [String] = ["단축", "문법", "단추", "구녕.."]

// 형식 추론
let strArray3 = ["형식", "추론"]

// 시퀀스
let nums = Array(1...3) /// [1, 2, 3]

// 여러 자료형(타입)
let anyArr: [Any] = [1, 2, "three", "four"]
```

<br>

- ##### 6. 크기가 정해진 Array 생성
```Swift
// (repeating: 배열의 타입과 일치하는 반복할 값(1개), count: 값을 반복할 횟수)

let zeroArray1 = [Int](repeating: 0, count: 10) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
let zeroArray2 = Array(repeating: 0, count: 10) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```
###### 여기서 repeating에 들어가는 값이 클래스의 인스턴스일 경우, 반복되는 모든 요소가 동일한 인스턴스를 참조하게 되므로 주의해야한다.
###### 요소 하나의 속성만 변경해도 모든 값이 변경된다.
```Swift
class Person: CustomStringConvertible {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var description: String {
        return "Person(\(self.name))"
    }
}

var persons = Array(repeating: Person(name: "홍길동"), count: 3)
print(persons)  // [Person("홍길동"), Person("홍길동"), Person("홍길동")]

persons[0].name = "이순신"
print(persons)  // [Person("이순신"), Person("이순신"), Person("이순신")]
```

<br>

- ##### 7. 연속된 숫자 Array 생성
```Swift
var intArray = Array<Int>(1...4) // [1,2,3,4]
```

<br>
<br>

### Array 검사하기
- ##### 1. Array 요소 개수 검사하기
```Swift
let nums = [1, 2, 3]
let emptyArray: [Int] = []
 
// .count == 배열에 들어있는 값의 개수 검사
nums.count // 3
emptyArray.count // 0
```
<br>

- ##### 2. Array 요소 유무 검사하기
```Swift
let nums = [1, 2, 3]
let emptyArray: [Int] = []
 
// .isEmpty == 배열에 값이 있는지 없는지 판단
nums.isEmpty // false
emptyArray.isEmpty // true
```
<br>
<br>

### Array 요소에 접근하기
- ##### 1. 서브 스크립트로 Array 요소에 접근하기
```Swift
let fruits: Array<String> = ["Apple", "Banana", "Melon"]

fruits[0] // "Apple"
fruits[1] // "Banana" 
fruits[2] // "Melon"
//fruits[3] // error: 인덱스는 0부터 시작하기에 3은 없음 (인덱스를 벗어남)

// 범위 연산자를 사용하여 특정 범위를 추출
fruits[0...1] // ["Apple", "Banana"]

// 첫 번째 요소 접근
fruits[fruits.startIndex] // "Apple"

// 마지막 요소 접근
// endIndex는 마지막 인덱스의 다음 인덱스임
// fruits[fruits.endIndex] // error: 인덱스를 벗어남

// index(before:) 메서드를 사용하여 'endIndex'의 이전 인덱스를 가리키는 것
fruits[fruits.index(before:fruits.endIndex)] // "Melon"

```
- ##### 2. 속성으로 Array 요소에 접근하기
```Swift
fruits.first // "Apple"
fruits.last // "Melon"

// 배열이 비어있다면 nil을 반환
emptyArray.first // nil
emptyArray.last // nil
```

<br>
<br>

### Array에 값 추가
- ##### 1. append(_:)를 사용하여 맨 뒤에 값 추가
```Swift
var numbers = [1,2,3,4]
numbers.append(5)
print(numbers) // [1,2,3,4,5]
```

<br>

- ##### 2. append(conentsOf:)를 사용하여 맨 뒤에 여러 값 추가
```Swift
var numbers = [1,2,3,4]

var moreNumbers = [5,6,7]
numbers.append(contentsOf: moreNumbers)
print(numbers) // [1,2,3,4,5,6,7]
```

<br>

- ##### 3. +=을 사용하여 맨 뒤에 여러 값 추가
```Swift
var numbers = [1,2,3,4]

numbers += [5, 6, 7, 8, 9, 10]
print(numbers) // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

<br>

- ##### 4. insert(_:at:)을 사용하여 특정 위치에 값 추가
###### 앞의 인자에는 넣고 싶은 값을 입력하고, at에는 인덱스를 입력한다.
###### 이 메소드를 사용하면 값을 삽입한 위치 뒤의 요소들은 한 칸씩 뒤로 밀리게 되고, 배열의 크기는 1 증가한다.
```Swift
var numbers = [1,2,3,4,5]
numbers.insert(0, at: 0)
print(numbers) // [0,1,2,3,4,5]
```

<br>

- ##### 5. insert(contentsOf:at:)을 사용하여 특정 위치에 여러 요소 추가
```Swift
var numbers = [1,2,3,4,5]
numbers.insert(contentsOf: [1,2,3], at: 3)
print(numbers) // [1,2,3,1,2,3,4,5]
```

<br>
<br>

### Array 요소 제거
- ##### 1. remove(at:)을 사용하여 특정 인덱스의 요소 제거하기
```Swift
var numbers = [1,2,3]
numbers.remove(at: 1) // index 1에 있는 2를 제거한다.
print(numbers) // [1,3]
```

<br>

- ##### 2. removeFirst()을 사용하여 특정 인덱스의 요소 제거하기
###### removeFirst()를 인자없이 사용하면 배열의 0번째 인덱스 요소를 제거할 수 있다.
```Swift
var numbers = [1,2,3]
numbers.removeFirst() // numbers의 0번째 인덱스의 요소 제거
print(numbers) // [2, 3]
```
###### removeFirst()에 인자값으로 인덱스 값을 넣을 수 있다. 배열의 맨 앞에서부터 몇 칸 띄운 index의 값을 지우겠다는 의미이다.
```Swift
var numbers = [1,2,3]
numbers.removeFirst(2) // numbers.remove(at: 2)와 같은 표현 => 3 삭제
```

<br>

- ##### 3. removeLast()를 사용하여 특정 인덱스의 요소 제거하기
###### removeLast()를 인자없이 사용하면 배열의 마지막 인덱스 요소를 제거할 수 있다.
```Swift
var numbers = [1,2,3]
numbers.removeFirst() // numbers의 마지막 인덱스 요소 제거
print(numbers) // [1,2]
```
###### removeLast()에 인자값으로 인덱스 값을 넣을 수 있다. 배열의 맨 뒤에서부터 몇 칸 띄운 index의 값을 지우겠다는 의미이다.
```Swift
var numbers = [1,2,3]
numbers.removeLast(1)
print(numbers) // [1,3]
```

<br>

- ##### 4. popLast()를 사용하여 마지막 요소 제거하기
###### 마지막 값을 옵셔널타입으로 반환하면서 제거한다. 빈 배열일 경우 nil을 반환하고 에러가 발생하지 않는다.
```Swift
var numbers = [1,2,3]
print(numbers.popLast()) // Optional(3)
print(numbers) // [1,2]
```

<br>

- ##### 5. removeAll()을 사용하여 모든 요소 제거하기
```Swift
var numbers = [1,2,3]
numbers.removeAll()
print(numbers) // []
```

<br>

- ###### 6. removeSubrange(_:)을 사용하여 특정 구간의 요소 제거하기
```Swift
var numbers = [1,2,3,4,5,6]
numbers.removeSubrange(1..<4) // 인덱스 1,2,3 범위의 값을 제거한다.
print(numbers) // [1,5,6]
```

<br>

- ##### `dropFirst`, `dropLast`를 사용하여 특정 요소 제거하기
###### removeFirst와 다른 점으로는 기존 배열은 그대로 두고 값을 제거한 새로운 배열을 반환한다는 점이다.
- ###### dropFirst(_:)
```Swift
let numbers = [1, 2, 3, 4, 5]
print(numbers.dropFirst(2))	// [3, 4, 5] : 앞에서부터 2개 제거한 새로운 배열 반환
print(numbers.dropFirst(10))	// [] : 앞에서부터 10개 제거한 새로운 배열 반환
print(numbers) // [1, 2, 3, 4, 5] : 기존 배열은 그대로
```
- ###### dropLast(_:)
```Swift
let numbers = [1, 2, 3, 4, 5]
print(numbers.dropLast(2))	// [1, 2, 3] : 뒤에서부터 2개 제거한 새로운 배열 반환
print(numbers.dropLast(10))	// [] : 뒤에서부터 10개 제거한 새로운 배열 반환
print(numbers) // [1, 2, 3, 4, 5] : 기존 배열은 그대로
```

<br>
<br>

### Array에서 원하는 값의 인덱스 찾기
- ##### 1. firstIndex(of:), lastIndex(of:)를 사용하여 원하는 값의 인덱스 찾기
###### of 인자 값으로 원하는 값을 적어준다.
###### 해당하는 값이 없을 때는 nil을 반환한다.
###### Optional Int 형태를 반환한다.
> ###### 1-1. firstIndex(of:)
###### 배열에 찾고자 하는 값이 여러개있을 경우, 가장 앞에 있는 값의 인덱스를 반환한다.
```Swift
var numbers = [1,2,3,4,4,3,2,1]
print(numbers.firstIndex(of:3)) // Optional(2)
print(numbers.firstIndex(of:5)) // 5의 값에 해당하는 index가 없기때문에 nil을 반환한다.
```
###### 반환값이 Optional이기 때문에 언랩핑하여 사용하면 된다.
```Swift
var fruits = ["apple", "banana", "carrot"]
if let i = fruits.firstIndex(of: "Banana"){
    fruits[i] = "beetroot"
}
print(fruits) // ["apple", "beetroot", "carrot"]
```
> ###### 1-2. lastIndex(of:)
###### 배열에 찾고자 하는 값이 여러개있을 경우, 가장 마지막에 있는 값의 인덱스를 반환한다.
```Swift
var numbers = [1,2,3,4,4,3,2,1]
print(numbers.lastIndex(of:3)) // Optional(5)
print(numbers.lastIndex(of:5)) // 5의 값에 해당하는 index가 없기때문에 nil을 반환한다.
```

<br>
<br>

### Array에서 특정 값이 포함되어있는지 검사하기
- ##### 1. firstIndex(of:)로 특정 요소가 있는지 검사하기
###### nil이 아닌지 검사하여 값이 포함되어있는지 검사한다.
```Swift
let numbers = [1,2,3]
print(numbers.firstIndex(of:2)) // Optional(2) -> 값이 있다.
print(numbers.firstIndex(of:4)) // nil -> 값이 없음
```

<br>

- ##### 2. contains()를 사용하여 특정 요소가 있는지 검사하기
###### Bool 값을 반환한다.
```Swift
var numbers = [1,2,3]
print(numbers.contains(2))   // true
print(numbers.contains(999)) // falst
```

<br>
<br>

### Array 정렬, 뒤집기
- ##### 1. reverse()를 사용해서 배열 뒤집기
###### 기존 배열의 순서를 거꾸로 뒤집는다.
```Swift
var array = [1,2,3,4,5,6]
array.reverse()
print(array) // [6,5,4,3,2,1]
```
<br>

- ##### 2. reversed()를 사용해서 배열 뒤집기
###### reverse와 다르게 기존 배열은 그대로 두고 순서가 뒤집어진 새로운 배열을 리턴한다.
```Swift
var array = [1,2,3,4,5,6]
array.reversed() // [6,5,4,3,2,1]
print(array) // [1,2,3,4,5,6]
```
<br>

- ##### 3. 배열 오름차순 정렬하기
> ###### 3-1. sort()
```Swift
var array = [1,3,5,2,4,6]
array.sort()
print(array) // [1,2,3,4,5,6]
```
> ###### 3-2. sorted()
###### sorted는 sort와 다르게 기존 배열은 그대로 두고 정렬된 새로운 배열을 리턴한다.
```Swift
var array = [1,3,5,2,4,6]
array.sorted() // [1,2,3,4,5,6]

// 위와 동일하다
array.sorted(by:<) // [1,2,3,4,5,6]
```

<br>

- ##### 4. 배열 내림차순 정렬하기
> ###### 4-1. sort(by: >)
```Swift
var array = [1,3,5,2,4,6]
array.sort(by: >)
print(array) // [6,5,4,3,2,1]
```
> ###### 4-2. sorted(by: >)
###### sort와 다르게 기존 배열은 그대로 두고 정렬된 새로운 배열을 리턴한다.
```Swift
var array = [1,3,2,4,5,6]
array.sorted(by: >) // [6,5,4,3,2,1]
print(array) // [1,3,2,4,5,6]
```

<br>
<br>

### Array의 최대 최소값 찾기
##### 반환값은 Oprional 요소이므로 Unwrapping하여 사용하면 된다.
```Swift
var numbers = [1,2,3]
print(numbers.min()) // Optional(1)
print(numbers.max()) // Optional(3)
```
###### 빈 배열에서 사용하면 nil을 반환한다.
```Swift
var numbers = [Int]()
print(numbers.min()) // nil
print(numbers.max()) // nil
```
##### Comparable protocol을 준수하지 않는 요소일 경우 컴파일 에러를 발생한다.
```Swift
var objects = [CustomClass]()
print(objects.min()) // [!] Compile Error
print(objects.max()) // [!] Compile Error
```

<br>
<br>

### Array의 첫번째 인덱스, 마지막 인덱스 찾기
###### startIndex는 항상 0이고, endIndex는 마지막 인덱스 보다 하나 큰 값 == count 값과 같다.
```Swift
var numbers = [1,2,3,4,5]
print(numbers.startIndex) // 0
print(numbers.endIndex) // 5

var numbers = []
print(numbers.startIndex) // 0
print(numbers.endIndex) // 0
```


<br>
<br>

### Array의 첫번째 값, 마지막 값 찾기
```Swift
var numbers = [1,2,3,4,5]
print(numbers.first) // Optional(1)
print(numbers.first) // Optional(5)

var numbers = [Int]()
print(numbers.first) // nil
print(numbers.last) // nil
```

<br>
<br>

#### 참고자료
- ###### https://tngusmiso.tistory.com/42
- ###### https://tngusmiso.tistory.com/44