## Bounds

<br>
<br>

### Bounds란?
- ##### 자신만의 좌표 시스템 안에서 view의 위치와 크기를 나타낸다.
- ##### `UIView`의 `instance property`이다.
- ##### CGRect 타입으로 origin(x, y)과 size(width, height)를 가진다.

<br>
<br>

### Bounds 사용해보기
###### 아래와 같이 frame로 위치를 지정했다.
```Swift
superView.frame = CGRect(x: 30, y: 30, width: 20, height: 20)

subView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
```

<img width="321" alt="스크린샷 2022-01-10 오후 5 14 52" src="https://user-images.githubusercontent.com/71479613/148735414-41ab5acb-f031-472a-b025-8ed0ab83450e.png">

###### 그 후 각 view의 superview의 bounds를 출력해보면 모두 (0,0)으로 나온다.
###### 상위뷰와 상관없이 자기 자신의 좌표를 사용하기 때문이다.
##### 참고자료
- ###### https://zeddios.tistory.com/203
- ###### https://hongdonghyun.github.io/2019/11/Swift-Frame%EA%B3%BC-Bounds/