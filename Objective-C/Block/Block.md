# **Block**

- #### Objective-C의 ```Block``` 이해해보기 with Youjin 👩🏻‍💻

### Block, 뭐야?

- ##### ```Swift의 Closure와 비슷한 개념으로 간단하게 익명함수를 뜻한다.```
- ##### ```Swift의 Closure와는 캡쳐할 때 방식에 있어서 차이점이 있다.```
- ##### ```함수와는 다르게 함수 이름 정의가 따로 존재하지 않습니다. 하지만 파라미터를 받을 수 있고, 반환 값이 존재할 수 있다는 점에서 함수와 동일합니다.```
- ##### ```참조 타입이다.```
- ##### ```함수는 클로저의 한 형태로, 이름이 있는 클로저이다.```



### 응..? 그래서 Block이 뭐라고...? 👩🏻‍💻
> #### Block은 중괄호({})로 감싸진 '실행 가능한 코드 블럭'이다.

### Closure, Block 어떤 차이가 있을까?
- ##### Closure는 값을 캡쳐할 때 Value/Reference 타입에 관계 없이 Reference Capture 한다

- ##### Block은 값을 캡쳐할 때 Value Type일 경우 값을 복사하여 Capture하고, Reference Type일 경우 Reference Captrue를 한다

<br>
-

###### 참고자료
- ###### https://babbab2.tistory.com/50