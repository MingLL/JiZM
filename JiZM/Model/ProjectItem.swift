//
//  File.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation

class ProjectItem {
    
    var name: String
    var beginDate: Date
    var endDate: Date
    var imageName: String
    var status: String
    var totalAmount: Float
    var amount: Float
    
    
    init(name: String, beginDate: Date, endDate: Date,totalAmount:Float, imageName: String) {
        self.name = name
        self.beginDate = beginDate
        self.endDate = endDate
        self.totalAmount = totalAmount
        self.imageName = imageName
        self.status = ""
        self.amount = 0.0
    }
    
    init() {
        self.name = ""
        self.beginDate = Date()
        self.endDate = Date()
        self.totalAmount = 0.0
        self.imageName = ""
        self.status = ""
        self.amount = 0.0
    }
    
}
