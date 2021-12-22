## **forEach**

<br>

### forEach란?
- ###### Collection의 요소 갯수만큼 반복하는 함수
- ###### 반복 실행하려는 코드를 파라미터로 받고, 저장된 요소는 클로저 상수로 전달된다. 

### forEach 사용법
```swift
let array = [1,2,3,4,5]
array.forEach { // array의 요소 갯수(5)만큼 반복
    print($0) // $0를 사용하여 각각의 Element들을 호출 합니다.
    // [1, 2, 3, 4, 5]
}
```

### forEach + (return, continue, break) = ?
#### 1. forEach + return
```Swift
let array = [1,2,3,4,5]

array.forEach {
    if $0 == 2 {
        return // for-in의 continue와 동일하게 작동한다
    }
    print($0)
}
```

#### 2. forEach + continue, break
- ##### continue, break는 반복문에서 사용할 수 있는 것인데 forEach는 함수의 파라미터로 "클로저"로 작성해서 넘겨주는 것이라 forEach안에서 continue, break를 사용하면 에러가 남!

```Swift
let array = [1,2,3,4,5]

array.forEach {
    if $0 == 2 {
        continue // errer
        break    // errer
    }
    print($0)
}
```

### 반복 index를 알고싶다면, enumerated(), indices !
``` Swift
nums.enumerated().forEach {
    print("(index: \($0) num: \($1))")             // (index: 0 num: 1) (index: 1 num: 2) (index: 2 num: 3) (index: 3 num: 4)
}
 
nums.indices.forEach {
    print("(index: \($0) num: \(nums[$0]))")       // (index: 0 num: 1) (index: 1 num: 2) (index: 2 num: 3) (index: 3 num: 4)
}
```

### for-in vs forEach
> ##### break, continue
- ###### for in은 반복문이라 break, continue가 사용 가능한데, forEach는 반복문이 아닌 클로저이기때문에 반복문 안에서만 사용 가능한 continue, break를 사용할 수 없다.
```Swift
for num in nums {
    break
    continue
}
 
nums.forEach {
    break       // error! 
    continue    // error! 
}
```
> ##### return
- ###### for in은 반복문을 돌다가 return을 만나면 함수 자체가 종료됨
```Swift
func withForIn() { // 함수를 실행할 경우 1만 출력하고 함수에서 나옴
    let nums = [1, 2, 3]
    
    for num in nums {
        print(num)
        return
    }
}
```
- ###### 하지만 forEach는 return을 만나면 클로저를 종료시킴 이 말은 반복 횟수에 영향을 주지 않는다는 것!
- ###### 왜냐면 forEach는 내가 전달한 클로저를 요소 갯수 만큼 실행하는 것인데 클로저 내에서 return을 만나면 현재 클로저를 종료시키고 클로저를 요소 갯수 만큼 반복하기위해 또 다음 클로저를 실행하기때문! 즉 for-in의 continue처럼 동작함
```Swift
func withForEach() { // 함수를 실행할 경우 1 2 3 모두 출력된다!
    let nums = [1, 2, 3]
    
    nums.forEach {
        print($0)
        return
    }
}
```

<br>

#### 참고자료
- ###### https://babbab2.tistory.com/95
- ###### https://jinshine.github.io/2018/12/13/Swift/21.%EA%B3%A0%EC%B0%A8%ED%95%A8%EC%88%98(1)%20-%20forEach,%20filter,%20reduce/
- ###### https://kimlh2.tistory.com/entry/Swift-for-in-foreach-%EC%9D%98-%EC%B0%A8%EC%9D%B4%EC%A0%90