# **Map**

- #### ```Map``` 이해해보기 with Youjin 👩🏻‍💻

### Map이 뭐야?

> #### ```스위프트의 대표적인 매개변수로 함수를 갖는 함수```
> #### ```클로저로 각 항목들을 반영한 결과물을 가진 새로운 배열을 반환합니다.```
> #### ```컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 새로운 컨테이너를 생성하여 반환 (기존 컨테이너의 값은 변경되지 않음)```


### Map이 뭐라고..?
``` 즉, ```
### Map을 사용해보자!
- ##### 이게 원래 사용하는 방법인데 많이 축약할 수 있다!!
```swift
    let array = [0, 1, 2, 3]
    let multipliedArray = array.map( { (value: Int) -> Int in return value * 2 } )
    // [2, 4, 6, 8]
```
- ##### 이런식으로 축약하여 사용할 수 있다 😨
```swift
    let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    let lowercaseNames = cast.map { $0.lowercased() }
    // 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
    let letterCounts = cast.map { $0.count }
    // 'letterCounts' == [6, 6, 3, 4]
```

```swift
    let array = [0, 1, 2, 3]
    let newArray = array.map { $0 * 2 }
    // [2, 4, 6, 8]
```

### END!