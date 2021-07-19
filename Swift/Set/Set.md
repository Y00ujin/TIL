# **Set**

- #### ```Set``` 이해해보기 with Youjin 👩🏻‍💻

### Set이 뭐야?

> #### ```정렬되지 않은 컬렉션이다. 즉, 삽입한 순서대로 안나옴```
> #### ```배열과 달리 중복 요소를 허용하지 않는다```
> #### ```저장되는 자료형은 모두 동일한 자료형이어야 한다```
> #### ```Hashable 프로토콜을 채택한 자료형만 저장할 수 있다```

- #### 선언해보자
```swift
var set2: Set<Int> = [] // 한 자료형만 담을 수 있는 Set
var set3: NSSet = [1, "s"] // 여러 자료형을 담을 수 있는 Set
```

- #### 사용해보자
```swift
var set1: Set<Int> = [1, 2, 5, 0]
set1.contains(1) // true
set1.contains(10) // false
```

- #### 값 추가하기
```swift
// 1. insert : 값을 추가하고, 추가된 결과를 튜플로 리턴 (중복이면 false, 추가된 값)
set1.insert(1)                // (false, 1)
set1.insert(10)               // (true, 10)
 
// 2. update : 값이 존재하지 않으면 추가 후 nil 리턴, 존재할 경우 덮어쓰기 후 덮어쓰기 전 값 리턴
set1.update(with: 1)          // Optioanl(1)
set1.update(with: 120)        // nil
```

- #### 값 삭제하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]
 
// 1. remove() : 한 가지 요소 삭제할 때 사용, 삭제 후 삭제한 값 return (없는 요소 삭제 시 nil 리턴)
set1.remove(1)              // Optional(1)
set1.remove(10)             // nil
 
// 2. removeAll() : 전체 요소 삭제
set1.removeAll()  
 
```
