//
//  ItmeView.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class ItmeView: UIView {

    var label: UILabel
    var typeView: UIView
    
    init(frame: CGRect,name: String, view: UIView) {
        self.label = UILabel()
        self.typeView = view
        super.init(frame: frame)
        self.label.text = name
        self.label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        self.addSubview(typeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        label.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview().offset(3)
        }
        
        typeView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-3)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(150)
        }
    }
    
    
}
