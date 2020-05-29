//
//  Account.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation
class AccountItem {
    var name: String
    var category: String
    var amount: Float
    var isShowTotalAmount: Bool
    var describe: String
    var imageName: String
    var initialAmount: Float
    init(name: String, category: String, initialAmount: Float, isShowTotalAmount: Bool, describe: String, imageName: String) {
        self.name = name
        self.category = category
        self.initialAmount = initialAmount
        self.isShowTotalAmount = isShowTotalAmount
        self.describe = describe
        self.imageName = imageName
        self.amount = initialAmount
    }
    
    init() {
        self.name = ""
        self.category = ""
        self.initialAmount = 0.0
        self.isShowTotalAmount = false
        self.describe = ""
        self.imageName = ""
        self.amount = 0.0
    }
    
}
