//
//  ProjectTableViewCell.swift
//  JiZM
//
//  Created by MingL L on 2020/5/30.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class ProjectTableViewCell: UITableViewCell {
    
    var iconView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var amountLabel: UILabel!
    var statusLabel:UILabel!
    var consumeAmountLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.iconView = UIImageView()
        self.nameLabel = UILabel()
        self.timeLabel = UILabel()
        self.amountLabel = UILabel()
        self.statusLabel = UILabel()
        self.consumeAmountLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.timeLabel.adjustsFontSizeToFitWidth = true
        self.amountLabel.adjustsFontSizeToFitWidth = true
        self.consumeAmountLabel.adjustsFontSizeToFitWidth = true
        self.statusLabel.adjustsFontSizeToFitWidth = true
        self.statusLabel.text = "剩余预算"
        self.addSubview(self.iconView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.timeLabel)
        self.addSubview(self.amountLabel)
        self.addSubview(self.consumeAmountLabel)
        self.addSubview(self.statusLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3)
            make.top.bottom.equalToSuperview().offset(3)
            make.width.equalTo(60)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp.right).offset(3)
            make.top.equalToSuperview().offset(3)
            make.height.equalTo(20)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(2)
            make.left.equalTo(self.nameLabel.snp.left)
            make.height.equalTo(15)
        }
        self.statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.timeLabel.snp.bottom).offset(2)
            make.left.equalTo(self.nameLabel.snp.left)
            make.height.equalTo(15)
        }
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.statusLabel.snp.right).offset(2)
            make.top.bottom.equalTo(self.statusLabel)
        }
        self.consumeAmountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(3)
            make.height.equalTo(20)
            
        }
    }
    
    func setProjectItemForCell(project:ProjectItem)  {
        self.iconView.image = UIImage(systemName: project.imageName)
        self.nameLabel.text = project.name
        self.timeLabel.text = Date.dateConvertString(date: project.beginDate, dateFormat: "yyyy/MM/dd") + "-" + Date.dateConvertString(date: project.endDate, dateFormat: "yyyy/MM/dd")
        self.amountLabel.text = String(project.totalAmount - project.amount)
        self.consumeAmountLabel.text = String(project.amount)
        
        self.amountLabel.textColor = UIColor.green
        self.consumeAmountLabel.textColor = UIColor.red
    }
    
}
