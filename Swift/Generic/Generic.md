## Generic

<br>

### Generic이란?
- ##### 타입에 의존하지 않는 범용 코드를 작성할 때 사용한다.
- ##### 제네릭을 사용하면 중복을 피하고, 타입에 유연하게 대처하는 것이 가능해진다.
- ##### 제네릭의 예시로는 Array, Dictionary, Set 등이 있다.

<br>

### 제네릭 함수(Generic Function) 사용하기
###### 인자로 오는 두 Int의 값을 Swap하는 함수를 만들어보자
###### 이 함수의 파라미터 타입이 Int, Int라면 상관없겠지만 Double, Double이라면 이 swap함수를 사용하지 못한다.
```Swift
func swap(_ a: inout Int, _ b: inout Int){
    let tempA = a
    a = b
    b = tempA
}
```
###### 이렇게 Double을 인자로 받는 함수를 따로 만들어줘야 사용할 수있다.
```Swift
func doubleSwap(_ a: inout Double, _ b: inout double){
    let tempA = a
    a = b
    b = tempA
}
```
###### 이럴 때 사용하는 것이 바로 제네릭이다. 타입에 제한을 두지 않는 코드를 사용하고 싶을 때 제네릭을 사용한다.
- ##### 꺽새(<>)를 이용해서 안에 타입의 이름을 설정해준다. 아래에서는 T로 설정하였다. 꺽새로 묶어준 이유는 Swift에게 "T"라는 것이 타입이 아닌 이름인 것을 알리기 위함이다. (그래서 Swift는 T라는 실제 타입을 찾지 않음)
- ##### 이 T에 Int면 Int, Double이면 Double이 들어오는 것이다. 
- ##### T를 Type Parameter라고 부른다. 타입을 받는 거니까..
```Swift
funcc swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let tempA = a
    a = b
    b = tempA
}
```

###### 위의 제네릭 함수를 사용하면 이렇게 실제 함수를 호출할 때 Type Parameter인 T의 타입이 결정된다.
```Swift
var someInt = 1
var aotherInt = 2
swapTwoValues(&someInt,  &aotherInt)          // 함수 호출 시 T는 Int 타입으로 결정됨
 
var someString = "Hi"
var aotherString = "Bye"
swapTwoValues(&someString, &aotherString)     // 함수 호출 시 T는 String 타입으로 결정됨
```

###### 여기서 파라미터 a,b 모두 같은 타입 파라미터인 T로 선언되어있기 때문에 다른 타입을 파라미터로 전달하면 오류가 발생한다.
```Swift
// 첫번째 someInt를 통해 타입 파라미터 T가 Int로 결정되었는데 anotherString이 T 즉 Int 형식에 String을 넣으려고 하니까 에러가 발생함
swapTwoValues(&someInt, &anotherString)       // Cannot convert value of type 'String' to expected argument type 'Int'
```

###### 위와같이 다양한 타입의 파라미터를 받고싶으면 이렇게 타입 파라미터를 여러개 선언해도 된다.
###### 그런데 타입 파라미터 이름을 선언할 땐 보통 가독성을 위해 T나 V같은 단일 문자, 혹은 Upper Camel Case를 사용한다.
```Swift
func swapTwoValues<One, Two> { ... }
```

<br>

### 제네릭 타입(Generic Type) 사용하기
###### 제네릭은 함수에만 가능한 것이 아니라, 구조체, 클래스, 열거형 타입에도 선언할 수 있는데, 이것을 제네릭 타입이라고 한다.
- #### 1. Struct 제네릭으로 만들기
```Swift
struct Stack<T>{
    let items: [T] = []

    mutating func posh(_ item: T) { ... }
    mutating func pop() -> T { ... }
}

// 제네릭 타입의 인스턴스 생성
// <>를 통해 어떤 타입으로 사용할 것인지를 명시해줘야 함
let stack1: Stack<Int> = .init()
let stack2: Stack<Int>.init()
```
- #### 2. Class 제네릭으로 만들기


<br>

### 타입 파라미터에 제약주기
> ##### 타입제약을 통해 타입 파라미터가 특정 클래스로부터 상속되거나, 특정 프로토콜을 준수해야만 Generic함수를 쓸 수 있도록 제약을 줄 수 있습니다.
- #### 1. 타입 파라미터에 프로토콜 제약주기
###### 파라미터로 두 개의 값을 받아서 두 값이 같으면 true, 다르면 false를 반환하는 함수를 제네릭으로 선언했다.
###### == 이란 연산자는 a와 b의 타입이 Equatable이란 프로토콜을 준수할 때만 사용할 수 있는데 타입 파라미터 T가 Equatable을 준수하는 타입인지 알지도 못하면서 == 를 쓰면 어떡하냐고 오류가 남;;
```Swift
func isSameValues<T>(_ a: T, _b: T) -> Bool{
    return a == b // 에러 발생 : Binary operator '==' cannot be applied to two 'T' operands
}
```

###### 따라서 이땐 타입 파라미터 T에 Equatable을 준수하는 타입만 들어오라고 제약을 걸어줄 수 있음
###### 이렇게 하면, isSamveVlaues란 함수에 들어올 수 있는 파라미터는 Equatable이란 프로토콜을 준수하는 파라미터만 받을 수 있음
```Swift
func isSameValues<T: Equatable>(_ a: T, _ b: T) -> Bool {
    return a == b
}
```
- #### 타입 파라미터에 클래스 제약주기
###### Human클래스의 인스턴스와 Human 클래스를 상속 받은 teacher은 printName이라는 제네릭 함수를 실행시킬 수 있지만, Human 클래스의 서브 클래스가 아닌 bird 인스턴스는 실행할 수 없음
```Swift
class Bird {}
class Human {}
class Teacher: Human {}

func printName<T: Human>(_ a: T) {}

let bird = Bird.init()
let human = Human.init()
let teacher = Teacher.init()
 
printName(bird)                  // Global function 'printName' requires that 'Bird' inherit from 'Human'
printName(human)
printName(teacher)
```

<br>

### 제네릭 확장하기
###### 제네릭 타입인 Array를 확장하고싶다면 어떻게 해야할까?
```Swift
extension Array{
    // 만약 제네릭 타입을 확장하면서 타입 파라미터를 사용할 경우, 실제 Array 구현부에서 타입 파라미터가 Element로 이름지어져있기때문에 Element로 사용해야한다.
    // 확장에서 새로운 제네릭을 선언하거나, 다른 타입 파라미터를 사용하는 것은 불가능하다.
    mutating func pop() -> Element{
        return self.removeLast()
    }
}
```
###### where을 통해 확장 또한 제약을 줄 수 있다.
```Swift
extension Array where Element: FixedWidthInteger{
    mutating func pop() -> Element{
        return self.removeLast()
    }
}
```

###### 위와같이 Element라는 타입 파라미터가 FixedWidthInteger라는 프로토콜을 준수해야한다라는 제약을 주면
###### FixedWidthInteger 프로토콜을 준수하는 Array<Int>형인 nums는 extension에서 구현된 pop이란 메서드를 사용할 수 있지만,
###### FixedWidthInteger 프로토콜을 준수하지 않는 Array<String> 형인 strs는 extension에서 구현된 pop이란 메서드를 사용할 수 없다.
```Swift
let nums = [1, 2, 3]
let strs = ["a", "b", "c"]
 
nums.pop()              // O
strs.pop()              // X
```

<br>

### 제네릭 함수와 오버로딩
###### 아래와 같이 함수명은 동일하게 설정하고 제네릭 함수 하나, Int타입 a,b를 인자로 받는 함수 하나 생성한다.
```Swift
func swapValues<T>(_ a: inout T, _ b: inout T) {
    print("generic func")
    let tempA = a
    a = b
    b = tempA
}
 
func swapValues(_ a: inout Int, _ b: inout Int) {
    print("specialized func")
    let tempA = a
    a = b
    b = tempA
}
```
###### 위와 같이 함수를 생성하면 Int로 타입이 지정된 함수가 제네릭 함수보다 우선순위가 높다.
###### Int타입으로 swapValue를 실행할 경우 우선순위가 높은 Int로 타입이 지정된 함수가 실행된다.
###### Int외 다른 타입으로 swapValue를 실행할 경우 제네릭 함수가 실행된다.
```Swift

var a = 1
var b = 2
swapValues(&a, &b)          //"specialized func"
 
 
var c = "Hi"
var d = "Sodeul!"
swapValues(&c, &d)          //"generic func"
```


<br>

<br>

#### 참고자료
- ###### https://babbab2.tistory.com/136
- ###### https://zeddios.tistory.com/226
- ######
- ######
- ######
