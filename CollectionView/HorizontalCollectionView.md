# Horizontal CollectionView

#### mainCell.swift
```swift
//
//  CollectionViewCell.swift
//  horizontalCollectionView
//
//  Created by 김유진 on 2021/04/28.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    static let registerId = "\(MainCell.self)"
    
    let label = UILabel().then{
        $0.text = "나의 할 일"
        $0.textColor = UIColor(red: 107/255, green: 64/255, blue: 255/255, alpha: 1)
        $0.font = $0.font.withSize(12)
    }
    
    let circle = UIView().then {
        // circle
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 35/2
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.white.cgColor
        $0.backgroundColor = UIColor(red: 107/255, green: 64/255, blue: 255/255, alpha: 1)
    }
    
    let main = UIView().then {
        $0.layer.cornerRadius = 14
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 14
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bindConstraints()
        circleSnapKit()
        labelSnapKit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        bindConstraints()
        circleSnapKit()
        labelSnapKit()
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(main)
        main.addSubview(circle)
        main.addSubview(label)
    }
    
    private func bindConstraints() {
        main.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    private func circleSnapKit() {
        circle.snp.makeConstraints { (make) in
            make.height.width.equalTo(35)
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
        }
    }
    
    private func labelSnapKit(){
        label.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.height.equalTo(14)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

```

#### MainView.swift
```swift



import UIKit
import SnapKit

class MainView: UIView {
    

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        bindConstraints()
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(collectionView)
    }
    
    func bindConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaInsets).inset(200)
            make.height.equalTo(200)
        }
    }
}

let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
        
    $0.backgroundColor = .white
    $0.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
    $0.showsHorizontalScrollIndicator = false
    $0.collectionViewLayout = layout
}

```

```swift
import UIKit
import Then

class ViewController: UIViewController {
    
    var labelArr = ["나의 할 일","우리의 할 일","심부름","문의하기"]
    
    
    private lazy var mainView = MainView.init(frame: self.view.frame)

    static func instance() -> ViewController {
        return ViewController.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.registerId)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.registerId, for: indexPath) as? MainCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = labelArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 117, height: 140)
    }
    
    //MARK: collectionView - left Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    //MARK: collectionView - cell 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
}

```