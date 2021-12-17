# Subscript

<br>

### Subscript란?
- ##### 콜렉션, 리스트, 시퀀스 등 집합의 특정 member elements에 간단하게 접근할 수 있는 문법
- ##### 컬렉션, 리스트, 시퀀스 타입의 개별 요소에 접근할 수 있는 지름길을 제공하는 것.
- ##### 추가적인 메소드 없이 특정 값을 할당하거나 가져올 수 있다.

<br>

### Subscript를 사용해보자
```Swift
let array = [1, 2, 3]

// array 가 서브스크립트 문법을 구현하지도 않았는데 사용할 수 있는 이유는 
// 스위프트 표준 라이브러리에 정의된 array 구조체 내부에 서브스크립트가 이미 구현되어 있기 때문
array[0] // Subscript 사용! ( -> [0] )
```

<br>

#### 참고자료
- ###### https://the-brain-of-sic2.tistory.com/37
- ###### https://medium.com/@jgj455/%EC%98%A4%EB%8A%98%EC%9D%98-swift-%EC%83%81%EC%8B%9D-subscript-2288551588f9
