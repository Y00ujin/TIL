```Swift
//
//  EZYLISTTableViewCell.swift
//  EZYLIST
//
//  Created by 김유진 on 2021/05/08.
//

import UIKit
import SnapKit

class EZYLISTTableViewCell: UITableViewCell {
    
    var groupNameLabel: UILabel!
    var titleLabel: UILabel!
    var planTimeLabel: UILabel!
    var EZYLISTCellLeftDecorationView: UIView!
    var EZYLISTCellRightDecorationView: UIView!
    var EZYLISTCellBackground: UIView!
    var EZYLISTCellColor: [UIColor]!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
        contentView.addSubview(EZYLISTCellRightDecorationView)
        EZYLISTCellRightDecorationView.addSubview(EZYLISTCellLeftDecorationView)
        EZYLISTCellLeftDecorationView.addSubview(EZYLISTCellBackground)
        EZYLISTCellBackground.addSubview(groupNameLabel)
        EZYLISTCellBackground.addSubview(titleLabel)
        EZYLISTCellBackground.addSubview(planTimeLabel)

        TitleLabelSnapKit()
        PlanTimeLabelSnapKit()
        GroupNameLabelSnapKit()
        EZYLISTCellBackgroundSnapKit()
        EZYLISTCellLeftDecorationViewSnapKit()
        EZYLISTCellRightDecorationViewSnapKit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup(){
        groupNameLabel = UILabel()
        groupNameLabel.textColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        groupNameLabel.font = UIFont.boldSystemFont(ofSize: 8)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        planTimeLabel = UILabel()
        planTimeLabel.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
        planTimeLabel.font = UIFont.systemFont(ofSize: 8)
        
        EZYLISTCellRightDecorationView = UIView()
        EZYLISTCellRightDecorationView.backgroundColor = .white
        EZYLISTCellRightDecorationView.layer.cornerRadius = 10
        EZYLISTCellRightDecorationView.layer.masksToBounds = false
        EZYLISTCellRightDecorationView.layer.shadowOpacity = 0.1
        EZYLISTCellRightDecorationView.layer.shadowRadius = 8
        EZYLISTCellRightDecorationView.layer.shadowOffset = CGSize(width: 0, height: 5)
        EZYLISTCellRightDecorationView.layer.shadowColor = UIColor.black.cgColor
        
        EZYLISTCellLeftDecorationView = UIView()
        EZYLISTCellLeftDecorationView.backgroundColor = UIColor(red: 150/255, green: 141/255, blue: 255/255, alpha: 1)
        EZYLISTCellLeftDecorationView.layer.cornerRadius = 10
        
        EZYLISTCellBackground = UIView()
        EZYLISTCellBackground.backgroundColor = .white
        
    }
    
    func EZYLISTCellBackgroundSnapKit(){
        EZYLISTCellBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalTo(EZYLISTCellRightDecorationView)
            make.width.equalTo(EZYLISTCellRightDecorationView).dividedBy(1.07)
            make.bottom.equalToSuperview()
        }
    }

    func EZYLISTCellLeftDecorationViewSnapKit(){
        EZYLISTCellLeftDecorationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
    }
    
    func EZYLISTCellRightDecorationViewSnapKit(){
        EZYLISTCellRightDecorationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(7)
            make.width.equalToSuperview().dividedBy(1.2)
            make.centerX.equalToSuperview()
        }
    }
    
    func GroupNameLabelSnapKit(){
        groupNameLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(titleLabel.snp.top).offset(-3)
        }
    }
    
    func TitleLabelSnapKit(){
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(16)
        }
    }
    
    func PlanTimeLabelSnapKit(){
        planTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel)
        }
    }
}

```