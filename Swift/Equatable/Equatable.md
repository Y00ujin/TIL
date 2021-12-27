## Equatable

<br>

### Equatable이란?
- ##### Equatable은 Protocol이다.
- ##### 값이 도일한 지 어떤지를 비교할 수 있는 타입
- ##### Equatable 프로토콜은 어떤 "타입"이 채택할 수 있고 준수하는 타입은 등호 연산자(==) 또는 같지 않음 연산자(!=)를 사용하여 동등성을 비교할 수 있습니다.
- ##### Swift 표준 라이브러리의 대부분 기본 데이터타입은 Equatable을 따릅니다.
- ##### Int, String, Double, Bool, Float 등 기본 데이터 타입들은 모두 Equatable을 따르고 있기때문에 동등성을 비교할 수 있다.

### Equatable 사용하기
- ##### 기본 데이터 타입 비교하기 (이미 Equatable을 따르는 타입) 
```Swift
var some = 1
var other = 2
// 기본 데이터 타입은 Equatable Protocol을 따르기 때문에 동등성 비교 가(==, != 사용 가능)
if some == other{
    // 동등성 비교
}else if some != other{
    // 동등성 비교
}
```

- ##### 인스턴스 비교하기 (Equatable을 따르지않는 타입)
###### Class는 Equatable을 채택하지 않았기 때문에 ==을 사용하면 error가 남
```Swift
class A{
    var aNum : Int
    init(_ aNum :Int) {
        self.aNum = aNum
    }
}

if A(1) == A(2) //error!
{
}
``` 
###### 동등성을 비교하려면 아래와 같이 Equatable을 채택해야한다.
```Swift
class A : Equatable {
    var aNum : Int
    init(_ aNum :Int) {
        self.aNum = aNum
    }
}
```
###### Equatable을 채택하면 오류가 뜬다..! 왜냐면 Equatable 프로토콜을 준수하고 있지 않기 때문이다
###### Equatable 사용시에는 == 을 무조건 정의 해주어야 한다.
```Swift
class A: Equatable{
    var aNum: Int

    init(_ aNum: Int){
        self.aNum = aNum
    }

    // 이 메소드를 추가해주고,  Self를 Class명으로 변경해주고 return 값을 설정해주자
    // public static func == (lhs: Self, rhs: Self) -> Bool{}
    public static func == (lhs: A, rhs: A) -> Bool{
        return lhs.aNum == rhs.aNum
    }
}

if A(1) == A(2){
    print("same")
}else{
    print("different")
}
// different 출력!
```