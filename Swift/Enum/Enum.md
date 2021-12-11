# Enum

### Enum?
- ##### “열거”타입은 `임의의 관계를 맺는 값`들을 `하나의 타입으로 묶어서` 타입-안전한 방식으로 다룰 수 있게 해준다.
- ##### `유사한 종류의 여러값`을 유의미한 이름으로 `한곳에 모아 정의한 것`

<br>

### Enum 구현법?
```Swift
enum Animal {
    case tiger
    case leopard
    case lion
}

    // 두개는 같은 것, Animal이라고 명시했으므로 Animal.tiger로 접근하지않고 바로 .lion으로 접근해도 돼!
    let tiger2: Animal = Animal.tiger
    let lion2: Animal = .lion

    // 이름 그 자체로 값을 가짐
    print(tiger2) // tiger
    print(lion2) // lion
```

<br>

### Enum + 원시값?
```Swift

enum Animal : Int {
    // 각 case에 원시값을 줄 수 있음 모두 같은 타입이어야 함
    // case 일부에 원시값이 들어가지 않았다면 자동증가하여 원시값이 적용됨(정수만!)
    // tiger = 0 / leopard = 1 / lion = 2
    case tiger = 0
    case leopard
    case lion
}
```

<br>

### Enum + Optional?
```Swift

enum Animal : Int {
    // 각 case에 원시값을 줄 수 있음 모두 같은 타입이어야 함
    // case 일부에 원시값이 들어가지 않았다면 자동증가하여 원시값이 적용됨(정수만!)
    // tiger = 0 / leopard = 1 / lion = 2
    case tiger = 0
    case leopard
    case lion
}

print(Animal(rawValue: 4)) // 원시값이 4인 case 출력인데 원시값이 4인 case가 없다..! 
// 고로 전달한 원시값에 해당하는 케이스가 없을 수 있기 때문에 원시값을 통한 인스턴스 생성은 옵셔널값으로 반환된다.

// 결과적으로 nil이 출력되게 된다.

```

<br>

#### 참고자료
- ###### https://zeddios.tistory.com/12
- ###### https://soooprmx.com/enum/