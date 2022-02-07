## Core Data

<br>
<br>

### Core Data란?
- ##### 앱에 영구적인 데이터를 저장하기 위해 사용되는 프레임워크
- ##### ORM의 개념을 추상화한 것으로 DB를 직접 관리하지 않아도 Swift 및 Objective-C의 데이터를 쉽게 저장할 수 있다.
- ##### 보통의 데이터베이스들과는 다르게 in-memory 형태로 사용이 가능하다.
- ##### 코어데이터는 데이터베이스가 아니며 코어데이터의 기능 중 하나인 Persistence가 관계형 데이터베이스인 SQLite에 의해 지원되는 것이다. 즉 persistence는 Core Data의 기능 중 하나 일 뿐, Core Data == Database는 아니다.
- ##### 코어데이터는 애플리케이션의 모델 계층의 객체를 관리하는데 사용하는 프레임워크이자 객체의 라이프 사이클이나 영속성 관리를 위한 기능을 제공하는 객체 그래프 관리자이다.

<br>
<br>

### Core Data를 이해하기 위해 필요한 정보들
- #### ORM이란?
> ##### 객체와 관계형 데이터베이스의 데이터를 자동으로 매핑(연결)해주는 것을 말한다.
###### 말 그대로 OOP에서 쓰이는 클래스와 RDB에서 쓰이는 테이블을 자동으로 연결하는 것을 의미한다. 그러나 클래스와 테이블은 서로 호환가능성을 두고 만들어진 것이 아니기 때문에 불일치가 발생하는데, 이를 ORM을 통해 객체 간의 관계를 바탕으로 SQL문을 자동으로 생성하여 불일치를 해결한다.
###### 따라서 ORM을 사용하면 따로 SQL문을 짤 필요없이 객체를 통해 간접적으로 데이터베이스를 조작할 수 있게 된다.

<br>

- #### in-memory란?
> ##### 디스크에 저장하지 않고 휘발성으로 테스트 같이 잠깐 이용하려고 하는 경우
###### in memory 방식은 disk-based와 달리 메모리에 데이터를 저장한다. 외부 저장 장치에 데이터를 저장하지 않고 메모리에서 데이터를 읽고 쓴다. 메모리와 디스크 간 병목이 없기 때문에 disk-based 방식보다 훨씬 속도가 빠르다.

<br>

- #### 객체 그래프 관리자란?
> ##### 파일 형태로 저장되어 있는 데이터를 지정된 객체와 연결해주는 것을 의미한다. CoreData를 사용하면 데이터를 읽어왔을 때 그 결과가 객체의 형태를 띄고, 객체의 속성을 수정함으로써 그대로 다시 데이터를 저장할 수 있다.
###### 코어데이터는 여러 relationship으로 엮어있는 형태를 코어데이터의 컨테이너에 저장시킨다.

<br>
<br>

### CoreData의 구성
- ##### 코어데이터는 관리 객체, 관리 객체 컨텍스트, 영구 저장소 코디네이터, 영구 객체 저장소, 관리 객체 모델로 구성되어있다.
- ##### CoreData의 흐름은 다음과 같다.
###### Context가 데이터 요청 - 코디네이터가 요청을 받고 영구 저장소에서 데이터 탐색 - 코디네이터가 Managed Object 인스턴스를 생성하여 데이터 반환 

<br>

- #### 1. 관리 객체(Managed Object) : NSManagedOBject
> ###### https://developer.apple.com/documentation/coredata/nsmanagedobject
##### 테이블에서 값들을 읽을 때 코어데이터에서는 객체가 생성되는데, 잉 객체를 저장하는 자료형이 NSManagedObject이다.
##### Managed Object Model의 인스턴스이다.
##### ex) DB에 저장된 직원들의 정보를 읽어오면 이것을 그대로 사용하지 않고 `Value Object` 인스턴스에 담아 사용하는데 이때 `VO`는 `NSManagedObject`타입으로 관리 객체에 해당한다.

<br>

- #### 2. 관리 객체 컨텍스트(Managed Object Context) : NSManagedOBjectContext
> ###### https://developer.apple.com/documentation/coredata/nsmanagedobjectcontext
##### `NSManagedObjectContext`는 DB를 대표하며 모든 코어데이터 활동이 이루어지는 허브와도 같은 곳이다. 코드로 이 context에 접근하기 위해선 `NSPersistentContainer`가 필요하다.
<br>

##### `viewContext`는 `NSManagedObjectContext`중에서도 메인 스레드에서만 사용할 수 있는 변수이다. 메인큐에서만 사용되는 이 변수의 이름이 `viewContext`인 이유는 `UIView`와 함께 사용되기 때문이다. 메인큐에서만 사용한다는 것이 중요한 이유는 `NSManagedObjectContext`가 thread safe하지 않기 때문이다.

<br>

##### 다음은 context의 핵심적인 두 가지 역할이다.
- ###### 2-1. Managed Object를 가지고 CRUD 역할
###### Core Data에서 생성되는 모든 관리 객체는 컨텍스트에 담겨 관리
###### 컨텍스트에 담긴 객체는 영구 저장소로 보내 저장, 삭제 가능
###### 코어데이터는 메모리에 로드된 상태로 처리되는데, 이 때의 메모리가 `context`를 의미
<br>

- ###### 2-2. 영구저장소와 영구 저장소 코디네이터에 대한 관리자 역할
###### 읽기와 쓰기를 영구 저장소에 요청 (DAO 패턴과 유사)


<br>

- #### 3. 영구 저장소 코디네이터(Persistent Store Coordinator) : NSPersistentStoreCoordinator
> ###### https://developer.apple.com/documentation/coredata/nspersistentstorecoordinator
##### context와 직접 데이터를 주고 받으면서 다양한 영구 저장소들의 접근을 조정하고 입출력을 담당

<br>

- #### 4. 관리 객체 모델(Managed Object Model)
> ###### https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/KeyConcepts.html
##### 엔티티의 구조를 정의하는 객체인 동시에 이를 바탕으로 Managed Object패턴의 모델 클래스를 참조
##### 클래스이자 형식이고 구조를 의미, 데이터를 CRUD하지 않으며 관리 객체의 각 요소를 제대로 담을 수 있도록 저장 데이터를 구조화

<br>

- #### 5. 영구 객체 저장소(Persistent Object Store)
> ###### https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/KeyConcepts.html
##### 초기에는 직접 읽을 수 있으며 디버깅에 용이한 XML 저장소 ㅊ타입을 사용하며, 앱을 배포할 당시 대량의 데이터를 고려하여 SQLite데이터베이스를 사용하는 것이 용이

<br>
<br>

### CoreData와 Thread Safe
- ##### 데이터베이스에서 다뤄지는 모든 것들은 thread safe하지 않다. context는 자신한테 생성된 큐에서만 생성될 수 있다. 


<br>
<br>

https://zeddios.tistory.com/987
https://ios-development.tistory.com/89
https://caution-dev.github.io/core/data/2019/07/21/Core-Data-Tutorial.html
https://sihyungyou.github.io/iOS-coredata/