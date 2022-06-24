# Core Image

<img width="701" alt="스크린샷 2021-12-09 오후 2 02 50" src="https://user-images.githubusercontent.com/71479613/145337495-05b9bca7-3051-4677-a604-f09233230546.png">

> ##### `Apple` : Core Image는 내장 또는 사용자 정의 필터를 사용하여 스틸 및 비디오 이미지를 처리해주는 Framework야

<br>

### Core Image?
- ###### 내장된 필터(이미 정의되어있는 필터)또는 사용자 정의 필터를 사용하여 이미지나 비디오를 처리해주는 Framework!
- ###### CPU 또는 GPU, 둘 중 하나를 이미지 데이터를 처리하기 위해 사용 할 수 있으며 아주 빠르다! (비디오 프레임의 실시간 프로세싱을 하는데 충분할 정도로!!!)


#### 이미지에 필터를 씌우고싶으면 Core Image를 사용하자!

<br>
<hr>

### Core Image의 Class
- #### CIContext
##### 모든 코어이미지 프로세싱은 CIContext 내에서 이루어진다. 일종의 상태 스택
##### 이미지 처리 결과를 렌더링하고 이미지 분석을 수행하기 위한 evaluation context.
##### 또한 CIContext는 상대적으로 초기화하는데 비용이 많이들기때문에 프로젝트 초기 세팅 때 선언해두고 앱 전체에서 재사용하는 것을 권한다.

###### 근데 .. evaluation context가 뭐지..?

<br>

- #### CIImage
##### 이 클래스는 이미지 데이터를 받는다. UIImage, 이미지파일, 이미지데이터 등으로부터 생성가능하다.
##### 이미지에 적용될 필터를 담음 

<br>

- #### CIFilter
##### 이 클래스는 필터의 종류와 각 속성을 담고 있는 일종의 Dictionary객체이다.
##### 필터의 예시로는 생동감, 반전, 자르기 등이 있다.
##### 필터가 적용될 이미지를 담음!

<br>
<hr>

### 자 이제 Core Image의 Class들을 사용하여 쉽게 이미지에 필터를 적용해보자!

#### 1. 필터를 적용할 이미지를 가져오자!
- ###### CIFilter 생성자는 옵셔널 타입을 리턴하기 때문에, guard let ~ else 옵셔널 바인딩을 사용
##### `첫번째 방법` :  url을 이용해서 번들에 있는 image로 CIImage 객체 만들기
```Swift
guard let fileURL = Bundle.main.url(forResource : "image", withExtension: "png") else {return}

guard let basicImage = CIImage(contentsOf: fileURL) else {return}
```
##### `두번째 방법` : UIImage로 CIImage 객체 만들기
```Swift
guard let basicImage = CIImage(image: UIImage(named: "image")) else {return}
```

<br>

#### 2. 이미지에 적용할 필터를 생성하고 합쳐보자!
- ###### 필터는 이미 정의되어있는 필터를 쓸 수도 있고 내가 만들어서 쓸 수도 있다!
##### `이미 만들어져있는 필터 쓰기` : 아래 링크로 들어가면 Apple이 만들어놓은 여러가지 필터들을 확인할 수 있을 것이다.
> ###### https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346
```Swift
    

    // 위의 링크에서 원하는 필터의 이름을 넣어주자!
    // CIFilter 생성자는 필터의 이름과 이 필터를 위한 키와 값을 특정짓는 딕셔너리를 가지고 있습니다.
    guard let filter = CIFilter(name: "CISepiaTone") else {return}

    // "CISepiaTone" 필터는 오직 두 개의 값을 가지는데,"kCIInputImageKey" (CIImage) 와 "kCIInputIntensityKey" (0과 1사이의 float 타입의 값) 이 있습니다.
    // 대부분의 필터는 받아오는 값이 없을 경우에 사용될 기본 값을 가지고 있습니다.
    // 하나의 예외는 CIImage 인데, 이것은 기본값이 없으므로 값이 제공되어야만 합니다.
    self.filter.setValue(beginImage, forKey: kCIInputImageKey)        
    self.filter.setValue(0.5, forKey: kCIInputIntensityKey)
```
<br>


#### 3. 필터와 합쳐진 이미지는 CIImage형식인데, 이 이미지를 출력하려면 UIImage형식으로 변경해야한다! 변경해보자!
- ###### 이제 newImage를 UIImageView에 넣어 디스플레이에 출력하면 끝이다
```Swift
let newImage = UIImage(ciImage: filter.outputImage!)
```


<br><br><hr>

##### 참고자료들!
- ###### https://soooprmx.com/swift-%EC%BD%94%EC%96%B4-%EC%9D%B4%EB%AF%B8%EC%A7%80/
- ###### https://zeddios.tistory.com/1019
- ###### https://developer.apple.com/documentation/coreimage
- ###### https://blog.naver.com/PostView.nhn?blogId=taerg89&logNo=221915066080
- ###### https://atelier-chez-moi.tistory.com/52?category=1004941