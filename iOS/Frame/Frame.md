## Frame

<br>
<br>

### Frame이란?
- ##### 한단계 상위뷰의 좌표시스템안에서 View의 위치와 크기를 나타낸다.
- ##### 자신의 부모뷰를 기준으로 origin의 위치를 정하는 것
- ##### `UIView`의 `instance property`이다.
- ##### CGRect 타입으로 origin(x, y)과 size(width, height)를 가진다.

<br>
<br>

### Frame 사용해보깅
- ##### SuperView의 좌표시스템안에서 View의 위치와 크기를 나타낸다.
```Swift
superView.frame = CGRect(x: 30, y: 30, width: 20, height: 20)

subView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
```

###### 빨간색 superview는 screen에서 (30, 30) 떨어진 곳에 위치했다.
###### 초록색 subView는 빨간색 superview에서 (0, 0) 떨어진 곳에 위치했다.
<img width="321" alt="스크린샷 2022-01-10 오후 5 14 52" src="https://user-images.githubusercontent.com/71479613/148735414-41ab5acb-f031-472a-b025-8ed0ab83450e.png">

<br>
<br>

##### 참고자료
- ###### https://zeddios.tistory.com/203
- ###### https://hongdonghyun.github.io/2019/11/Swift-Frame%EA%B3%BC-Bounds/