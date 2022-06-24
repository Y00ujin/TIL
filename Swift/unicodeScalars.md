# **Unicode Scalars**

- #### ```Unicode Scalars``` 사용해보기 with Youjin 👩🏻‍💻

### Unicode Scalars란?
- ##### 유니코드 스칼라는 유니코드 코드 포인트이다.
- ##### 고유한 21비트 숫자로 이루어졌다.
- ##### String 은 유니코드 스칼라 값으로 만들어진다.

> #### UnicodeScalar를 사용하여 Unicode를 다양한 형식으로 변환해보고 또 다시 Unicode로 변환해보자.
***

###### Unicode to Int
### 유니코드(String)를 숫자(Int)로 변환
```let number: Int = Int(UnicodeScalar("A").value) // 65```

***

###### Int to Unicode
### 숫자(Int)를 유니코드(String)로 변환
```let unicode: String = String(UnicodeScalar(65)!) // A```

***

###### Unicode to String
### 유니코드를 문자열로 변환
```swift
let a = "Aasdf"

for i in a.utf16 {
    print(i) 
    // 65
    // 97
    // 115
    // 100
    // 102
}
```
***


> ##### 참고
- ###### https://taeminator1.tistory.com/55
- ###### https://chelwoong.github.io/Swift-ASCII-Convert/
- ###### https://norux.me/31

<br>

### END!