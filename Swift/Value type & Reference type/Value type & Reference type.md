## **Value type & Reference type**

- ##### ```Value type & Reference type``` 공부해보기 with Youjin 👩🏻‍💻

<br>

<img width="1578" alt="스크린샷 2021-11-09 오전 8 50 00" src="https://user-images.githubusercontent.com/71479613/140836351-6ae6167a-7973-4d48-a113-17c574b088ca.png">

<br>

### Value type, 값 타입 ?
- ###### `Structure`, `Enumeration`, `Tuple`

> ###### 아래와 같이 변수를 할당하면 스택 영역에 값이 저장된다.
> ###### 값이 복사되고, 새로운 인스턴스가 생성된다.
```swift
// Value Type
var testStruct = testStruct()

/* 별개의 새로운 인스턴스가 생성되어 값이 복사됨 */
var anotherStruct = value1

anotherStruct.name = "John Doe"
anotherStruct.age = 10 // testStruct.name: "", testStruct.age: 0 
```
- ##### 값 타입인 struct 의 경우, stack 영역에 실제 데이터가 저장됩니다. 그렇기 때문에 값을 전달 시 실제 데이터가 복사됩니다.

<br>

### Reference type, 참조 타입 ?
- ###### `Class`, `Closure`

> ###### 참조 타입인 class의 경우, heap 영역에 실제 데이터가 저장되고, stack 영역에는 heap 영역 메모리 주소가 저장됩니다.
```swift
// Reference Type
var testClass = testClass()

/* 주소 값만 복사되므로, 같은 인스턴스를 가리킴 */
var anotherClass = ref1

anotherClass.name = "Jane Doe"
anotherClass.age = 17 // testClass.name: "Jane Doe", testClass.age: 17 
```
- ##### 그렇기 때문에 값의 전달은 인스턴스가 위치한 실제 주소(= heap 영역의 주소)의 복사이며, 결과적으로 아래 코드에서  ref2는 ref1의 참조를 얻습니다. ( Retain Count는 1 증가 )

<br>

##### 참고
- ###### https://woozzang.tistory.com/29
- ###### https://devmjun.github.io/archive/Swift-StructVSClass
- ###### https://local-dev.tistory.com/entry/Swift-Class-Struct%ED%81%B4%EB%9E%98%EC%8A%A4%EC%99%80-%EA%B5%AC%EC%A1%B0%EC%B2%B4