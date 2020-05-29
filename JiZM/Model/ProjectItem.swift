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
    init(name: String, beginDate: Date, endDate: Date, imageName: String) {
        self.name = name
        self.beginDate = beginDate
        self.endDate = endDate
        self.imageName = imageName
    }
    
    init() {
        self.name = ""
        self.beginDate = Date()
        self.endDate = Date()
        self.imageName = ""
    }
    
}
