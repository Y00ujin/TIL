# **Filter**

- #### ```Filter``` 이해해보기 with Youjin 👩🏻‍💻

### Filter?

> #### ```filter는 데이터를 추출하고자 할 때 사용한다```
> #### ```기존 컨테이너에서 내부의 값을 걸러 새로운 컨테이너를 만든다```
> #### ```Filter는 반환타입이 Bool인 매개변수 함수의 결과가 true면 새로운 컨테이너에 값을 담아 반환한다```

```배열 내의 요소들을 필터링하여 배열들의 부분집합을 반환해준다``` 

#### 따라서 배열 내의 요소들을 ```필터링```하여 ```필터```에 걸린 요소들을 반환해주는 것!

### Filter, 어떻게 사용할까?
```swift
var array = [1,2,3,4,5,6,7,8,9]

var oddArray = array.filter { $0 % 2 == 0 }

print(oddArray) // 2, 4, 6, 8
```