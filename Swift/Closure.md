## Closure

<br>
<Br>

### Closure이란 ?

- ##### 클로저는 사용자의 코드 안에서 전달되어 사용할 수 있는 로직을 가진 중괄호“{}”로 구분된 코드의 블럭이며, 일급 객체의 역할을 할 수 있다
- ##### 일급 객체는 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달할 수 있으며, 함수의 반환 값이 될 수도 있다
- ##### 함수와는 다르게 함수 이름 정의가 따로 존재하지 않습니다. 하지만 파라미터를 받을 수 있고, 반환 값이 존재할 수 있다는 점에서 함수와 동일합니다
- ##### 참조 타입이다
- ##### 함수는 클로저의 한 형태로, 이름이 있는 클로저이다
- ##### 클로저는 중괄호({})로 감싸진 '실행 가능한 코드 블럭'이다.

<br>
<br>

### Closure의 형태
##### 1. 전역 함수
- ###### 이름이 있고 어떤 값도 캡쳐하지 않는 클로저

```Swift

```

<br>

##### 2. 중첩 함수
- ###### 이름이 있고 관련한 함수로부터 값을 캡쳐할 수 있는 클로저
###### 함수 내부에 또 다른 함수를 생성할 수 있는데 이렇게 함수 내부에 또 다른 함수를 가지고있는 함수를 중첩함수라고 한다.
###### 내부함수는 외부함수에 선언된 변수와 인자에 접근 가능하다.
###### 내부함수는 외부함수가 실행되는 순간 생성되고, 종료되는 순간 소멸한다.
###### 외부함수를 호출했을 때 내부함수를 반환하여 외부에서 사용하는 것도 가능하다. 아래는 내부함수를 반환하는 중첩함수이다.

```Swift
// 함수의 반환타입에 반환할 함수의 인자 값, 반환 값의 타입을 적어준다.
// ((Int) -> Int) 란 (Int) 즉 Int를 인자로 받아 Int를 반환하는 내부 함수를 반환하겠다는 뜻
func IncDec(want:Int) -> ((Int) -> Int){ // 외부함수
  func Inc(number: Int) -> Int{ // 내부함수
    return number + 1
  }

  func Dec(number: Int) -> Int{ // 내부함수
    return number - 1
  }

  if want = 1 {
    return Inc
  }else{
    return Dec
  }
}

var increment = IncDec(want: 1)
print(increment(7)) // 8
```

<br>

##### 3. 클로저 표현
- ###### 경량화 된 문법으로 쓰여지고 값을 캡쳐할 수 있는 이름이 없는 클로저

<br>
<br>


###### 참고자료
- ###### https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-3/functions-and-closures.html
- ###### https://jusung.gitbook.io/the-swift-language-guide/language-guide/07-closures