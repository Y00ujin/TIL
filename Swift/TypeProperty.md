## Type Property

<br>
<br>

### Type Property란?
- ##### 각각의 인스턴스가 아닌 타입 자체에 속하게 되는 프로퍼티
- ##### 타입 프로퍼티는 타입 자체에 영향을 미치는 프로퍼티이다.
- ##### 인스턴스의 생성 여부와 상관없이 타입 프로퍼티의 값은 하나이다.
- ##### 타입 프로퍼티는 그 타입에 모든 인스턴스가 공통으로 사용되는 값이라든지, 모든 인스턴스에서 공용으로 접근하고 값을 변경할 수 있는 변수 등을 정의할 때 유용하다.

<br>
<br>

### Type Property 사용하기
```Swift
class Aclass {
    // 저장 프로퍼티
    static var typeProperty: Int = 0
    
    var instanceProperty: Int = 0 {
        didSet {
            Aclass.typeProperty = instanceProperty + 100
        }
    }
    
    // 연산 타입 프로퍼티
    static var typeComputedProperty: Int {
        get {
            return typeProperty
        }
        
        set {
            typeProperty = newValue
        }
    }
}

// 타입 프로퍼티는 인스턴스 생성 없이 바로 타입을 통해 접근할 수 있다.
Aclass.typeProperty = 123

// 인스턴스 프로퍼티는 인스턴스를 통해 접근해야한다.
let classInstance: Aclass = Aclass()
classInstance.instanceProperty = 100

print(Aclass.typeProperty)  // 200
print(Aclass.typeComputedProperty)  // 200
```