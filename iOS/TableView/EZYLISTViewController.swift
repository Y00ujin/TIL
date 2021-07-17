//
//  ViewController.swift
//  EZYLIST
//
//  Created by 김유진 on 2021/05/08.
//

import UIKit
import SnapKit

class EZYMainViewController: UIViewController {
    

    private lazy var mainView = EZYCollectionView.init(frame: self.view.frame)
    
    let myNavigationController = UINavigationController(rootViewController: SecondViewController())

    let EZYLISTTableView: UITableView = UITableView()
    
    let groupNameArray: [String] = ["NEULSOM", "공부", "산책", "심부름", "NEULSOM", "공부", "산책", "심부름"]
    let titleArray: [String] = ["EZY 회의", "디자인 이론 공부", "강아지 산책시키기", "카페에서 마카롱 사오기", "EZY 회의", "디자인 이론 공부", "강아지 산책시키기", "카페에서 마카롱 사오기"]
    let planTimeArray: [String] = ["12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00", "12:00 - 13:00"]
    var labelArr = ["나의 할 일","우리의 할 일","심부름","문의하기"]
    
    var purpleColor: UIColor! = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
    var orangeColor: UIColor! = UIColor(red: 255/255, green: 166/255, blue: 128/255, alpha: 1)
    var yellowColor: UIColor! = UIColor(red: 255/255, green: 209/255, blue: 141/255, alpha: 1)
    var greenColor: UIColor! = UIColor(red: 184/255, green: 128/255, blue: 255/255, alpha: 1)
    
    lazy var EZYPlanBackgroundColor: [UIColor] = [purpleColor, orangeColor, yellowColor, greenColor, purpleColor, orangeColor, yellowColor, greenColor]
    
    var EZYLISTTitleLabel: UILabel!
    var EZYWelcomTitleStartLabel: UILabel!
    var EZYWelcomTitleMiddleLabel: UILabel!
    var EZYWelcomTitleEndLabel: UILabel!
    var EZYLISTHeaderView: UIView!
    var EZYPlanAddButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        
        navigationController?.isNavigationBarHidden = true
        
        setupCollectionView()
        setupEZYLISTHeaderView()
        
        self.EZYLISTTableView.dataSource = self
        self.EZYLISTTableView.delegate = self
        
        self.EZYLISTTableView.separatorStyle = .none
        
        view.addSubview(EZYLISTTableView)
        view.addSubview(EZYLISTHeaderView)
        view.addSubview(EZYWelcomTitleStartLabel)
        view.addSubview(EZYWelcomTitleMiddleLabel)
        view.addSubview(EZYWelcomTitleEndLabel)

        
        EZYLISTHeaderView.addSubview(EZYLISTTitleLabel)
        EZYLISTHeaderView.addSubview(EZYPlanAddButton)
        
        EZYLISTTableView.showsVerticalScrollIndicator = false
        
        EZYLISTTableView.backgroundColor = .clear
        
        EZYLISTTableView.register(EZYLISTTableViewCell.classForCoder(), forCellReuseIdentifier: "EZYLISTTableViewCell")
        
        EZYLISTTableViewSnapKit()
        EZYLISTTitleLabelSnapKit()
        EZYLISTHeaderViewSnapKit()
        EZYPlanAddButtonSnapKit()
        EZYWelcomTitleStartLabelSnapKit()
        EZYWelcomTitleMiddleLabelSnapKit()
        EZYWelcomTitleEndSnapKit()
    }
    
    private func setupCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(EZYCollectionViewCell.self, forCellWithReuseIdentifier: EZYCollectionViewCell.registerId)
    }
    
    private func setupEZYLISTHeaderView(){
        
        EZYWelcomTitleStartLabel = UILabel()
        EZYWelcomTitleStartLabel.text = "예원님,"
        EZYWelcomTitleStartLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        EZYWelcomTitleStartLabel.textColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        
        EZYWelcomTitleMiddleLabel = UILabel()
        EZYWelcomTitleMiddleLabel.text = "오늘은 어떤 하루를"
        EZYWelcomTitleMiddleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        EZYWelcomTitleMiddleLabel.textColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        
        EZYWelcomTitleEndLabel = UILabel()
        EZYWelcomTitleEndLabel.text = "보내실 건가요?"
        EZYWelcomTitleEndLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        EZYWelcomTitleEndLabel.textColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        
        EZYLISTTitleLabel = UILabel()
        EZYLISTTitleLabel.textColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        EZYLISTTitleLabel.text = "EZYLIST"
        EZYLISTTitleLabel.font = UIFont(name: "Poppins-Bold", size: 12)
        
        EZYPlanAddButton = UIButton()
        EZYPlanAddButton.setImage(UIImage(named: "EZY_PlanAddButton"), for: .normal)
        
        // Letter Spacing
        let attributedString = NSMutableAttributedString(string: EZYLISTTitleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(3.0), range: NSRange(location: 0, length: attributedString.length))
        EZYLISTTitleLabel.attributedText = attributedString
        
        EZYLISTHeaderView = UIView()
        EZYLISTHeaderView.backgroundColor = .white
    }
    
    static func instance() -> EZYMainViewController {
        return EZYMainViewController.init(nibName: nil, bundle: nil)
    }
    
    func EZYWelcomTitleEndSnapKit(){
        EZYWelcomTitleEndLabel.snp.makeConstraints { make in
            make.left.equalTo(EZYWelcomTitleMiddleLabel)
            make.top.equalTo(EZYWelcomTitleMiddleLabel.snp.bottom)
        }
    }
    
    func EZYWelcomTitleMiddleLabelSnapKit(){
        EZYWelcomTitleMiddleLabel.snp.makeConstraints { make in
            make.left.equalTo(EZYWelcomTitleStartLabel)
            make.top.equalTo(EZYWelcomTitleStartLabel.snp.bottom)
        }
    }
    
    func EZYWelcomTitleStartLabelSnapKit(){
        EZYWelcomTitleStartLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.left.equalToSuperview().inset(29)
        }
    }
    
    func EZYLISTTitleLabelSnapKit(){
        EZYLISTTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(29)
            make.top.equalToSuperview().offset(9)
        }
    }
    
    func EZYLISTHeaderViewSnapKit(){
        EZYLISTHeaderView.snp.makeConstraints { make in
            make.top.equalTo(mainView.collectionView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func EZYLISTTableViewSnapKit(){
        EZYLISTTableView.snp.makeConstraints { make in
            make.top.equalTo(EZYLISTHeaderView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func EZYPlanAddButtonSnapKit(){
        EZYPlanAddButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(29)
            make.top.equalTo(EZYLISTTitleLabel)
            make.height.equalToSuperview().dividedBy(3)
            make.width.equalTo(EZYPlanAddButton.snp.height)
        }
    }
}

extension EZYMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EZYCollectionViewCell.registerId, for: indexPath) as? EZYCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = labelArr[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.width / 3.45, height: (self.view.frame.width / 3)/0.95)
    }
    
    //MARK: collectionView - left Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    //MARK: collectionView - cell 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
}


extension EZYMainViewController: UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EZYLISTTableViewCell", for: indexPath) as! EZYLISTTableViewCell
        cell.groupNameLabel?.text = groupNameArray[indexPath.row]
        cell.titleLabel?.text = titleArray[indexPath.row]
        cell.planTimeLabel?.text = planTimeArray[indexPath.row]
        
        cell.EZYLISTCellLeftDecorationView.backgroundColor = EZYPlanBackgroundColor[indexPath.row]
        cell.titleLabel.textColor = EZYPlanBackgroundColor[indexPath.row]
        cell.groupNameLabel.textColor = EZYPlanBackgroundColor[indexPath.row]
        
        print("tableView - cellForRowAt")
        print(indexPath.row)
        print(cell.titleLabel!.text ?? "")
        
        cell.backgroundColor = .white
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}

extension EZYMainViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView - didSelectRowAt")
        var cell = tableView.cellForRow(at: indexPath)
        print(indexPath.row)
        print(titleArray[indexPath.row])
        
        let pushVC = NextViewController()
        
        pushVC.titleLabel.text = titleArray[indexPath.row]
        
        self.navigationController?.pushViewController(pushVC, animated: true)
    }

    
}
