## trimmingCharacters

- #### ```trimmingCharacters``` 이해해보기 with Youjin 👩🏻‍💻

### 현재 상황

- ##### 완료 버튼 클릭 시 TagNameTextField.text에 공백만 있거나 비어있으면 안돼!

<img width="300" alt="스크린샷 2021-10-03 16 46 39" src="https://user-images.githubusercontent.com/71479613/135744924-be22f73b-d41f-4743-90d1-1b43f5f91bf6.png">

### trimmingCharacters는 character Set을 받아, String 양쪽 끝의 문자를 제거하여 새 문자열을 반환합니다.

- ##### 완료 버튼 클릭 시 TagNameTextField.text가 공백으로만 이루어져있거나, 비어있는지 체크하고 아니면 통과~
```swift
    if tagAddModalView.tagNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || tagAddModalView.tagNameTextField.text == ""{
    }
```


