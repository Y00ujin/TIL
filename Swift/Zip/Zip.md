# **Zip**

- #### ```Zip``` 이해해보기 with Youjin 👩🏻‍💻

### Zip 뭐야?

> #### ```두 개의 기본 시퀀스로 만들어진 시퀀스 쌍을 만든다.```
> #### ```두 리스트를 짝지어서 합쳐준다.```


### ```Zip``` 사용해보자
```swift
var absolutes: [Int] = [1,2,3]
var signs = [false,false,true]

let merge = zip(absolutes,signs)

for i in merge{
    print(i)
    
    //(1, false)
    //(2, false)
    //(3, true)

}
```
- #### 개수가 다른 시퀀스들을 ```Zip```하면 어떨까?
###### 길이가 다를경우 짧은 시퀀스의 개수에 맞춰서 나온다 😓
```Swift
var absolutes: [Int] = [1,2,3,4]
var signs = [false,false,true]

let merge = zip(absolutes,signs)

for i in merge{
    print(i)
    
    //(1, false)
    //(2, false)
    //(3, true)

}
```

