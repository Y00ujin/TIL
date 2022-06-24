# **ModalHalfScreen**

- #### 화면의 반만 차지하는 모달창을 띄워보자 👩🏻‍💻
###### 버튼 클릭 시 모달창이 호출되고, 모달창의 버튼을 누를 시 모달이 사라진다.

##### 1. 버튼을 만들어주자
###### 이 버튼을 누를시 모달창이 뜬다!
```Swift
    let button = UIButton().then {
        $0.setTitle("modal open", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
```

##### 2. modal background View를 만들어주자
###### 버튼을 누르고 모달 창이 뜨면 기존의 뷰에 그림자가 생긴다.
###### 그 그림자를 표현해줄 뷰를 만들어보자!
```Swift
    let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
```

##### 3. modal View를 만들어보자
- ###### BulletinVC.swift파일을 생성해주고, modal View를 생성한다.
```Swift
    let bgView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
    }
```

##### 4. modal View를 닫는 버튼을 만들자 in BulletinVC.swift
```Swift
    let closeBtn = UIButton().then {
        $0.setTitle("댣기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
```

##### 6. ViewController에서 모달 창 버튼을 누르면 실행될 함수를 작성해보자!
```Swift
    @objc
    func onTapBtn() {
        // BulletinBoard Modal 생성
        let bulletinBoardVC = BulletinVC.instance()
        
        bulletinBoardVC.delegate = self
        addDim()
        present(bulletinBoardVC, animated: true, completion: nil)
    }
```

##### 5. 열기버튼에 함수를 연결해주자! -> addTarget
```Swift
button.addTarget(self, action: #selector(onTapBtn), for: .touchUpInside)
```