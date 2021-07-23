# **Reduce**

- #### ```Reduce``` 이해해보기 with Youjin 👩🏻‍💻

### Reduce, 뭐야?

> #### ```배열의 모든 값을 전달인자로 전달받은 클로저의 연살 결과로 합해줍니다.```
> #### ```컨테이너 내부의 콘텐츠를 하나로 합하는 기능을 실행하는 고차함수```
> #### ```기존 컨테이너에서 내부의 값들을 결합하여 새로운 값을 만듭니다.```
### Reducd, 사용해보자!
- ##### Reduce는 클로저가 각 요소를 전달받아 연산한 후 값을 다시 클로저 실행을 위해 반환하며 컨테이너를 순환하는 형태이다
```swift
    public func reduce<Result>(_ initialResult: Result, 

_ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
```
- ##### 이런식으로 축약하여 사용할 수 있다 😨
```swift
    let numberArray = [1,2,3,4,5,6,7,8,9,10]
    let sum = numberArray.reduce(0) { $0 + $1 }
    print(sum)
    // 55
```

### END!
