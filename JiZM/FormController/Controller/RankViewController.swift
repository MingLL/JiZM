//
//  RankViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/10.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var billTabelView: UITableView!
    
    var billDatas: [BillItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBillDatas()
        self.creatViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getBillDatas()
        self.billTabelView.reloadData()
    }
    
    func creatViews() {
        billTabelView = UITableView(frame: .zero)
        billTabelView.delegate = self
        billTabelView.dataSource = self
        self.view.addSubview(self.billTabelView)
        billTabelView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getBillDatas() {
        billDatas.removeAll()
        let data = BillItem.searchBills()
        for bill in data {
            if bill.status == "支出" {
                billDatas.append(bill)
            }
        }
        self.billDatas.sort(by: {$0.price > $1.price})
    }
    
    //MARK: -tabelViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: BillTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RankFormCell") as? BillTableViewCell
        if cell == nil {
            cell = BillTableViewCell(style: .default, reuseIdentifier: "RankFormCell")
        }
        let bill = billDatas[indexPath.row]
        cell?.setBillItemForCell(bill: bill)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
