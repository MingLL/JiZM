//
//  MineViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import AAInfographics

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var amountView: AmountView!
    var chartView: AAChartView!
    var tabelView: UITableView!
    
    var accountItems: Dictionary<String,Array<AccountItem>> = Dictionary()
    var accountCategory: [String] = []
    
    var billItems: [BillItem] = []
    
    var allAccountAmount: Float = 0.0
    
    
    
    // MARK: - lifeStyle
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(systemName: "person")
        self.tabBarItem.title = "帐户总览"
        self.navigationItem.title = "帐户总览"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getAccountData()
        self.getBillData()
        self.creatViews()
        self.setUpCharts()
        tabelView.delegate = self
        tabelView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getAccountData()
        self.getBillData()
        self.tabelView.reloadData()
        var payDic: Dictionary<Int, Float> = Dictionary()
        var incomeDic: Dictionary<Int, Float> = Dictionary()
        var payArray: [Float] = []
        var incomeArray: [Float] = []
        for i in 1...12 {
            payDic[i] = 0.00
            incomeDic[i] = 0.00
        }
        for bill in self.billItems {
            let date = bill.date
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            if bill.status == "支出" {
                var temp =  payDic[month]!
                temp += bill.price
                payDic[month] = temp
            } else {
                var temp =  incomeDic[month]!
                temp += bill.price
                incomeDic[month] = temp
            }
        }
        
        for i in 1...12 {
            let payValue = payDic[i]!
            
            let incomeValue = incomeDic[i]!
            payArray.append(payValue)
            incomeArray.append(incomeValue)
        }
        
        self.chartView!.aa_onlyRefreshTheChartDataWithChartModelSeries([AASeriesElement()
            .name("支出")
            .data(payArray),
                                                                        AASeriesElement()
                                                                            .name("收入")
                                                                            .data(incomeArray)])
    }
    
    func creatViews() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(MineViewController.rightBtnClick))
        
        self.amountView = AmountView(frame: .zero)
        self.chartView = AAChartView(frame: .zero)
        self.tabelView = UITableView.init(frame: .zero)
        self.view.addSubview(self.amountView)
        self.view.addSubview(chartView)
        self.view.addSubview(tabelView)
        self.amountView.amountLabel.text = String(self.allAccountAmount)
        amountView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        chartView.snp.makeConstraints { (make) in
            make.top.equalTo(self.amountView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
        
        tabelView.snp.makeConstraints { (make) in
            make.top.equalTo(chartView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            
        }
    }
    
    
    func setUpCharts() {
        var payDic: Dictionary<Int, Float> = Dictionary()
        var incomeDic: Dictionary<Int, Float> = Dictionary()
        var payArray: [Float] = []
        var incomeArray: [Float] = []
        for i in 1...12 {
            payDic[i] = 0.00
            incomeDic[i] = 0.00
        }
        for bill in self.billItems {
            let date = bill.date
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            if bill.status == "支出" {
                var temp =  payDic[month]!
                temp += bill.price
                payDic[month] = temp
            } else {
                var temp =  incomeDic[month]!
                temp += bill.price
                incomeDic[month] = temp
            }
        }
        
        for i in 1...12 {
            let payValue = payDic[i]!
            
            let incomeValue = incomeDic[i]!
            payArray.append(payValue)
            incomeArray.append(incomeValue)
        }
        
        let chartModel = AAChartModel()
            .title("收支关系图")
            .chartType(.column)//图表类型
            .inverted(false)//是否翻转图形
            .yAxisTitle("金额")// Y 轴标题
            .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
            .tooltipValueSuffix("¥")//浮动提示框单位后缀
            .categories(["一月", "二月", "三月", "四月", "五月","六月","七月","八月","九月","十月","十一月","十二月"]).zoomType(.x)
            .colorsTheme(["#fe117c","#ffc069"])//主题颜色数组
            .series([
                AASeriesElement()
                    .name("支出")
                    .data(payArray),
                AASeriesElement()
                    .name("收入")
                    .data(incomeArray)
            ])
        chartView.aa_drawChartWithChartModel(chartModel)
    }
    
    
    
    // MARK: - tableViewDelegate
    
    //返回每个分组的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountItems.count
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
        if let accounts = accountItems[accountCategory[section]] {
            for account in accounts {
                num += account.amount
            }
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
            if account.amount < 0 {
                cell?.detailTextLabel?.textColor = .red
            }
            cell?.detailTextLabel?.text = String("¥\(account.amount)")
        }
        return cell!
    }
    
    //选中cell后的逻辑
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountKey = accountCategory[indexPath.section]
        if let accountValue = accountItems[accountKey] {
            let account = accountValue[indexPath.row]
            let detailVC = AccountDetailViewController(account: account)
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            //移除选定的数据
            let key =  accountCategory[indexPath.section]
            var keyValue = accountItems[key]!
            AccountItem.deleteAccount(accountItem: keyValue[indexPath.row])
            keyValue.remove(at: indexPath.row)
            //增加删除动画
            accountItems[key] = keyValue
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func getAccountData()  {
        self.allAccountAmount = 0.0
        self.accountItems.removeAll()
        self.accountCategory.removeAll()
        let datas = AccountItem.searchAccounts()
        for account in datas {
            if account.isShowTotalAmount {
                allAccountAmount += account.amount
            }
            if var keyValue = self.accountItems[account.category] {
                keyValue.append(account)
                self.accountItems[account.category] = keyValue
                
            } else {
                self.accountItems[account.category] = [account]
                self.accountCategory.append(account.category)
            }
        }
        print("")
    }
    
    func getBillData() {
        self.billItems.removeAll()
        for key in accountItems.keys {
            let keyValue = accountItems[key]!
            for value in keyValue {
                if value.isShowTotalAmount {
                    let bills = AccountItem.seachBillsFromAccount(accountItem: value)
                    for bill in bills {
                        self.billItems.append(bill)
                    }
                }
            }
        }
    }
    
    @objc func rightBtnClick() {
        let newAccountVC = NewAccountViewController()
        self.navigationController?.pushViewController(newAccountVC, animated: true)
    }
    
    
    
    
}
