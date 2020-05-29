//
//  DetailView.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
// 

import UIKit
import SnapKit

class DetailView: UIView {
    
    var imageView: UIImageView
    var ammountLabel: UILabel
    var describe: UITextField
    var nameView: ItmeView
    var categoryView: ItmeView
    var initialAmount: ItmeView
    var isShowTotalAmout: ItmeView
    
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: .zero)
        self.ammountLabel = UILabel(frame: .zero)
        self.ammountLabel.adjustsFontSizeToFitWidth = true
        self.describe = UITextField(frame: .zero)
        self.nameView = ItmeView(frame: .zero, name: "名称", view: UITextField())
        self.categoryView = ItmeView(frame: .zero, name: "账户分组", view: UILabel())
        self.initialAmount = ItmeView(frame: .zero, name: "初始金额", view: UITextField())
        self.isShowTotalAmout = ItmeView(frame: .zero, name: "是否展示在总额上", view: UISwitch())
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.ammountLabel)
        self.addSubview(self.describe)
        self.addSubview(self.nameView)
        self.addSubview(self.categoryView)
        self.addSubview(self.initialAmount)
        self.addSubview(self.isShowTotalAmout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(100)
        }
        self.ammountLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
            make.height.equalTo(60)
        }
        self.describe.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.ammountLabel.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        self.nameView.snp.makeConstraints { (make) in
            make.top.equalTo(self.describe.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.categoryView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.initialAmount.snp.makeConstraints { (make) in
            make.top.equalTo(self.categoryView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.isShowTotalAmout.snp.makeConstraints { (make) in
            make.top.equalTo(self.initialAmount.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        
    }
    

}
