//
//  amountView.swift
//  JiZM
//
//  Created by MingL L on 2020/6/7.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class AmountView: UIView {
    var amountLabel: UILabel!
    private var nameLabel: UILabel!
    private var categoryLabel: UILabel!
    
    override init(frame: CGRect) {
        self.amountLabel = UILabel(frame: frame)
        self.nameLabel = UILabel(frame: frame)
        self.categoryLabel = UILabel(frame: frame)
        super.init(frame: frame)
        self.amountLabel.font = UIFont.systemFont(ofSize: 40)
        self.amountLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.text = "余额"
        self.nameLabel.font = UIFont.systemFont(ofSize: 10)
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.categoryLabel.text = "CNY"
        self.categoryLabel.font = UIFont.systemFont(ofSize: 16)
        self.categoryLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(self.amountLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.categoryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(3)
            make.height.equalTo(20)
        }
        self.categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(3)
            make.bottom.equalToSuperview()
        }
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.categoryLabel.snp.right).offset(2)
            make.right.equalToSuperview().offset(-3)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview()
        }
    }
}
