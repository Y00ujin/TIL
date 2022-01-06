## Printable

<br>

### Printable이란?
- ##### 이름대로 인쇄 가능하게, 단순하게 말해서 오브젝트를 문자열로 바꾸는 기능을 제공하는 프로토콜이다.
- ##### Printable은 특정 프로퍼티를 구현하는 식으로 동작한다.

<br>

### Printable 사용하기
###### 
```Swift
struct MyType: Printable{
    var value: Int = 0

    // String 프로퍼티의 getter가 Printable의 핵심이자 전부라고 봐도 된다.
    var description: String{
        return "MyType.value = \(value)"
    }
}

let v3 = MyType(value: 50)
```