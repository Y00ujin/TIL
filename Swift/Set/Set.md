## Set

<br>

> ##### Swift에서는 값을 저장하기 위한 세 가지 Primary(기본) Collection type을 제공한다. 이번 장에서는 Primary Collection type(Dictionary, Array, Set) 중 Set을 알아보겠다!

<br>


### Set이란?
- ##### 정렬되지 않은 컬렉션이다. 즉, 삽입한 순서대로 안나옴
- ##### 배열과 달리 중복 요소를 허용하지 않는다
- ##### 저장되는 자료형은 모두 동일한 자료형이어야 한다
- ##### Hashable한 타입만 저장할 수 있다
- ##### 중복값이 없다.
- ##### 해시를 통해 값을 저장하기 때문에 배열에 비해 속도가 빠르다.
- ##### 저장되는 자료형은 모두 동일한 자료형이어야한다.

<br>

### Set 선언 방법
```swift
var set1 = Set<String>()
var set2: Set<Int> = [] // 한 자료형만 담을 수 있는 Set
var set3: NSSet = [1, "s"] // 여러 자료형을 담을 수 있는 Set

// Set이라고 명시해주지않으면 배열로 인식됩니다.
var set4 = ["hello","youjin"] // 배열
var set4: Set = ["hello","youjin"] // Set

```

<br>

### Set 값 검사하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]

set1.contains(1) // true
set1.contains(10) // false
```

<br>

### Set 값 추가, 수정하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]

// 1. insert : 값을 추가하고, 추가된 결과를 튜플로 리턴 (중복이면 false, 추가된 값)

// 중복이면 변화가 없다.
set1.insert(1)                // (false, 1)
set1.insert(10)               // (true, 10)
 
// 2. update : 값이 존재하지 않으면 추가 후 nil 리턴, 존재할 경우 덮어쓰기 후 덮어쓰기 전 값 리턴

// 1이 존재하므로 덮어쓰고 덮어쓰기 전 값 1 리턴
set1.update(with: 1)          // Optioanl(1)
set1.update(with: 120)        // nil
```

<br>

### Set 값 삭제하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]
 
// 1. remove() : 한 가지 요소 삭제할 때 사용, 삭제 후 삭제한 값 return (없는 요소 삭제 시 nil 리턴)
set1.remove(1)              // Optional(1)
set1.remove(10)             // nil
 
// 2. removeAll() : 전체 요소 삭제
set1.removeAll()  
 
```

<br>

### Set과 반복문
###### 넣은 순서에 상관없이 순서 없이 컴파일할 때마다 순서가 다르게 나온다
```Swift
var set1: Set<Int> = [1, 2, 5, 0]

for index in set1{
    print(index) // 5 1 2 0
}
```

<br>

### Set 비교하기
```Swift
var set1: Set<Int> = [1, 2, 5, 0]
var set2: Set<Int> = [0, 2, 1, 5]
var set3: Set<Int> = [1, 3, 11, 20]

// Set은 정렬되지 않은 Collection이기 때문에, 순서에 상관 없이 모든 요소가 같으면 비교 연산자가 true가 됨
set1 == set2 // true
set1 == set3 // false
```

<br>

### 포함관계 확인하기
```Swift
var set1: Set<Int> = [1, 2, 5, 0]
var set2: Set<Int> = [1, 2]

// set2에 set1이 포함되어있다. -> flase
set1.isSubset(of: set2)
// set1에 set2가 포함되어있다. -> true
set2.isSubset(of set1)

// true
set1.isSuperset(of: set2)
// false
set2.isSuperset(of: set1)

var set13: Set<Int> = [1, 2, 5, 0]
var set14: Set<Int> = [1, 2, 5, 0]
var set15: Set<Int> = [3, 7, 9, 10]
 
set13.isDisjoint(with: set14)               // false (같은 집합 : 모든 요소가 동일한 집합)
set15.isDisjoint(with: set13)               // true  (서로수 집합 : 모든 요소가 다른 집합)

```

<br>

### Set의 특별한 메소드 써보기
```Swift
var a: Set = [1,2,3,4,5,6,7,8,9]
var b: Set = [1,3,5,7,9]
var c: Set = [2,4,6,8,10]
 
// 1. intersection : 교집합을 새로운 Set으로 리턴
a.intersection(b)                     // [1, 3, 5, 9, 7]
b.intersection(c)                     // [] : 겹치는 요소 없음
 
// 2. union : 합집합을 새로운 Set으로 리턴
a.union(b)                            // [2, 7, 9, 4, 8, 5, 6, 1, 3]
b.union(c)                            // [9, 3, 10, 4, 1, 8, 7, 2, 6, 5]
 
// 3. sysmetricDifference : 여집합을 새로운 Set으로 리턴
a.symmetricDifference(b)              // [4, 8, 6, 2]
b.symmetricDifference(c)              // [10, 9, 8, 6, 7, 1, 2, 4, 3, 5]
 
// 4. subtracting : 차집합을 새로운 Set으로 리턴
a.subtracting(b)                      // [4, 8, 6, 2]
b.subtracting(c)                      // [9, 1, 3, 5, 7]
```

#### 참고자료
- ###### https://zeddios.tistory.com/131
- ###### https://babbab2.tistory.com/114
- ######
- ######
