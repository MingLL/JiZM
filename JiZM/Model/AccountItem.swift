//
//  Account.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AccountItem {
    var name: String
    var category: String
    var amount: Float
    var isShowTotalAmount: Bool
    var imageName: String
    var initialAmount: Float
    init(name: String, category: String, initialAmount: Float, isShowTotalAmount: Bool, imageName: String) {
        self.name = name
        self.category = category
        self.initialAmount = initialAmount
        self.isShowTotalAmount = isShowTotalAmount
        self.imageName = imageName
        self.amount = initialAmount
    }
    
    init() {
        self.name = ""
        self.category = ""
        self.initialAmount = 0.0
        self.isShowTotalAmount = false
        self.imageName = ""
        self.amount = 0.0
    }
    
    static func toAccountItme(account: Account) -> AccountItem{
        let accountItem = AccountItem()
        accountItem.name = account.name!
        accountItem.category = account.category!
        accountItem.imageName = account.imageName!
        accountItem.initialAmount = account.initialAmount
        accountItem.isShowTotalAmount = account.isShowTotalAmount
        return accountItem
    }
    
    static func searchAccount(accountItme: AccountItem) ->Account {
        let account: Account
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let  request = NSFetchRequest<Account>.init(entityName: "Account")
        let predicate = NSPredicate(format: "name = %@", accountItme.name)
        request.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(request)
            account = fetchedObjects.first!
        } catch {
            fatalError("查询错误：\(error)")
        }
        return account
    }
    
    static func searchAccounts() -> [AccountItem] {
        var AccountItems: [AccountItem] = []
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request = NSFetchRequest<Account>.init(entityName: "Account")
        do{
            let fetchObjects = try context.fetch(request)
            for account in fetchObjects {
                let accountItem = AccountItem()
                accountItem.name = account.name!
                accountItem.category = account.category!
                accountItem.initialAmount = account.initialAmount
                accountItem.isShowTotalAmount = account.isShowTotalAmount
                accountItem.imageName = account.imageName!
                accountItem.amount = account.amount
                AccountItems.append(accountItem)
            }
            
        } catch {
            print("error")
        }
        return AccountItems
    }
    
    static func updataAccount(accountItem: AccountItem) {
        let account: Account
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let  request = NSFetchRequest<Account>.init(entityName: "Account")
        let predicate = NSPredicate(format: "name = %@", accountItem.name)
        request.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(request)
            account = fetchedObjects.first!
            account.name = accountItem.name
            account.category = accountItem.category
            account.amount = accountItem.amount
            account.imageName = accountItem.imageName
            account.initialAmount = accountItem.initialAmount
            account.isShowTotalAmount = accountItem.isShowTotalAmount
            app.saveContext()
        } catch {
            fatalError("更新错误：\(error)")
        }
        
    }
    
    static func saveAccount(accountItem: AccountItem) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: app.persistentContainer.viewContext) as! Account
        account.name = accountItem.name
        account.category = accountItem.category
        account.amount = accountItem.amount
        account.imageName = accountItem.imageName
        account.initialAmount = accountItem.initialAmount
        account.isShowTotalAmount = accountItem.isShowTotalAmount
        app.saveContext()
    }
    
    static func seachBillsFromAccount(accountItem: AccountItem) -> [BillItem] {
        var billItems: [BillItem] = []
        let account = AccountItem.searchAccount(accountItme: accountItem)
        if let bills = account.account_bill {
            for bill in bills as NSSet {
                let billItem = BillItem()
                billItem.name = (bill as! Bill).name!
                billItem.account = AccountItem.toAccountItme(account: account)
                billItem.category = (bill as! Bill).category!
                billItem.date = (bill as! Bill).date!
                billItem.imageName = (bill as! Bill).imageName!
                billItem.price = (bill as! Bill).price
                billItem.remark = (bill as! Bill).remark!
                billItem.shop = (bill as! Bill).shop!
                billItem.tag = (bill as! Bill).tag!
                billItem.status = (bill as! Bill).status!
                billItems.append(billItem)
            }
        }
       return billItems
    }
    
    static func deleteAccount(accountItem: AccountItem) {
        let account: Account
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let  request = NSFetchRequest<Account>.init(entityName: "Account")
        let predicate = NSPredicate(format: "name = %@", accountItem.name)
        request.predicate = predicate
        do {
            let fetchedObjects = try context.fetch(request)
            account = fetchedObjects.first!
            context.delete(account)
            try context.save()
        } catch {
            print("删除错我")
        }
    }
}
