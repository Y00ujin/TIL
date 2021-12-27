## Dictionary

<br>

> ##### Swift에서는 값을 저장하기 위한 세 가지 Primary(기본) Collection type을 제공한다. 이번 장에서는 Primary Collection type(Dictionary, Array, Set) 중 Dictionary를 알아보겠다!

<br>

### Dictionary란?
- ##### key와 value로 데이터를 저장하는 컨테이너
- ##### 각각의 value는 유일한 key 값에 물려있으며, key값은 Dictionary안에서  value를 찾기 위한 식별자역할을 한다.
- ##### Dictionary는 순서가 없다. key값으로 value를 찾기때문에 순서가 의미가 없는 것
- ##### KeyType은 해쉬가능한 타입어야한다. 반면에 ValueType은 어떤 타입이든 가능함
- ##### 모든 Key의 자료형은 같아야 하고, 마찬가지로 모든 Value의 자료형도 같아야 한다


<br>

### Dictionary 생성 방법
- ##### 1. `KeyType`이 `Int`이고, `ValueType`이 `String`인 Dictionary를 생성하는 방법
```Swift
var dictionary: [Int : String] = [:]

var dictionary = [Int : String]()

var dictionary: Dictionary = [Int : String]()

var dictionary: Dictionary<Int, String> = Dictionary<Int, String>()
```

- ##### 2. Value에 여러 타입을 저장하는 Dictionary 생성하는 방법
###### Any는 Hashable을 준수하는 자료형이 아니기 때문에 Key값에 Any를 넣게되면 오류가 발생함 따라서 Value만 여러 타입을 받을 수 있다.
```Swift
var dictionary: [String: Any] = ["name":"youjin", "age":18]
var dictionary: NSDictionary = ["name":"youjin", "age":18]
```


- ##### 2. Dictionary 생성과 동시에 초기화하는 방법
###### 모두 [1:"youjin", 2:"youjan", 3:"youjen"]를 넣었지만, 이 순서대로 출력이 된다는 보장은 없다. Dictionary는 순서가 없기 때문
```Swift
var dictionary: [Int : String] = [1:"youjin", 2:"youjan", 3:"youjen"]

var dictionary = [1:"youjin", 2:"youjan", 3:"youjen"] // 타입유추

var dictionary: Dictionary = [1:"youjin", 2:"youjan", 3:"youjen"]

var dictionary: Dictionary<Int, String> = [1:"youjin", 2:"youjan", 3:"youjen"]
```

<br>

### Dictionary 갯수 확인하기
```Swift
var dictionary = ["height":161, "age":18]

print(dictionary.count) // 3
print(dictionary.isEmpty) // false
```

<br>

### Dictionary Value에 접근하기
```Swift
var dictionary = ["height":161, "age":18]

// 1. 반환 값 - Optional Type (해당 Key값이 없을 수도 있기 때문에 Optional Type)
let height = dictionary["height"] // Optional(165)
let weight = dictionary["weight"] // nil

// 2. 반환 값 - Non Optional Type (default값을 지정하여 Optional Type을 없애버리기)
let height = dictionary["height", default: 150] // nil이면 150반환 : 165
let width = dictionary["weight", default: 200] // nil 이면 200반환 : 200
```

<br>

### Dictionary의 Value 수정, 추가하기
```Swift
var dictionary = ["height": 165, "age": 100]
```
- ##### 1. updateValue를 이용하여 접근하여 수정, 추가하기
```Swift
// 해당 Key가 없으면 추가하고 nil 리턴
dictionary.updateValue(100, forKey: "weight") // nil
print(dictionary) // ["height": 165, "age": 100, "weight": 100]

// Dictionary의 데이터를 안전하게 가져와서 사용하려면 Optional Binding을 사용하자
if let youjinWeight = dictionary["weight"]{
    print(youjinWeight)
}else{
    print("해당 Key값이 없음")
}

// 해당 Key가 있다면, 해당 Value로 수정하고 수정하기 전 값 리턴
dictionary.updateValue(200, forKey: "height") // Optional(165)
print(dictionary) // ["age": 100, "height": 200]
```
- ##### 2. substring을 이용하여 접근하여 수정, 추가하기
```Swift
// 해당 Key가 없다면, 추가 (insert)
dict1["weight"] = 100    

// 해당 Key가 있다면, 해당 Value로 수정 (update)
dict1["height"] = 200
```

<br>

### Dictionary에 요소 삭제하기
```Swift
var dictionary = ["height": 165, "age": 100]
```

- ##### 1. subcript로 삭제하기 (nil 대입하기)
```Swift
// 해당 Key 값이 없어도 에러 안남
dictionary["weight"] = nil

// 해당 Key가 있다면, 해당 Key-Value 삭제
dictionary["height"] = nil
print(dictionary) // ["age": 100]
```

- ##### 2. removeValue(forKey:)로 삭제하기
```Swift
// 해당 Key가 없다면, nil 반환
dictionary.removeValue(forKey: "weight") 

// 해당 Key가 있다면, 해당 Key-Value 삭제 후 삭제된 Value 반환
dictionary.removeValue(forKey: "age") // Optional(100)
```

- ##### 3. removeAll로 전체 삭제하기
```Swift
dict1.removeAll()
```

<br>

### Dictionary Key, Value 나열하기
```Swift
var dictionary = ["height":165, "age":100]
```

- ##### Key 모두 나열하기
```Swift
dictionary.keys.sorted() // "age", "height"
```

- ##### Value 모두 나열하기
```Swift
dictionary.values.sorted() // 100, 165
```

<br>

### Dictionary for문
```Swift
var dictionary = ["height": 165, "age" : 100]

// 1. Key, Value 모두 출력
for (key,value) in dictionary{
    print(key,value, separator: ",")
}
// height,165
// age,100

// 2. Key 모두 출력
for (key) in dictionary.keys{
    print(key) // height, age
}

// 3. Value 모두 출력
for (key) in dictionary.values{
    print(key) // 165, 100
}
```

<br>

### Dictionary 비교하기
###### 모든 Key와 Value가 정확ㅣ 모두 일치해야만 true가 나옴! 대소문자도 비교
```Swift
var dict1 = ["height": 165, "age" : 100]
var dict2 = ["height": 165, "age" : 100]
var dict3 = ["Height": 165, "Age" : 100]
var dict4 = ["name": "sodeul", "address" : "Suwon"]
 
dict1 == dict2              // true
dict1 == dict3              // false (대소문자 다름)
dict1 == dict4              // false (모든 Key-Vlaue 다름)
```

<br>

#### 참고자료
- ###### https://babbab2.tistory.com/113
- ###### https://minmong.tistory.com/145


