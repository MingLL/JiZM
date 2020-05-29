//
//  MyLabel.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class MyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setLabelColor(color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.tintColor = color
    }
    

}
