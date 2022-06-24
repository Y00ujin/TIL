## Access Control(접근제어)

<br>
<br>

### Access Control(접근제어)?
- ##### 접근제어(Access Control)는 특정 코드의 접근을 다른 소스파일이나 모듈에서 제한하는 것입니다. 
- ##### 접근제어를 함으로써 특정 코드의 세부적인 구현을 감추고 딱 필요한 만큼 공개해 다른 곳에서 사용할 수 있도록 합니다.
- ##### 접근제어는 `클래스, 구조체, 열거형` 등 개별 타입에도 적용할 수 있고 그 타입에 속한 `프로퍼티, 메소드, 초기자, 서브스크립트`에도 적용할 수 있습니다.

<br>
<br>

### 모듈과 소스파일
- ##### Swift의 접근제어는 모듈과 소스파일에 기반을 두고 있습니다. 
- ##### 모듈은 `코드를 배포하는 단일 단위`로 `하나의 프레임워크나 앱이` 이 단위로 배포되고 다른 모듈에서 Swift의 import키워드를 사용해 import될 수 있습니다. Xcode의 각 빌드 타겟은 Swift에서 분리된 단일 모듈로 취급됩니다. 
- ##### 또한 소스파일은 모듈안에 있는 소스파일을 의미합니다. 각 소스파일에 여러 특정 타입을 선언해 사용할 수 있습니다.

<br>
<br>

### 1. open & public
- ##### Open과 Public 접근자 모두 선언한 모듈이 아닌 다른 모듈에서 사용가능합니다.(import키워드를 사용하여) 두 접근자의 차이점은 open은 다른 모듈에서 오버라이드와 서브클래싱(상속)이 가능하지만 public 접근자로 선언된 것은 모듈에서는 오버라이드와 서브클래싱(상속)이 불가능합니다.
`public class SomePublicClass {}`

### 2. internal
- ##### 기본 접근레벨로 아무 접근레벨을 선언하지 않으면 internal로 간주됩니다. inernal레벨로 선언되면 해당 모듈(프로젝트) 전체에서 사용 가능합니다.
`internal class SomeInternalClass {} //or`
`class SomeInternalClass {}`

### 3. fileprivate
- ##### 특정 엔티티를 선언한 파일(.swift) 안에서만 사용 가능합니다.
`fileprivate class SomeFilePrivateClass {}`

### 4. private
- ##### 특정 엔티티가 선언된 괄호({}) 안에서만 사용 가능합니다.
`private class SomePrivateClass {}`

<br>
<br>

### 가이드 원칙 (Guiding Principle of Access Levels)
- ##### 1. public 변수는 다른 internal, fileprivate, private 타입에서 정의될 수 없습니다. 왜냐하면 그 타입은 public 변수가 사용되는 모든 곳에서 사용될 수 없을 것이기 때문입니다.
- ##### 2. 함수는 그 함수의 파라미터 타입이나 리턴 값 타입보다 더 높은 접근 레벨을 갖을 수 없습니다. 왜냐하면 함수에는 접근 가능하지만 파라미터에 접근이 불가능 하거나 혹은 반환 값 타입보다 접근 레벨이 낮아 함수를 사용하는 관련 코드에서 이용할 수 없을 수 있기 때문입니다.
- ##### 3. 아무런 접근 레벨을 명시하지 않은 경우 internal을 갖게 됩니다.
- ##### 4. 단일 타겟 앱에서는 특별히 접근레벨을 명시할 필요가 없지만 필요에 따라 filprivate, private 등을 사용해 앱내에서 구현 세부사항을 숨길 수 있습니다.
- ##### 5. 기본적으로 open이나 public으로 지정된 엔티티만 다른 모듈에서 접근 가능합니다. 하지만 유닛테스트를 하는 경우 모듈을 import할때 import앞에 @testable이라는 애트리뷰트를 붙여주면 해당 모듀릉ㄹ 테스트가 가능한 모듈로 컴파일해 사용합니다.

<br>
<br>

### 클래스 + 접근제어
- ##### 서브클래스는 수퍼클래스보다 더 높은 접근레벨을 갖을 수 없습니다.
- ##### 하지만 메소드는 서브클래스에서 더 높은 접근 레벨을 갖는 메소드로 오버라이드할 수 있습니다.
```Swift
public class somePublicClass{
    private func somePrivateMethod(){}
}

internal class someInternalClass: somePublicClass{
    override internal func somePrivateMethod() {}
}
```
- ##### 타입 구성원의 기본 접근 수준은 internal입니다.
###### internal, file-private, private으로 접근 수준을 지정해놓으면 그 안 구성원들은 자동으로 해당 타입의 접근 수준을 따라가지만, public 과 open의 경우에는 구성원들의 접근 수준을 따로 명시해놓지 않으면 internal로 기본 접근 수준이 정해집니다.
###### 아래와 같은 코드가 있습니다.
```Swift
public class PublicClass{
  init() {}
  func someMethod(){}
}
```
###### 이 PublicClass의 접근 수준은 public입니다. 그럼 init()도 public일까요? 놉. public일 때 접근 수준을 명시해주지 않았기 때문에 internal이 됩니다.

<br>
<br>

### 튜플 + 접근제어
- ##### 하나는 internal 다른 하나는 private접근 권한을 갖는 2개의 타입으로 구성된 튜플은 더 낮은 레벨인 private 접근 레벨을 갖습니다.
- ##### 튜플은 자체적으로 접근레벨을 선언하지 않고 사용하는 클래스, 구조체, 열거형 그리고 함수 등에 따라 자동으로 최소 접근레벨을 부여 받습니다. 즉, 튜플은 명시적으로 접근권한을 명시하지 않습니다.
```Swift
internal class SomeInternalClass {}
private class SomePrivateClass {}

private func returnTupleFunction() -> (SomeInternalClass, SomePrivateClass) { //튜플이 가장 제한적인 엑세스인 private로 설정됨, 그래서 이 함수도 private으로 선언해야함.
  // function implementation goes here
  return (SomeInternalClass(), SomePrivateClass())
}
```

<br>
<br>

### 함수타입 + 접근제어
- ##### 함수 타입의 접근레벨은 함수의 파라미터 타입과 리턴타입의 접근레벨 중 최소의 접근레벨로 계산돼 사용됩니다. 그래서 그것에 맞는 접근 레벨을 함수 앞에 명시해줘야 합니다.
```Swift
internal class SomeInternalClass {}
private class SomePrivateClass {}

// 명시적인 접근 레벨을 명시하지 않은 함수는 컴파일 시 에러 발생
func somFunction() -> (SomeInternalClass, somePrivateClass){
    return (SomeInternalClass(), somePrivateClass())
}

// private으로 접근 레벨을 명시하여 컴파일 에러 제거
private func somFunction() -> (SomeInternalClass, somePrivateClass){
    return (SomeInternalClass(), somePrivateClass())
}
```

<br>
<br>

### 열거형 + 접근제어
- ##### 열거형은 case에서 엑세스 수준을 선언할 수 없다. 무조건 Enum자체를 선언할 때 접근수준을 선언해야한다.
```Swift
private enum 방위 {
  case 동, 서, 남, 북
}

//위에 enum이 private이기 때문에 여기서 선언할때도 private라고 선언해줘야함
private let enumeration = 방위.남 
```

<br>
<br>

### 상수, 변수 + 접근제어
- ##### 상수, 변수, 프로퍼티 등은 그 타입보다 더 높은 접근레벨을 갖을 수 없습니다.
- ##### 즉, private타입에서 public프로퍼티를 선언할 수 없습니다.
- ##### 상수, 변수, 프로퍼티 그리고 서브스크립트의 게터와 세터는 자동으로 해당 상수, 변수, 프로퍼티 그리고 서브스크립트가 갖는 접근레벨을 동일하게 갖습니다. 
- ##### 필요에 따라 세터의 접근레벨을 게터보다 낮게 정할 수 있습니다. 이를 위해 다음 키워드를 var혹은 subscript앞에 붙여 사용합니다. 
- ##### 키워드 예시 ) fileprivate(set), private(set), internal(set)
```Swift
private class SomePrivateClass {}

// 컴파일 에러 미발생
private var privateInstance = SomePrivateClass()

// 컴파일 에러 발생
public var privateInstance = SomePrivateClass()
```

<br>
<br>

### 중첩 타입 + 접근제어
- ##### 타입 내에서 정의된 중첩 타입은 자동으로 타입의 접근 레벨을 따릅니다.
- ##### 하지만 open, public타입 또는 internal타입에 정의 된 중첩 타입은 자동으로 internal 접근레벨을 가집니다.
```Swift
open class SomeOpenClass{
  public init() {}
  struct myStruct{ // 자동으로 Internal의 접근레벨 부여
    var name: String
  }
}
```

<br>
<br>

### Getters and Setters
- ##### 상수, 변수 프로퍼티 및 서브스크립트에 대한 getter, setter는 자동으로 상수, 변수, 프로퍼티 및 서브스크립트에 속한것과 동일한 접근 수준을 받습니다.
```Swift
// 접근 수준을 명시하지않았으므로 internal을 가짐
struct TrackedString{
  // 같은 모듈 안에서 get은 가능하지만 set은 불가능하다.
  //  set은 TrackedString 내에서만 가능하다.
  private(set) var numberOfEdits = 0

  // value 저장 프로퍼티의 값이 바뀌면 바뀐 직후 numberOfEdits가 1 증가한다.
  var value: String = "" {
    didSet{
      numberOfEdits += 1
    }
  }
}

var trackedString = TrackedString()

// get은 가능
print(trackedString.numberOfEdits)

// set은 private으로 설정해놨기때문에 불가능
trackedString.numberOfEdits = 10 //Error! Cannot assign to property: 'numberOfEdits' setter is inaccessible
```

###### 그럼 접근수준을 public으로 명시한다면?
```Swift
public struct TrackedString{
  public private(set) var numberOfEdits = 0
    
    public var value: String = "" {
      didSet {
        numberOfEdits += 1
      }
    }

    public init() {}
}

// 외부 모듈
var trackedString = TrackedString()

trackedString.value = "Youjin"

// set은 private으로 설정해놨기때문에 불가능
trackedString.numberOfEdits = 10 //Error! Cannot assign to property: 'numberOfEdits' setter is inaccessible
```

- ###### setter가 getter보다 더 높은 접근 수준을 가질 수 없습니다.
```Swift
 private internal(set) var numberOfEdits = 0 //Error!
```

<br>
<br>

### initializers(초기화) + 접근제어
> ##### 사용자 정의 이니셜라이저는 이니셜라이저 하는 타입보다 더 작거나 같은 접근 수준을 지정할 수 있습니다.
> ##### 유일한 예외는 required intializers입니다. required intializers는 자신이 속한 클래스와 동일한 접근 수준을 가져야 합니다.
<br>

- ##### default initializers
###### 기본 이니셜라이저는 해당 타입이 public으로 정의되어있지 않으면, 초기화 하는 타입과 동일한 접근 수준을 가집니다. 하지만 public으로 정의된 타입의 경우, 기본 이니셜라이저는 Internal로 간주됩니다.
###### 다른 모듈에서 사용할 때, 파라미터가 없는 이니셜라이저로 초기화 할 수 있게 하려면, 타입 정의 부분에서 일부로 public 이니셜라이저를 명시적으로 제공해야합니다.

<br>

- ##### memberwise initializers
###### 구조체의 저장프로퍼티 중 하나라도 private인 경우, 구조체의 memberwise 이니셜라이저는 private로 간주됩니다. 마찬가지로, 구조체의 저장 프로퍼티 중 하나라도 file-private인 경우, 이니셜라이저는 file-private입니다. 그렇지 않으면 이니셜라이저의 기본 접근 수준은 internal입니다.
###### 위의 기본 이니셜라이저에서와 같이, public 구조체 타입을 다른 모듈에서 사용할 때, memberwise intializer로 초기화하려면, 해당 타입 정의 부분에서 public memberwise initializer를 직접 제공해야합니다.

<br>

### Protocols + 접근제어
> ###### 프로토콜을 정의하는 시점에 접근 수준을 지정하면 특정 접근 컨텍스트 내에서만 채택할 수 있는 프로토콜을 만들 수 있습니다.
> ###### 프로토콜은 정의 내의 객체들에 대한 접근 수준은 프로토콜과 동일한 접근 수준으로 자동 설정됩니다. 프로토콜과 다른 접근 수준으로 설정할 수는 없습니다. 
```Swift
private protocol myProtocol{
  // 이렇게 됐을 때, hello()는 반드시 private입니다. 다른 접근 수준을 지정하면 오류가 발생합니다.
  func hello()
}
```
```Swift
internal protocol myProtocol{
  // 이렇게 됐을 때, someMethod는 internal입니다.
    func someMethod()
}

public class MyClass : myProtocol{
    public init(){}

  // 여기서 someMethod는 myProtocol이 internal이므로, internal, public, open 까지만 접근수준을 지정할 수 있다.
    func someMethod() {
    }
}
```

<br>
<br>

#### 참고자료
- ###### https://zeddios.tistory.com/389