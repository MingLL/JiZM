//
//  BillTableViewCell.swift
//  JiZM
//
//  Created by MingL L on 2020/6/1.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class BillTableViewCell: UITableViewCell {
    
    let billImageView: UIImageView!
    let nameLabel: UILabel!
    var priceLabel: UILabel!
    let accountLabel: MyLabel!
    let projectLabel: MyLabel!
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.billImageView = UIImageView(frame: .zero)
        self.nameLabel = UILabel(frame: .zero)
        self.priceLabel = UILabel(frame: .zero)
        self.accountLabel = MyLabel(frame: .zero)
        self.projectLabel = MyLabel(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.projectLabel.adjustsFontSizeToFitWidth = true
        self.accountLabel.adjustsFontSizeToFitWidth = true
        self.projectLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(self.billImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.accountLabel)
        self.addSubview(self.projectLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 布局子视图
    override func layoutSubviews() {
        self.billImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.width.equalTo(60)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.billImageView.snp.right).offset(3)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        self.priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-3)
            make.top.equalToSuperview().offset(3)
            make.height.equalTo(30)
        }
        self.accountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-3)
            make.top.equalTo(self.priceLabel.snp.bottom).offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        self.projectLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.accountLabel.snp.left).offset(-3)
            make.top.bottom.equalTo(self.accountLabel)
        }
    }
    
    
    /// 填充数据
    /// - Parameter bill: BillItem Model
    func setBillItemForCell(bill: BillItem) {
        self.billImageView.image = UIImage(systemName: bill.imageName)
        self.nameLabel.text = bill.name
        self.priceLabel.text = String(bill.price)
        self.accountLabel.text = bill.account.name
        self.accountLabel.setLabelColor(color: UIColor.red)
        self.accountLabel.textInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        if let project = bill.project {
            self.projectLabel.text = project.name
            self.projectLabel.setLabelColor(color: UIColor.orange)
            self.projectLabel.textInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        } else {
            self.projectLabel.removeFromSuperview()
        }
    }
    
}
