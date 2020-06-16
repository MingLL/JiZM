//
//  CategoryCollectionViewCell.swift
//  JiZM
//
//  Created by MingL L on 2020/6/15.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var label: MyLabel!
    
    override init(frame: CGRect) {
        self.label = MyLabel(frame: .zero)
        self.label.adjustsFontSizeToFitWidth = true
        self.label.numberOfLines = 0
        self.label.font = UIFont.systemFont(ofSize: 14)

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func setUpCell(string: String, color: UIColor)  {
        self.label.text = string
        self.label.textInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        self.label.setLabelColor(color: color)
    }
    
}
