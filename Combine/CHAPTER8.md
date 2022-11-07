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

MainView.swift 파일에는 이미 uidateUI(photosCount:) 함수가 작성되어있으며, 

이 함수는 여러 개의 UI를 업데이트할 수 있습니다.

콜라주의 사진이 홀수 개일 때는 Save 버튼이 비활성화 되고, 

Clear버튼은 콜라주에 사진이 추가만되어있으면 항상 활성화 되어있습니다.

user가 콜라주에 사진을 추가할 때마다 updateUI(photosCount:) 함수를 호출하기 위해서,

handleEvents() Operator를 사용합니다. 

일반적으로 sink(...) 또는 assign(to:on:)에서 UI를 업데이트하는 것이 권장되지만,

이 섹션에서는 handleEvents에서 업데이트를 시도합니다.

<br>
<br>

---

<br>
<br>

## **CollageNeueModel.swift**

**CollageNeueModel.swift** 에 새로운 프로퍼티를 추가합니다.

```swift
let updateUISubject = PassthroughSubject<Int, Never>()
```

subjects를 사용하여 다른 타입과 통신하려면, (이번 예제에서는 model과 view가 통신하고있음)

updateUISubject라는 새 subject를 추가해야합니다.

<br>
<br>

### CollegeNeueModel.swift - bindMainView()

map을 사용하기 전에 updateUISubject Operator를 추가합니다.

```swift
func bindMainView() {
    // 1
    images // 추가된 부분!
      .handleEvents(receiveOutput: { [weak self] photos in
        self?.updateUISubject.send(photos.count)
      })
      // 2
      .map { photos in
        UIImage.collage(images: photos, size: Self.collageSize)
      }
      // 3
      .assign(to: &$imagePreview)
  }
```

이렇게 하면 현재 선택된 이미지가 map Operator 내부에서 single 콜라주 이미지로 변경되기 전에 updateUI(photosCount:)로 전달됩니다.

이제 MainView에서 updateUISubject를 관찰하려면 MainView.swift를 열고 .onAppear(...): 바로 아래에 있는 새 수정자를 엽니다.

<br>
<br>

---

<br>
<br>

## MainView.swift

이제 우리가 작성한 updateUISubject가 잘 작동하는지 확인해보겠습니다.

MainView.swift 파일을 열고, 새로운 modifier를 .onAppear 바로 아래에 추가합니다.

```swift
.onReceive(model.updateUISubject, perform: updateUI)
.onAppear(perform: model.bindMainView)
```

이제 빌드를 해보면 Clear 버튼과 Save 버튼이 비활성화되어있습니다. 사진을 추가하면 Clear 버튼이 

활성화돼고 콜라주 내부에 사진이 짝수개면 Save 버튼도 활성화됩니다. UI에 표시할 데이터를 subject를 통해 

쉽게 전달하는 방법을 알아보았습니다. 다음으로는 사용자가 갤러리에서 선택한 사진을 콜라주에 추가할 수 

있도록 하기 위해 모델에 Combine 코드를 추가해보겠습니다.

<br>
<br>

---

<br>
<br>

## CollageNenuModel.swift

새로운 subject를 생성합니다. 

```swift
private(set) var selectedPhotosSubject = PassthroughSubject<UIImage, Never>()
```

시뮬레이터의 갤러리에서 사진을 가져오는 기능은 이미 구현되어 있습니다.

// Send the selected image 주석처리가 되어있는 부분을 아래 코드로 변경해봅시다.

사용자가 사진을 선택했을 때 이미지를 전송합니다.

```swift
self.selectedPhotosSubject.send(image)
```

<br>
<br>

---

<br>
<br>

## **PhotosView.swift**

그리고 PhotosView.swift에서 .onDisappear(…): 내부에 코드를 추가합니다.

그럼 갤러리 뷰가 사라질 때 해당 함수 내부의 코드(우리가 작성한 코드)가 작동합니다.

뷰가 사라질 때 model의 subject에 완료 이벤트를 전송합니다.

```swift
model.selectedPhotosSubject.send(completion: .finished)
```

<br>
<br>

---

<br>
<br>

## CollageNenuModel.swift

이제 선택한 사진을 구독하고 MainView에 표시해야합니다.

CollageNeueModel.swift를 열고 add() 내부에 코드를 작성합니다.

```swift
let newPhotos = selectedPhotosSubject

newPhotos
  .map { [unowned self] newImage in
  // 1: 이미 선택되어있던 image 목록을 가져오고 여기에 새 이미지를 추가합니다.
    return self.images.value + [newImage]
  }
  // 2: assign을 사용해서 images Subject에 업데이트된 이미지 배열을 전송합니다.
  .assign(to: \.value, on: images)
  // 3: 새 subscription은 subscriptions에 저장하며, 
  // presentedVC가 dismiss될 때 모든 구독이 취소됩니다.
  .store(in: &subscriptions)
```
<br>
<br>

---

<br>
<br>

## MainView.swift

이제 메인화면에서 + 버튼을 클릭했을 때 갤러리로 넘어가도록 설정해보겠습니다.

MainView.swift의 model.add() 줄을 아래 코드로 변경합니다.

isDisplayingPhotoPicker 프로퍼티를 true로 설정하면 PhotosView가 표시되도록 설계되어있습니다.

```swift
isDisplayingPhotoPicker = true
```

<br>
<br>

앱을 실행해보면 갤러리에 접근해도 될지 물어보는 팝업창이 뜹니다. 허용을 누른 뒤 테스트해보겠습니다.