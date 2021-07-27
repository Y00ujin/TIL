# **Closure**

- #### ```Closure``` 이해해보기 with Youjin 👩🏻‍💻

### Closure, 뭐야?

- ##### ```클로저는 사용자의 코드 안에서 전달되어 사용할 수 있는 로직을 가진 중괄호“{}”로 구분된 코드의 블럭이며, 일급 객체의 역할을 할 수 있다.```
- ##### ```일급 객체는 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달할 수 있으며, 함수의 반환 값이 될 수도 있다.```
- ##### ```함수와는 다르게 함수 이름 정의가 따로 존재하지 않습니다. 하지만 파라미터를 받을 수 있고, 반환 값이 존재할 수 있다는 점에서 함수와 동일합니다.```
- ##### ```참조 타입이다.```
- ##### ```함수는 클로저의 한 형태로, 이름이 있는 클로저이다.```



### 응..? 그래서 클로저가 뭐라고...? 👩🏻‍💻
> #### 클로저는 중괄호({})로 감싸진 '실행 가능한 코드 블럭'이다.

 ### Closure는 어떤 형태가 있을까?
- ##### ```전역 함수``` : 이름이 있고 어떤 값도 캡쳐하지 않는 클로저
- ##### ```중첩 함수``` : 이름이 있고 관련한 함수로 부터 값을 캡쳐 할 수 있는 클로저
- ##### ```클로저 표현``` : 경량화 된 문법으로 쓰여지고 관련된 문맥(context)으로부터 값을 캡쳐할 수 있는 이름이 없는 클로저


### Closure, 사용해볼까?
- ##### 클로저는 ```중괄호({})```로 감싸져있습니다. 그리고 ```파라미터를 괄호(())로 감싸서``` 정의하고요. 함수와 마찬가지로 ```->를 사용해서 반환 타입```을 명시합니다. 조금 다른 점은 ```in 키워드를 사용해서 파라미터, 반환 타입 영역과 실제 클로저의 코드를 분리```하고 있습니다.
```swift
{ (firstName: String, lastName: String) -> String in
  return lastName + firstName + message
}
```

### Closure, 간결하게 생략하여 사용해보자!
- ##### 클로저의 장점은 사실 ```간결함```와 ```유연함```에 있습니다. 바로 위에서 작성한 코드는 이해를 돕기 위해 생략가능한 것들을 하나도 생략하지 않고 모두 적었기 때문에 조금 복잡해보일 수 있습니다. 이제 하나씩 ```생략```해볼까요?

###### 첫 번째 파라미터는 $0, 두 번째 파라미터는 $1로 바꿔서 쓸 수 있습니다!
```swift
func helloGenerator(message: String) -> (String, String) -> String {
  return {
    return $1 + $0 + message
  }
}
```

###### 클로저 내의 코드가 한 줄이라면 return도 생략할 수 있습니다!
```swift
func helloGenerator(message: String) -> (String, String) -> String {
  return { $1 + $0 + message }
}
```

###### 클로저는 변수처럼 정의할 수 있습니다!
```swift
let hello: (String, String) -> String = { $1 + $0 + "님 안녕하세요!" }
hello("유진", "김")
```

###### 클로저를 변수로 정의하고 함수에서 반환할 수도 있는 것처럼, 파라미터로도 받을 수 있습니다.
```swift
func manipulate(number: Int, using block: Int -> Int) -> Int {
  return block(number)
}

manipulate(number: 10, using: { (number: Int) -> Int in
  return number * 2
})
```

<br>
-

###### 참고자료
- ###### https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-3/functions-and-closures.html