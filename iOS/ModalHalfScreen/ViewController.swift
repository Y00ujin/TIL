//
//  ViewController.swift
//  ModalHalfScreen
//
//  Created by 김유진 on 2021/05/17.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {

    let button = UIButton().then {
        $0.setTitle("Board 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    
    static func instance() -> ViewController {
        return ViewController(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 뷰에 버튼 추가
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        // 이벤트 추가
        button.addTarget(self, action: #selector(onTapBtn), for: .touchUpInside)
    }
    
    
    @objc
    func onTapBtn() {
        // BulletinBoard Modal 생성
        let bulletinBoardVC = BulletinVC.instance()
        
        bulletinBoardVC.delegate = self
        addDim()
        present(bulletinBoardVC, animated: true, completion: nil)
    }
    
    private func addDim() {
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.bgView.alpha = 0.2
        }
    }
    
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.bgView.removeFromSuperview()
        }
    }

}

extension ViewController: BulletinDelegate {
    func onTapClose() {
        self.removeDim()
    }
}
