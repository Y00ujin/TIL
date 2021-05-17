//
//  BulletinVC.swift
//  ModalHalfScreen
//
//  Created by 김유진 on 2021/05/17.
//

import UIKit
import Then

protocol BulletinDelegate: class {
    func onTapClose()
}

class BulletinVC: UIViewController {
    
    weak var delegate: BulletinDelegate?
    
    let bgView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
    }
    
    let closeBtn = UIButton().then {
        $0.setTitle("댣기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    
    static func instance() -> BulletinVC {
        return BulletinVC(nibName: nil, bundle: nil).then {
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        view.backgroundColor = .clear
        view.addSubview(bgView)
        view.addSubview(closeBtn)
        
        // Add Event
        closeBtn.addTarget(self, action: #selector(onTapClose), for: .touchUpInside)
        
        
        // Setup AutoLayout
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(30)
            make.height.equalToSuperview().dividedBy(1.6)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
    }
    
    @objc
    func onTapClose() {
        delegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
}
