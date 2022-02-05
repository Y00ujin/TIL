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

- #### 영속성(Persistance)이란?

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










https://zeddios.tistory.com/987
https://ios-development.tistory.com/89
https://caution-dev.github.io/core/data/2019/07/21/Core-Data-Tutorial.html