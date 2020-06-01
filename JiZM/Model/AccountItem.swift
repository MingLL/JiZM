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
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (result : NSAsynchronousFetchResult!) in
            let fetchObjects:[Account] = result.finalResult!
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
        }
        
        do {
            try context.execute(asyncFetchRequest)
        } catch {
            print("error")
        }
        return AccountItems
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
}
