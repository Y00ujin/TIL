## @discardableResult

<br>
<br>

### @discardableResult란?
##### 값을 반환하는 함수 또는 메서드가 결과를 사용하지 않고 호출될 때 컴파일러 경고 표시를 제거할 수 있는 속성

<br>
<br>

### @discardableResult 사용하기
##### 아래와 같이 Bool 값을 반환하는 메서드가 있습니다. 우리는 return 값을 사용할 때도 있지만 사용하지 않을 때도 있습니다. return 값을 선언해두었을때, 함수 호출 시에 return 값을 사용하지 않을 때 컴파일러는 왜 결과 사용 안하냐고 경고를 발생시킵니다.
```Swift
func getBoolValue() -> Bool{
    return true
}

getBoolValue() 
// true가 반환되지만 true를 어떠한 방법으로도 사용하지 않고 있는 상태
// 컴파일러는 이때 왜 함수의 결과를 사용하지 않냐고 경고를 띄움
```

##### 이러한 경고를 무시하고 싶을 때 `@discardableResult` 속성을 사용합니다. 함수 선언부 맨 앞에 작성하면 경고가 사라집니다.
```Swift
@discardableResult func getBoolValue() -> Bool{
    return true
}
```
