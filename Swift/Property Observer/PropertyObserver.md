## Property Observer

<br>

### Property Observer란?
- ##### 프로퍼티 감시자를 사용하면 프로퍼티의 값이 변경됨에 따라 적절한 대응을 하는 것이 가능합니다.
- ##### 프로퍼티 감시자는 값이 새로 할당될 때마다 호출되게 됩니다. (그렇다면 변경되는 값이 이전의 값과 같으면 어떻게 될까요? 정답은 변경되는 값이 같더라도 호출!됩니다.)
- ##### 전역변수, 지역변수 모두에서 사용가능하다.
- ##### 지연 저장 프로퍼티를 제외한 변수나 상수를 저장하는 저장 프로퍼티에 사용이 가능하며 상속받은 연산 프로퍼티에도 사용이 가능합니다.
- ##### 재정의를 통해 상속받은 저장 프로퍼티 또는 연산 프로퍼티에도 추가가 가능합니다. 하지만 상속받지 않은 연산 프로퍼티에는 정의해줄 필요가 없습니다. 왜냐하면 연산 프로퍼티의 setter에서 프로퍼티 감시자를 구현이 가능하기 때문입니다!
- ##### 프로퍼티 감시자는 프로퍼티의 값이 변경되기 직전 호출되는 willSet 메서드와  프로퍼티의 값이 변경된 직후에 호출되는 didSet 메서드가 있습니다.

<br>

### willSet?
- ##### 프로퍼티의 값이 변경되기 직전 호출되는 메서드
- ##### willSet 메서드에 전달되는 전달 인자는 `프로퍼티가 변경될 값` 입니다.
- ##### 연산 프로퍼티의 set 과 마찬가지로 매개변수 이름에 괄호를 쓰지 않는다면 `기본 매개변수인 newValue` 를 사용할 수 있습니다.


<br>


### didSet?
- ##### 프로퍼티의 값이 변경된 직후에 호출되는 메서드
- ##### didSet 메서드에 전달되는 전달 인자는 `프로퍼티가 변경되기 전의 값` 입니다.
- ##### 매개변수 이름을 지정하지 않는다면 `기본 매개변수인 oldValue` 를 사용할 수 있습니다.

<br>

### willSet, didSet 사용해보기
```Swift
var name: String = "defaultYoujin" {
    willSet{
        print("wilSet : [ name = \(name) ], [ newValue = \(newValue) ]")
    }
    didSet{
        print("didSet : [ name = \(name) ], [ oldValue = \(oldValue) ]")
    }
}

// 변경되기 직전, wilSet 메서드가 실행된다
// wilSet 메서드의 매개변수(newValue)로 변경될 값 즉 newYoujin이 전달된다.
// 출력 : wilSet : [ name = defaultYoujin ], [ newValue = newYoujin ]
name = "newYoujin"
// 변경된 직후, didSet 메서드가 실행된다
// didSet 메서드의 매개변수(oldValue)로 변경전 값 즉 defaultYoujin이 전달된다.
// 출력 : didSet : [ name = newYoujin ], [ oldValue = defaultYoujin ]
```


<br>

#### 참고자료
- ###### https://velog.io/@chagmn/Swift-%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0-%EA%B0%90%EC%8B%9C%EC%9E%90
- ###### https://minosaekki.tistory.com/5
- ###### https://alohalimi.tistory.com/entry/SWIFT-%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0-%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0-%EA%B0%90%EC%8B%9C%EC%9E%90-%E2%98%85%E2%98%85%E2%98%85