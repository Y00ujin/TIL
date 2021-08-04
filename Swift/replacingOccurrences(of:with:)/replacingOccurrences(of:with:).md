# **replacingOccurrences(of:with:)**

- #### ```replacingOccurrences``` 이해해보기 with Youjin 👩🏻‍💻

### replacingOccurrences, 뭐야?

> #### ```대상 문자열이 다른 주어진 문자열로 대체된 새 문자열을 반환합니다.```
> #### ```지정된 범위에서 target 문자열을 replacement 문자열로 바꿔 새로운 문자열을 반환함```
> #### ```문자열 치환```
### replacingOccurrences, 사용해보자!
##### options 와 range 는 생략 가능함
- ###### UUID 문자열에서 하이픈 (‘-’) 제거하는 예제
```swift
let uuid = NSUUID().uuidString                  //"3B156152-8CD1-4845-A85C-1722AACC2453"
uuid.replacingOccurrences(of: "-", with: "")    //"3B1561528CD14845A85C1722AACC2453"
```
- ###### 숫자 글자를 숫자로 변환하는 예제
```swift
    let num = seven1two4
    num.replacingOccurrences(of: "seven", with: "7") // 71two4
```

### END!
