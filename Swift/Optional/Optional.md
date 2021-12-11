# Optional

- #### `Optional` 이해해보기 `2021.12.11`

<img width="750" alt="스크린샷 2021-12-11 오후 3 46 33" src="https://user-images.githubusercontent.com/71479613/145667286-f57d055a-1d7e-4acc-9350-50d45321ca16.png">

#### Optional은 래핑된 값 또는 값 nil의 부재 를 나타내는 형식입니다.

<br>

### Optional

<br>


### Optional 언제 사용할까?
- ##### 변수안에 값이 확실히있다는 것을 보장 할 수 없으면 Optional을 사용한다.

<br>

### Optional 사용법
- ##### 변수 타입 오른쪽에 ?를 붙여보자
```Swift
// optional변수는 초기화 하지 않으면 nil로 초기화가 자동으로 됨
var youjin : Int?

// Swift에서는 기본적으로 변수 선언시 nil 값이 들어가는 것을 허용하지 않습니다. 런타임 에러를 뿜는 것이 아니라, 아예 컴파일 에러를 내버립니다. 그래서 옵셔널 타입이 아닌 변수에 nil을 넣으면 오류!
youjin = nil
```
<br>

### !와 ?의 차이
- ##### ?
```Swift
var someValue : Int? = 30
var Value = someValue // Value는 Optional 타입 Int형 값을 가질 수도, 안가질 수도 있음

var someValue :Int? = 30
var Value : Int = someValue // 옵셔널을 담을 수 없기때문에 오류 발생!
```

- ##### !
```Swift
var someValue :Int? = 30
var Value : Int = someValue! // 오류가 안남
// 오류가 안나는 이유 ? someValue 상자를 부셔서 값을 꺼냈으니까! 그런데 이때 상자를 부셨을 때 값이 없으면 오류남
```

```Swift
var someValue : Int? = nil
var Value : Int = someValue! // 이때는 오류가 남! 왜냐면 Int 변수에 somValue를 부셔서 가져온 nil을 넣으려고했기때문에!
```

<br>

### Optional변수에서 값을 가져오는법
- #### 옵셔널 바인딩
> ##### if let(또는 if var)을 사용하여 nil인지 검사하는 방법
```Swift
 var myName: String? =  nil

 if let name = myName { // myName이라는 상자에 노크해보고 값이 있으면 name에 넣어주고 조건문을 실행한다.
     printName(_name: name) // nil로, 값이 있을때만 값이 바인딩 되기 때문에 조건문이 실행되지 않는다.
 }
```

- #### 옵셔널 체이닝
> ##### 옵셔널 체이닝은 하위 property에 optional 값이 있는지 연속적으로 확인하면서, 중간에 하나라도 nil이 발견된다면 nil이 반환되는 형식!
```Swift

class Person {
    var residence: Residence? 
}


class Residence {
    var numberOfRooms = 1
}

let youjin = Person() // residence는 nil

// 옵셔널 체이닝은 옵셔널 바인딩과 종종 같이 쓰임
if let roomCount = youjin.residence?.numberOfRooms { // youjin의 residence가 nil이 아니라면 이번엔 numberOfRooms을 검사하여 nil이 아니라면 조건문을 실행하는 방식이다.
    print("room Count : \(roomCount)")
} else {
    print("no room") // residence가 nil이기때문에 no room실행
}
```

<br>

### !는 언제 쓰면 좋을까?
- ##### implicitly unwrapped optionals 즉, 확실히 값이 있는 변수는 그냥 바로 깨부셔서 값을 가져와야겠죠!
- ##### 옵셔널 바인딩, 체이닝으로 매번 값을 추출하기 귀찮거나 로직상으로 nil이 할당되지 않을 것 같다는 확신이 들 때 사용



<br>

#### 참고자료
- ###### https://zeddios.tistory.com/16
- ###### https://medium.com/@codenamehong/swift-optional-1-54ae4d37ee09