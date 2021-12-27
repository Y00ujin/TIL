# Subscript

<br>

### Subscript란?
- ##### 콜렉션, 리스트, 시퀀스 등 집합의 특정 member elements에 간단하게 접근할 수 있는 문법
- ##### 컬렉션, 리스트, 시퀀스 타입의 개별 요소에 접근할 수 있는 지름길을 제공하는 것.
- ##### 추가적인 메소드 없이 특정 값을 할당하거나 가져올 수 있다.
- ##### Ex.) array[index]로 배열의 인스턴스 항목과 dictionary[key]로 딕셔너리 인스턴스 항목에 접근하는 것
- ##### 단일 타입에 여러 서브스크립트를 정의할 수 있다 (서브스크립트 중복 정의)
- ##### 파라미터나 리턴형을 생략할 수 없고, getter와 setter모두 구현할 수 있다.
- ##### get-only는 가능하지만, set-only는 불가능하다(setter생략 불가)


<br>

### 다양한 타입에서의 Subcript
- ##### Array에서의 Subscript
```Swift
let array = [1, 2, 3]

// array 가 서브스크립트 문법을 구현하지도 않았는데 사용할 수 있는 이유는 
// 스위프트 표준 라이브러리에 정의된 array 구조체 내부에 서브스크립트가 이미 구현되어 있기 때문
// 배열의 서브스크립트는 parameter로 Int형을 index로 받고, 해당 index에 해당하는 Element를 반환하는 형태
array[0] // Subscript 사용! ( -> [0] )
```

- ##### Dictionary에서의 Subscript
###### 배열와 마찬가지로 [] 이것이 서브스크립트임
###### Dictionary의 서브스크립트는 Parameter로 Key를 받고, 해당 Key에 해당하는 Value를 반환하는 형태임
```Swift
let dict: [String: Int] = ["one": 1, "two": 2]
 
dict["one"]             // 1
dict["two"]             // 2
```

- ##### 구조체에서의 Subcript
###### Stack이란 구조체에서 서브스크립트를 아래처럼 구현했을 경우 []를 통해 getter / setter에 접근할 수 있음
```Swift
struct Stack{
    var stack: [Int] = [0, 1, 2, 3, 4, 5]

    subscript(index: Int) -> Int{
        get{
            return Stack[index]
        }
        set{
            stack[index] = newValue
        }
    }
}

var stack: Stack = .init()

stack[0]     // subscript getter 접근
stack[1] = 2 // subscript setter 접근
```

<br>

### 서브스크립트 직접 사용해보기
- ##### 서브스크립트 정의
###### Subcript키워드로 작성하며 하나 이상의 파라미터와 반환 값을 지정한다.
###### sertter의 경우 파라미터를 생략하면 newValue로 접근할 수 있고, get-only일 경우 get 구문을 생략 가능하다(연산 프로퍼티와 비슷함)
```Swift
subcript(index: Int) -> Int{
    get{

    }set(newValue){

    }
}
```
###### 아래와 같이 String을 확장하여 서브스크립트를 작성해주면 []를 통해 내가 원하는 index의 문자에 접근할 수 있음
```Swift
extension String{
    subcript(idx: Int) -> String?{
        guard (0..<count).contains(idx) else{
            return nil
        }
        let target = index(startIndex, ofsetBy: idx)
        return String(self[target])
    }
}


let sodeul = "Hello, Sodeul!"
sodeul[0]           // Optional("H")
sodeul[100]         // nil
```
###### 서브스크립트는 파라미터 선언 당시 Argument Label을 _로 처리해주지 않아도 Argument Label로 사용되지 않음
```Swift
subscript(index: Int) -> Int{ // 이렇게 _없이 선언해도
    get{
        
    }set(newValue){

    }
}

Type[2] // 이렇게 Argument Label이 없다.
```
###### 굳이 Argument Label을 쓰고싶다면 이렇게
```Swift

subscript(index index: Int) -> Int {
    get {
    }
    set(newValue) {
    }
}

Type[index: 3]
```

<br>

### 타입 서브스크립트
###### 타입 프로퍼티, 타입 메서드에서 공부했듯이 서브스크립트 또한 타입 서브스크립트로 선언이 가능함
###### 오버라이딩이 불가하다면 static, 가능하다면 class로 선언해주면 타입 서브스크립트가 되는 것
```Swift
struct Stack {
    static var stack: [Int] = [0, 1, 2, 3]
 
    static subscript(index: Int) -> Int {
        return stack[index]
    }
}
// 실제로, 인스턴스 없이 타입 이름에서 Element에 접근이 가능
Stack[0]        // 0
Stack[1]        // 1
```

#### 참고자료
- ###### https://the-brain-of-sic2.tistory.com/37
- ###### https://medium.com/@jgj455/%EC%98%A4%EB%8A%98%EC%9D%98-swift-%EC%83%81%EC%8B%9D-subscript-2288551588f9
- ###### https://babbab2.tistory.com/123
- ###### https://velog.io/@zooneon/Swift-%EC%84%9C%EB%B8%8C%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%97%90-%EB%8C%80%ED%95%B4-%EC%95%8C%EC%95%84%EB%B3%B4%EC%9E%90
