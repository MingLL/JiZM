//
//  MineViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import Foundation
import Charts
import SnapKit


class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var chartView: BarChartView!
    var tabelView: UITableView!
    
    var accountItems: Dictionary<String,Array<AccountItem>> = Dictionary()
    var accountCategory: [String] = []
    
    // MARK: - lifeStyle
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(systemName: "person")
        self.tabBarItem.title = "帐户总览"
        self.navigationItem.title = "帐户总览"
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatViews()
        self.getAccountData()
        tabelView.delegate = self
        tabelView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getAccountData()
        self.tabelView.reloadData()
    }
    
    func creatViews() {
        self.chartView = BarChartView.init(frame: .zero)
        self.tabelView = UITableView.init(frame: .zero)
        self.chartView.backgroundColor = .red
        self.tabelView.backgroundColor = .green
        self.view.addSubview(chartView)
        self.view.addSubview(tabelView)
        
        chartView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(300)
        }
        
        tabelView.snp.makeConstraints { (make) in
            make.top.equalTo(chartView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            
        }
    }
    
    
    // MARK: - tableViewDelegate
    
    //返回每个分组的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountCategory.count
    }
    
    //返回每个分组内数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountItems[accountCategory[section]]?.count ?? 0
    }
    
    //自定义分类头的设计
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView: UIView = UIView(frame: .zero)
        let categoryLabel: UILabel = UILabel(frame: .zero)
        let amountLabel: UILabel = UILabel(frame: .zero)
        categoryLabel.adjustsFontSizeToFitWidth = true
        amountLabel.adjustsFontSizeToFitWidth = true
        headView.addSubview(categoryLabel)
        headView.addSubview(amountLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview().offset(5)
        }
        amountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.top.bottom.equalToSuperview().offset(5)
        }
        categoryLabel.text = accountCategory[section]
        var num:Float = 0.0
        let accounts = accountItems[accountCategory[section]]!
        for account in accounts {
            num += account.amount
        }
        amountLabel.text = String(num)
        return headView
    }
    
    //自定义分类头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    //cell的装载
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = String(describing: UITableViewCell.self)
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
        }
        let accountKey = accountCategory[indexPath.section]
        if let accountValue = accountItems[accountKey] {
            let account = accountValue[indexPath.row]
            cell?.imageView?.image = UIImage(systemName: account.imageName)
            cell?.textLabel?.text = account.name
            cell?.detailTextLabel?.text = String("¥\(account.amount)")
        }
        return cell!
    }
    
    //选中cell后的逻辑
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountKey = accountCategory[indexPath.section]
        if let accountValue = accountItems[accountKey] {
            let account = accountValue[indexPath.row]
            let detailVC = DetailViewController(account: account)
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func getAccountData()  {
        self.accountItems.removeAll()
        let datas = AccountItem.searchAccounts()
        for account in datas {
            switch account.category {
            case "现金":
                if self.accountItems.keys.contains("现金") {
                    var keysValue = accountItems["现金"]!
                    keysValue.append(account)
                } else {
                    self.accountItems["现金"] = [account]
                }
            case "银行":
                if self.accountItems.keys.contains("银行") {
                    var keysValue = accountItems["银行"]!
                    keysValue.append(account)
                } else {
                    self.accountItems["银行"] = [account]
                }
            case "信用卡":
                if self.accountItems.keys.contains("信用卡") {
                    var keysValue = accountItems["信用卡"]!
                    keysValue.append(account)
                } else {
                    self.accountItems["信用卡"] = [account]
                }
            case "线上支付":
                if self.accountItems.keys.contains("线上支付") {
                    var keysValue = accountItems["线上支付"]!
                    keysValue.append(account)
                } else {
                    self.accountItems["线上支付"] = [account]
                }
            case "其他":
                if self.accountItems.keys.contains("其他") {
                    var keysValue = accountItems["其他"]!
                    keysValue.append(account)
                } else {
                    self.accountItems["其他"] = [account]
                }
            default:
                break
            }
        }
        for key in self.accountItems.keys {
            self.accountCategory.append(key)
        }
    }
    
}
