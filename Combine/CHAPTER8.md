# **8. In Practice: Project "Collage Neue"**

이제 사용자가 콜라주를 만들 수 있는 iOS 앱, **Collage Neue**를 만들어보겠습니다.

앱의 구조는 간단합니다. **콜라주를 생성하는 화면**이 있고, **사진을 선택하는 화면**이 있습니다.

- Photo와 같은 시스템 프레임워크와 함께 **Combine의 publishers를 사용**합니다.
- 앱의 logic을 위한 다양한 구독을 생성하기 위해 **다양한 Operator를 사용**합니다.
- **Combine**을 사용하여 **사용자 이벤트를 처리**합니다.

<br>
<br>
<br>
<br>

## CollageNeueModel.swift

Subscription을 저장하기 위한 subscriptions를 선언합니다.

CollageNeueModel이 방출되거나 Subscription을 수동으로 재설정하는 경우 모든 구독이 취소됩니다.

Subscribers는 Subscription의 생명주기를 제어하기 위한 Cancellable token을 반환합니다.

AnyCancellable은 다른 타입의 cancelables를 저장하기위한 type-erased type class 입니다.

```swift
private var subscriptions = Set<AnyCancellable>()
```

<br>
<br>

images에 사용자가 현재 선택한 사진을 담아 내보냅니다. 

데이터를 UI에 할당할 땐 **PassthroughSubject** 대신 **CurrentValueSubject**를 사용하는 것이 적합합니다.

왜냐면 CurrentValueSubject는 value property를 사용하여 현재 값을 확인할 수 있기 때문..!

또 초기값을 필수로 넣어줘야하기 때문에, 설정되지 않은 값을 전달하지 않음을 보장하기 때문..!



```swift
private let images = CurrentValueSubject<[UIImage], Never>([])
```

<br>
<br>

### CurrentValueSubject vs PassthroughSubject

일반적으로, CurrentValueSubject는 사진 배열이나, 로드 상태 등의 현재 상태를 다루기에 적합하고 

PassthroughSubject는 사용자가 버튼을 누르는 것과 같은 단순한 이벤트를 다루기에 적합합니다.

CurrentValueSubject를 사용하면 send(_:)로 새 값을 방출하는 것 대신 직접 값을 변경할 수 있습니다.

이 두 방식은 동일하게 동작하므로, 필요에따라 마음대로 사용할 수 있습니다.

<br>
<br>

### CollageNeueModel.swift - add()

이제 add() 함수 안에 코드를 작성해보겠습니다.

이제 사용자가 **CollageNenuModel.add()**에 바인딩된 **+ 버튼을 클릭**하면 해당 이미지를 

현재 이미지 배열에 추가하고 subject를 통해 전송합니다. 해당 이미지는 Asset 에서 확인할 수 있습니다.

```swift
images.value.append(UIImage(named: "IMG_1907")!)
```

<br>
<br>

### CollageNeueModel.swift - clear()

또한 **현재 선택된 사진을 모두 지우기 위해**, **claer()** 함수에 아래 코드를 추가합니다.

이 코드는 images에 최신 값으로 **빈 배열을 전송**해 초기화합니다.

```swift
images.send([])
```

<br>
<br>

마지막으로 images subject를 화면에 바인딩해보겠습니다. 여러 방법 중 @Published를 사용해보겠습니다.

```swift
@Published var imagePreview: UIImage?
```

<br>
<br>

bindMainView()함수에 아래 코드를 추가 하여 화면의 이미지 미리보기에 Subject를 바인딩합니다.

```swift
// 1
images
  // 2
  .map { photos in
    UIImage.collage(images: photos, size: Self.collageSize)
  }
  // 3
  .assign(to: &$imagePreview)
```

<br>
<br>
<br>
<br>

## MainView.swift

Image(uiImage: UIImage()) 를 아래 코드로 변경합니다.

```swift
Image(uiImage: model.imagePreview ?? UIImage())
```

이제 + 버튼을 클릭했을 때 사진이 추가되고, clear 버튼을 눌렀을 때 초기화되는 것을 볼 수 있습니다.

그러나 하나의 UI를 변경하는 것 보다 여러 개의 UI를 변경하는 것이 일반적입니다.

각 바인딩에 대해 별도의 구독을 만들 수도 있겠지만, 그보다 효율적인 방법으로 여러 UI를 변경해보겠습니다.