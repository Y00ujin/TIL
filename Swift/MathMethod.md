## Math Method

<br>
<br>

### 소수점을 다룰 때 유용한 swift 함수

- ##### 1. round로 반올림하기
###### 소수점 첫 번째 자리가 5보다 크거나 같으면 올리고, 5보다 작으면 내려 Double 값을 반환한다.
```Swift
round(5.123)  // 5.0
round(5.456)  // 5.0
round(5.512)  // 6.0
round(5.567)  // 6.0
round(5.657)  // 6.0
round(-3.453) // -3.0
round(-3.658) // -4.0
```

<br>

- ##### 2. ceil로 올림하기
###### 소수점 첫 번째 자리가 0보다 큰 경우 무조건 올린다.
```Swift
ceil(5.123)  // 6.0
ceil(5.456)  // 6.0
ceil(5.512)  // 6.0
ceil(5.567)  // 6.0
ceil(5.657)  // 6.0
ceil(5.765)  // 6.0
ceil(-3.453) // -3.0
ceil(-3.658) // -3.0
```
<br>

- ##### 3. floor로 내림하기
###### 소수점을 무조건 내린다.
```Swift
floor(5.123)  // 5.0
floor(5.456)  // 5.0
floor(5.512)  // 5.0
floor(5.567)  // 5.0
floor(5.657)  // 5.0
floor(5.765)  // 5.0
floor(-3.453) // -4.0
floor(-3.658) // -4.0
```
<br>

- ##### 4. trunc로 버림하기
###### 말 그대로 소수점을 버린다. 정수부에는 아무런 영향을 주지 않고 소수점만 지워버린다.
```Swift
trunc(5.123)  // 5.0
trunc(5.456)  // 5.0
trunc(5.512)  // 5.0
trunc(5.567)  // 5.0
trunc(5.657)  // 5.0
trunc(5.765)  // 5.0
trunc(-3.453) // -3.0
trunc(-3.658) // -3.0
```
<br>

- ##### 5. n번째 소수점에서 반올림, 올림, 내림
###### 위에서 사용한 방법들은 모두 소수점 첫 번째 자리에서 처리하는 방법이다. 이번 방법은 원하는 자리에서 행하는 방법이다.
###### 소수점 2자리까지 반올림하고 싶다면 10을 곱해서 원하는 소수점 자리수까지 정수부로 올린 다음 round를 적용시키고 다시 곱한만큼 나눠주면 된다.
###### 3자리면 100, 4자리면 1000 이런식으로.. 

> ###### 5-1. 4번째 자리에서 반올림
```Swift
let digit: Double = pow(10, 3) // 10의 3제곱
round(5.123123 * digit) / digit  // 5.123
round(5.456456 * digit) / digit  // 5.456
round(5.512512 * digit) / digit  // 5.513
round(5.567567 * digit) / digit  // 5.568
round(5.657657 * digit) / digit  // 5.658
round(5.765765 * digit) / digit  // 5.766
round(-3.453453 * digit) / digit // -3.453
round(-3.658658 * digit) / digit // -3.659
```

<br>

> ###### 5-2. 4번째 자리에서 올림
```Swift
let digit: Double = pow(10, 3) // 10의 3제곱
ceil(5.123123 * digit) / digit  // 5.124
ceil(5.456456 * digit) / digit  // 5.457
ceil(5.512512 * digit) / digit  // 5.513
ceil(5.567567 * digit) / digit  // 5.568
ceil(5.657657 * digit) / digit  // 5.658
ceil(5.765765 * digit) / digit  // 5.766
ceil(-3.453453 * digit) / digit // -3.453
ceil(-3.658658 * digit) / digit // -3.658
```

<br>

> ###### 5-3. 4번째 자리에서 내림
```Swift
let digit: Double = pow(10, 3) // 10의 3제곱
floor(5.123123 * digit) / digit  // 5.123
floor(5.456456 * digit) / digit  // 5.456
floor(5.512512 * digit) / digit  // 5.512
floor(5.567567 * digit) / digit  // 5.567
floor(5.657657 * digit) / digit  // 5.657
floor(5.765765 * digit) / digit  // 5.765
floor(-3.453453 * digit) / digit // -3.454
floor(-3.658658 * digit) / digit // -3.659
```

<br>

### Magnitude, abs로 절댓값 구하기
- ##### Magnitude로 절댓값 구하기
###### property특성을 가지고있고, UInt 타입으로 반환한다.
```Swift
let integer = Int(-15)

let magnitudeNum = integer.magnitude // 15
```
- ##### abs로 절댓값 구하기
###### abs는 메서드 형식이며, Int 타입으로 반환한다.
```Swift
let integer = Int(-15)

let absNum = abs(integer) // 15
```

<br>

- ##### String(format:_:...)을 사용하여 n번째 소수점 자르기
```Swift
let decimal = 5.1231283712893781293
String(format: "%.3f", decimal) // "5.123"
String(format: "%.6f", decimal) // "5.123128"
```







