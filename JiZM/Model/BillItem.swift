//
//  File.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BillItem {
    var price: Float
    var name: String
    var status: String
    var category: String
    var account: AccountItem
    var project: ProjectItem?
    var shop: String?
    var date: Date
    var time: String {
        get {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return timeFormatter.string(from: self.date) as String
        }
    }
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
        self.tag = ""
        self.remark = ""
        self.imageName = ""
        self.status = ""
    }
    
    init(price: Float, name: String, status:String, category: String, account: AccountItem, project: ProjectItem, shop: String, date: Date, tag: String, remark: String, imageName: String) {
        self.price = price
        self.name = name
        self.status = status
        self.category = category
        self.account = account
        self.project = project
        self.shop = shop
        self.date = date
        self.tag = tag
        self.remark = remark
        self.imageName = imageName
    }
    
    static func saveBill(billItem: BillItem) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let bill = NSEntityDescription.insertNewObject(forEntityName: "Bill", into: app.persistentContainer.viewContext) as! Bill
        bill.name = billItem.name
        bill.price = billItem.price
        bill.category = billItem.category
        bill.imageName = billItem.imageName
        bill.date = billItem.date
        bill.remark = billItem.remark
        bill.tag = billItem.tag
        bill.shop = billItem.shop
        bill.status = billItem.status
        bill.bill_account = AccountItem.searchAccount(accountItme: billItem.account)
        if let project = ProjectItem.searchProject(projectItem: billItem.project ?? nil) {
            bill.bill_project = project
        }
        app.saveContext()
        
    }
    
    static func searchBills() ->[BillItem] {
        var billItems: [BillItem] = []
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request = NSFetchRequest<Bill>.init(entityName: "Bill")
        do {
            let fetchedObjects = try context.fetch(request)
            for bill in fetchedObjects {
                let billItem = BillItem()
                billItem.name = bill.name!
                billItem.date = bill.date!
                billItem.category = bill.category!
                billItem.imageName = bill.imageName!
                billItem.price = bill.price
                billItem.remark = bill.remark!
                billItem.shop = bill.shop!
                billItem.status = bill.status!
                billItem.tag = bill.tag!
                billItem.account = AccountItem.toAccountItme(account: bill.bill_account!)
                if let project = bill.bill_project {
                    billItem.project = ProjectItem.toProjectItme(project: project)
                }
                billItems.append(billItem)
            }
        } catch {
            print("error")
        }
        return billItems
    }
}
