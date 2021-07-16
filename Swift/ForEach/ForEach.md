# **forEach**

- #### ```forEach``` 이해해보기 with Youjin 👩🏻‍💻

### forEach가 뭐야?

-  #### ```Collection의 요소 개수만큼 내가 반복하고 싶은 구문을 반복하는 함수```
-  #### ```for-in과 동일하게 각각의 Element들을 호출 합니다```
- #### ```forEach는 반복문이 아니라, 클로저를 파라미터로 넘겨주는 메서드```

### forEach, 어떻게 사용할까?
```swift
let array = [1,2,3,4,5]
array.forEach {
    print($0) // [1, 2, 3, 4, 5]
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

### for-in랑 다른 점이 뭘까? 👩🏻‍💻
- ###### forEach에서는 break, continue 구문을 사용할 수 없고, <br> return을 통해서 빠져나갈 수 있음!
 - ###### for-in에서는 break, continue을 사용할 수 있고 <br> return을 사용하면 함수가 종료됨.