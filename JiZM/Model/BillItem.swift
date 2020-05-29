//
//  File.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation

class BillItem {
    var price: Float
    var name: String
    var accout: AccountItem
    var project: ProjectItem
    var shop: String
    var date: Date
    var time: String
    var tag: String
    var remark: String
    init() {
        self.price = Float()
        self.name = String()
        self.accout = AccountItem()
        self.project = ProjectItem()
        self.shop = String()
        self.date = Date()
        self.time = String()
        self.tag = String()
        self.remark = String()
    }
    
}
