//
//  Plist.swift
//  JiZM
//
//  Created by MingL L on 2020/6/1.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation

class Plist {
    static func readAccountCategoryPlist() -> [String] {
        let accountCategory: String = Bundle.main.path(forResource: "AccountCategory", ofType: "plist") ?? ""
        let data: NSMutableArray = NSMutableArray.init(contentsOfFile: accountCategory)!
        return data as! [String] 
    }
    
    static func readBillCategoryPlist() -> Dictionary<String,Any> {
        let billCategory: String = Bundle.main.path(forResource: "BillCategory", ofType: "plist") ?? ""
        let data: NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: billCategory)!

        return data as! Dictionary<String,Any>
    }
}
