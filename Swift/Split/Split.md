# **Split**

- #### ```Split``` 이해해보기 with Youjin 👩🏻‍💻

### Split이 뭐야?

> #### ```문자열을 특정 문자 기준으로 쪼갤 수 있는 것```
> #### ```반환형은 String형을 받아 [Substring]으로 반환하게 된다```

### ```Split``` 사용해보자
```
ar str = "hi! hi! my name is Youjin"

str.characters.split(separator: " ").map(String.init)
// ["hi", ]
```

- #### ```maxSplits``` 사용해보기
##### separator로 maxSplits횟수만큼 쪼갠다
##### 그러니까 Hello, 쪼개고 world. 안쪼갠다 1번만 쪼개라했으니까
```
var str = "Hello, world. Zedd!!   Haha"

str.characters.split(separator: " ", maxSplits: 1).map(String.init)

//Print ["Hello, world. Zedd!!   Haha"] -> count = 1
```

- #### ```omittingEmptySubsequences``` 사용해보기
##### false면 ""를 반환해주고 true면 ""를 없애고 반환해준다 
```
var str = "Hello, world. Zedd!!   Haha"

str.characters.split(separator: " ", omittingEmptySubsequences: true).map(String.init)

//Print ["Hello,", "world.", "Zedd!!", "Haha"]
```

### END!