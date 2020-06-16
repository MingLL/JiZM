//
//  TransactionViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/15.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let account: AccountItem
    
    var priceTableView: UITableView!
    var billTableView: UITableView!
    
    var ways = ["支出", "收入"]
    var wayAmount: [String: Float] = ["支出": 0.0, "收入": 0.0]
    let wayColor = [0xFF4500,0x00FF7F]
    var allAmount: Float = 0.0
    var counts: [Int] = [0,0]
    var billDatas: [BillItem] = []
    
    init(account: AccountItem) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDatas()
        self.creatViews()
        // Do any additional setup after loading the view.
    }
    
    func creatViews() {
        self.priceTableView = UITableView(frame: .zero)
        self.billTableView = UITableView(frame: .zero)
        self.priceTableView.tag = 101
        self.billTableView.tag = 102
        self.priceTableView.delegate = self
        self.billTableView.delegate = self
        
        self.priceTableView.dataSource = self
        self.billTableView.dataSource = self
        self.view.addSubview(self.priceTableView)
        self.view.addSubview(self.billTableView)
        self.priceTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(130)
        }
        self.billTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.priceTableView.snp.bottom).offset(3)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: -tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return ways.count
        } else {
            return billDatas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 101 {
            var cell: JZWayTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "JZCell") as? JZWayTableViewCell
            if cell == nil {
                cell = JZWayTableViewCell(style: .default, reuseIdentifier: "JZCell")
            }
            let amount = wayAmount[ways[indexPath.row]]!
            let progress: Float
            if allAmount == 0 {
                progress = 0.0
            } else {
                progress = amount / allAmount
            }
            cell?.setUpForCell(progress: progress, color:UIColor.hexColor(wayColor[indexPath.row]) , amount: amount, count: counts[indexPath.row], name: ways[indexPath.row])
            
            return cell!
        } else {
            var cell: BillTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "BillCell") as? BillTableViewCell
            if cell == nil {
                cell = BillTableViewCell(style: .default, reuseIdentifier: "BillCell")
            }
            let bill = billDatas[indexPath.row]
            cell?.setBillItemForCell(bill: bill)
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 102 {
            return 80
        } else {
            return 50
        }
    }
    
    
    func getDatas() {
        self.billDatas = AccountItem.seachBillsFromAccount(accountItem: self.account)
        for bill in self.billDatas {
            self.allAmount += bill.price
            var temp = wayAmount[bill.status]!
            temp += bill.price
            wayAmount[bill.status] = temp
            if bill.status == "支出" {
                counts[0] += 1
            } else {
                counts[1] += 1
            }
        }
    }
    
    
    
}
