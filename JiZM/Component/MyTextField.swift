//
//  MyTextField.swift
//  JiZM
//
//  Created by MingL L on 2020/6/1.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation
import UIKit

class MyTextField: UITextField {
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        self.textColor = UIColor.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
