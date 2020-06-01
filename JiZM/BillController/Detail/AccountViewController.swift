//
//  AccountViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/1.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tabelView: UITableView!
    
    var accountItems: Dictionary<String,Array<AccountItem>> = ["现金":[AccountItem(name: "钱包", category: "现金", initialAmount: 1500.0, isShowTotalAmount: true, imageName: "0.circle")],"银行卡":[AccountItem(name: "生活费", category: "银行卡", initialAmount: 1000.0, isShowTotalAmount: true, imageName: "01.circle")],"线上交易":[AccountItem(name: "支付宝", category: "线上交易", initialAmount: 10000.0, isShowTotalAmount: true, imageName: "02.circle"),AccountItem(name: "微信", category: "线上交易", initialAmount: 1234.0, isShowTotalAmount: false, imageName: "03.circle")]]
    var accountCategory = ["现金", "银行卡", "线上交易"]
    
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
        tabelView.delegate = self
        tabelView.dataSource = self
    }
    
    func creatViews() {
        self.tabelView = UITableView.init(frame: .zero)
        self.tabelView.backgroundColor = .green
        self.view.addSubview(tabelView)
        
        tabelView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "accountName"), object:account.name)
            }
        }
    }
    
    
}
