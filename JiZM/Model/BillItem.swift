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
    var status: String
    var category: String
    var account: AccountItem
    var project: ProjectItem?
    var shop: String?
    var date: Date
    var time: String
    var tag: String?
    var remark: String?
    var imageName: String
    
    init() {
        self.price = 0.0
        self.category = ""
        self.name = ""
        self.account = AccountItem()
        self.shop = ""
        self.date = Date()
        self.time = ""
        self.tag = ""
        self.remark = ""
        self.imageName = ""
        self.status = ""
    }
    
    init(price: Float, name: String, status:String, category: String, account: AccountItem, project: ProjectItem, shop: String, date: Date, time: String, tag: String, remark: String, imageName: String) {
        self.price = price
        self.name = name
        self.status = status
        self.category = category
        self.account = account
        self.project = project
        self.shop = shop
        self.date = date
        self.time = time
        self.tag = tag
        self.remark = remark
        self.imageName = imageName
        
    }
}
