//
//  CategoryFormCollectionViewCell.swift
//  JiZM
//
//  Created by MingL L on 2020/6/10.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class CategoryFormCollectionViewCell: UICollectionViewCell {
    
    var progressView: RoundView!
    var progressLabel: UILabel!
    var nameLabel: UILabel!
    var priceLabel: UILabel!
    
    override init(frame: CGRect) {
        self.progressView = RoundView()
        self.progressView.backgroundColor = .white
        self.progressLabel = UILabel(frame: .zero)
        self.progressLabel.adjustsFontSizeToFitWidth = true
        self.progressLabel.textAlignment = .center
        self.priceLabel = UILabel(frame: .zero)
        self.priceLabel.adjustsFontSizeToFitWidth = true
        self.priceLabel.textAlignment = .center
        self.nameLabel = UILabel(frame: .zero)
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.textAlignment = .center
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.progressView)
        self.addSubview(self.progressLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.priceLabel)
        
        self.progressView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        self.progressLabel.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.progressView.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        self.priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(3)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-3)
        }
    }
    
    func setUpCell(color: UIColor, progress: Double, name: String, price: Float)  {
        self.progressView.color = color
        self.progressView.progress = progress
        self.progressLabel.text = String(format: "%.2f", progress)
        self.progressLabel.textColor = .lightGray
        self.nameLabel.text = name
        self.priceLabel.text = String(format: "%.2f", price)
        self.priceLabel.textColor = color
    }
    
}
