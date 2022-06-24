## ARC
<br>
<br>

### ARC?
- ##### 개발자가 직접 retain/release를 통해 reference countin을 관리해야 하는 부분을 자동으로 관리해줍니다.
- ##### ARC는 더이상 필요하지 않은 클래스 인스턴스를 자동으로 메모리에서 해제한다.
- ##### 더이상 필요하지 않음은 Reference Count를 통해 판별한다.

<br>
<br>

### Reference Count란?
- ##### 참조 갯수이다.
###### 어딘가에서 사용중(참조중)인 인스턴스를 메모리에서 해제하면 큰~일 나기때문에 이 인스턴스가 참조되고 있는 Count를 기록한다.
###### 그리고 그 Count가 0이 되면 ARC가 이 인스턴스를 참조하고 있는 곳이 하나도 없구나, 더이상 필요하지 않구나라고 판단하여 자동으로 메모리에서 해제한다.

<br>
<br>

### ARC가 등장하기 전엔 어떻게 메모리를 관리했을까?
- #### 1. GC (Garbage Collection)
###### 정기적으로 Garbage Collector가 동작하여 더이상 사용되지 않는 메모리를 반환하는 방식이다.
###### GC는 ARC와 다르게 런타임에 메모리를 검사하기 때문에 앱 퍼포먼스에 영향을 준다.

<br>

- #### 2. MRR (Manual Retan-Release) / MRC ( Manual Referece Counting)
###### Reference Counting을 통해 메모리를 수동으로 관리하는 방식
###### retain / release / autorelease 등의 메모리 관리 코드를 직접 호출
###### 개발자가 명시적으로 RC를 증가시키고 감소시키는 작업 수행

<br>
<br>

##### 참고자료
- ###### https://jinshine.github.io/2018/07/08/iOS/ARC(Automatic%20Reference%20Counting)/