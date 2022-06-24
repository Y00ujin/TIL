## SnapKit vs Autolayout


```swift
//
//  ViewController.swift
//  snapkit_tutorial
//
//  Created by 김유진 on 2021/04/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var greenView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var redView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var yellowView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var blueView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var myButton = { (color: UIColor) -> UIButton in
        let btn = UIButton(type: .system)
        btn.backgroundColor = .darkGray
        btn.setTitle("constraint change", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 16
        return btn
    }
    
    lazy var greenViewTopNSlayoutConstraint: NSLayoutConstraint? = nil
    
    lazy var greenViewTopConstraint: Constraint? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(yellowView)
        self.view.addSubview(redView)
        self.view.addSubview(greenView)
        self.view.addSubview(blueView)
        
        let myDartGrayBtn = myButton(.darkGray)
        self.view.addSubview(myDartGrayBtn)
        
//        greenView.translatesAutoresizingMaskIntoConstraints = false
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        yellowView.translatesAutoresizingMaskIntoConstraints = false
//        blueView.translatesAutoresizingMaskIntoConstraints = false
        
        // width, height, centerX, centerY 주기
//        yellowView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
//        yellowView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8).isActive = true
//        yellowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        yellowView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
        // leading, trailing, top, bottom 모두  constraint주기
//        yellowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        yellowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        yellowView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
//        yellowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        // edges = top + bottom + leading + trailing
        // edges를 self.view와 똑같이 만들어라
        // inset = padding
        
        // snapKit code
        yellowView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            
            // make.edges.equalTo(self.view) == make.edges.equalToSuperview()
            // yellowBox의 Superview가 self.view이기 때문에 두 코드는 완전히 같다.
            
             make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        // snapKit code
        redView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100) // width, height 모두 100
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top) // safeArea의 top에 맞춰라
            make.centerX.equalToSuperview() // 슈퍼뷰의 X축의 center
//            make.center.equalToSuperview() // 슈퍼뷰의 정 가운데
        }
        
        // autolayout code
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            redView.widthAnchor.constraint(equalToConstant: 100),
//            redView.heightAnchor.constraint(equalToConstant: 100),
//            redView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            redView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])
        
        // snapKit code
        blueView.snp.makeConstraints { (make) in
//            make.width.equalTo(redView.snp.width).dividedBy(2) // 2/1배 줄이기
            make.width.equalTo(redView.snp.width).multipliedBy(2) // 2배 늘이기
            make.height.equalTo(redView.snp.height)
            // blueView의 top을 redView의 bottom에 위치시킨다.
            // offset = padding 20
            make.top.equalTo(redView.snp.bottom).offset(20)
            make.centerX.equalToSuperview() // X축의 중간에 위치시킨다.
        }
        
        // autolayout code
//        blueView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            // blueView의 width를 redView의 width와 동일하게 한다. multiplier -> redView width의 2배
//            blueView.widthAnchor.constraint(equalTo: self.redView.widthAnchor, multiplier: 2),
//            blueView.heightAnchor.constraint(equalTo: self.redView.heightAnchor),
//            blueView.topAnchor.constraint(equalTo: self.redView.bottomAnchor, constant: 20),
//            blueView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])

        // snapKit code
        myDartGrayBtn.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.centerX.equalToSuperview()
        }
        
        myDartGrayBtn.addTarget(self, action: #selector(movegreenViewDown), for: .touchUpInside)
        
        // autolayout code
//        myDartGrayBtn.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            // blueView의 width를 redView의 width와 동일하게 한다. multiplier -> redView width의 2배
//            myDartGrayBtn.widthAnchor.constraint(equalToConstant: 200),
//            myDartGrayBtn.heightAnchor.constraint(equalToConstant: 100),
//            myDartGrayBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            myDartGrayBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])
        
        // snapKit code
        greenView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            self.greenViewTopConstraint = make.top.equalTo(blueView.snp.bottom).offset(20).constraint
        }
        
//        greenView.translatesAutoresizingMaskIntoConstraints = false
//
//        greenViewTopNSlayoutConstraint = greenView.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 20)
//
//        // autolayout code
//
//        NSLayoutConstraint.activate([
//            greenView.widthAnchor.constraint(equalToConstant: 100),
//            greenView.heightAnchor.constraint(equalToConstant: 100),
//            greenView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//             // constant = margin
//        ])
//        greenViewTopNSlayoutConstraint?.isActive = true
    }
    
    var offset = 0
    
    @objc fileprivate func movegreenViewDown(){
        offset += 40
        print("ViewController - movegreenViewDown() called")
        print("offset - \(offset)")
        
        self.greenViewTopConstraint?.update(inset: offset)
        
//        self.greenViewTopNSlayoutConstraint?.constant = CGFloat(offset)
    }
}






#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
}

struct ViewControllerRepresentable_PreviewProvider: PreviewProvider{
        static var previews: some View{
            Group{
                ViewControllerRepresentable()
                    .ignoresSafeArea()
                    .previewDisplayName("device")
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
    }
} #endif
```

