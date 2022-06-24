## Hashable

<br>

### Hashable이란?
- ##### 프로토콜이다.
- ##### 정수 Hash 값을 제공하는 타입이다.
```Swift
// Hashable Protocol은 Equatable Protocol을 상속받고있다.
// Equatable을 상속받고 있는 이유는 해쉬값을 생성하려면 key가 필요하고 그 key는 유니크해야하기 때문에 유니크한지 검사하기 위해 ==함수가 필요한데 ==함수를 사용하려면 Equatable을 채택해야 한다.

protocol Hashable: Equatable{
    var hashValue: Int{get}
    func hash(into hasher: inout Hasher)
}
```

<br>

### Hash Value란?
###### 원본 데이터 (객체)를 해쉬 삼수를 사용하여 64bit의 Int값으로 변환한 것이다.
- ##### 즉, 같은 타입의 인스턴스인 a와 b의 경우 a==b이면 a.hashvalue == b.hashvalue가 된다는 것을 의미한다. 그러나 반대의 경우에는 true가 아닐 수도 있다. 동일한 hash값을 가진 두개의 인스턴스가 서로 동일할 필요는 없기 때문이다.
- ##### hash 값은 프로그램 실행에 따라 동일하지 않을 수 있다. 향후 실행에 사용할 hash값을 저장하지 않아야 한다

```Swift
let hi: String = "안녕하세요"
let hello: String = "안녕하세요"
var youjin: String = "내 이름은 김유진이다."

print(hi.hashValue)    // 2897817589225975386 - 해쉬값
print(hello.hashValue) // 2897817589225975386
print(youjin.hashValue) // 1147360803777020165
```

<br>

### Hashable 해야 한다는 것은 무슨 뜻일까?
###### Hashable 해야한 다는 것은 Hashable Protocol을 준수한다는 의미다.
###### Hashable한 타입의 데이터는 해쉬값(hash value)를 구할 수 있다.
- ##### Hashable Protocol을 준수하는 타입의 예시를 보자
###### 사용자 정의 타입인 구조체 Drink는 원래 인스턴스끼리 == 연산자로 비교할 수 없다. 하지만 구조체가 Hashable Protocol을 준수하도록 변경하면, 비교가 가능하다.
###### Hashable Protocol을 준수하므로 hashValue 프로퍼티를 통해 해쉬값을 확인할 수 있다. (lomonade.hasValue)
###### 서로 다른 인스턴스인 lemonade 및 appleCider의 해쉬값이 서로 다르다.
```Swift
struct Drink: Hashable{
    let name: String
    let mainIngredient: String
    let alchol: Double
}

struct RandomDate: Hashable{
    let string1: String
    let string2: String
    let double1: Double
}

let lomonade = Drink(name: "lemonade", mainIngredient: "lemon", alchol: "0.0")
let appleCider = Drink(name: "appleCider", mainIngredient:"apple", alchol: 5.0)

// Hashable Protocol은 Equatable Protocol을 준수한다.
// Drink 구조체가 Hashable Protocol을 준수하므로 두 인스턴스의 동등성을 비교할 수 있다.
if lemonade == appleCider{ 
    print("Drinks are the same, because their hash values \(lemonade.hashValue) and \(appleCider.hashValue) are the same.")
} else {
    print("Drinks are different, because their hash values \(lemonade.hashValue) and \(appleCider.hashValue) are different.")
}

// "Drinks are different, because their hash values 498791461213300727 and 8360371392129835764 are different." 출력 - 다른 인스턴스이며, 서로 다른 해쉬값을 가진다.
// 주의 - 컴파일 할 때마다 모든 해쉬값이 변경된다.

let randomData = RandomData(string1: "appleCider", string2: "apple", double1: 5.0)
print(appleCider.hashValue) // 8360371392129835764
print(randomData.hashValue) // 8360371392129835764
// 다른 객체이지만, 동일한 해쉬값을 가진다. - 해쉬값 충돌
```

<br>

### Hashable 한 타입, 해쉬값은 어디에 사용할까?
- ##### Swift에서 Set 타입의 값, Dictionary 타입의 Key는 Hashable해야한다.
###### Swift의 기본타입인 String Int 등은 자동으로 Hashable하다.
###### 열거형(Enum)이 연관값 (associated value)을 가지지 않으면, 자동으로 Hashable하다.
###### String은 Hashable하므로 Set에 담을 수 있다. 그리고 사용자 정의 타입을 Hashable하도록 설정하면, Set의 값에 해당 타입을 담을 수 있다.

<br>

### Hashable하지 않은 타입을 Hashable하게 만드는 방법
> ##### 1. == :  hashValue는 고유한 값이여야 하기 때문에 고유값인지 식별해줄 수 있는 == 함수가 필요 (Equatable에 ==함수 존재)
> ##### 2. hashValue 생성 (그런데 프로토콜을 준수하면 4.1버전부터는 프로토콜을 준수만 해도 내부적으로 HashValue를 만들어 줌 = 안만들어도 됨)
- ##### Struct를 Hashable하게 만드는 법
###### 스위프트 4.1 이전에는 Hashable 프로토콜을 준수하기 위해서는 hashValue 값과 == 연산자를 직접 구현해왔다.
###### 하지만 스위프트 4.1부터는 구조체와 열거형에 대해서는 컴파일러가 이를 자동으로 구현해준다. 따라서 Hashable만 채택하면 된다.
```Swift
struct GridPoint: Hashable{
    var x = Int
    var y = Int
}

var zehyeSet = Set<GridPoint>()
var zehyeDict: [GridPoint: Int] = [:]
```
- ##### Class를 Hashable하게 만드는 방법
###### 클래스에 대해서는 컴파일러가 자동으로 구현해주지 않기 때문에 사용자가 위의 코드처럼 직접 구현해주어야 합니다.
```Swift
class Resolution: Hashable {
    var horizontal: Int
    var vertical: Int
    
    func hash(into hasher: inout Hasher) { // 직접 hashValue를 생성하지않고 hash 함수를 활용한다.
        hasher.combine(horizontal)
        hasher.combine(vertical)
    }
    
    init(horizontal: Int, vertical: Int) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    static func == (lhs: Resolution, rhs: Resolution) -> Bool {
       return lhs.vertical  ==  rhs.vertical && lhs.horizontal  == rhs.vertical
    }
}
```


#### 참고자료
- ###### https://applecider2020.tistory.com/14
- ###### https://optboy.github.io/programming/2020/03/08/hash.html
- ###### https://www.zehye.kr/swift/2020/07/22/swift_hashable/
- ###### https://woongsios.tistory.com/145
- ###### https://baked-corn.tistory.com/123