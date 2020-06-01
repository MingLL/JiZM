//
//  BillViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import FSCalendar

class BillViewController: UIViewController, FSCalendarDelegate,FSCalendarDataSource,UITableViewDelegate, UITableViewDataSource {
    
    
    var calendar: FSCalendar!
    
    var tableView: UITableView!
    
    var addBillButton: UIButton!
    
    var billItems: [BillItem] = [BillItem(price: 150.0, name: "午餐", status: "收入", category: "餐饮", account: AccountItem(name: "生活费", category: "线上支付", initialAmount: 1500.0, isShowTotalAmount: true, describe: "", imageName: ""), project: ProjectItem(name: "生活消费", beginDate: Date(), endDate:Date(timeIntervalSinceNow: 86400) , totalAmount: 1500.0, imageName: ""), shop: "", date: Date(), time: "", tag: "", remark: "", imageName: "0.circle")]
    
    init() {
        self.calendar = FSCalendar(frame: .zero)
        self.tableView = UITableView(frame: .zero)
        self.addBillButton = UIButton(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "记账"
        self.tabBarItem.image = UIImage(systemName: "plus")
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatCalendar()
        self.creatTableView()
        self.creatButton()
    }
    
    func creatTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.calendar.snp.bottom).offset(3)
            make.left.bottom.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
        }
        
        
    }
    
    func creatCalendar()  {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.appearance.headerDateFormat = "yyyy/MM"
        self.calendar.locale = Locale(identifier: "zh_CN")
        self.calendar.appearance.borderSelectionColor = UIColor.red
        self.calendar.appearance.selectionColor = UIColor.clear
        self.calendar.appearance.todayColor = UIColor.clear
        self.calendar.appearance.titleDefaultColor = UIColor.black
        self.calendar.appearance.titleSelectionColor = UIColor.black
        self.calendar.appearance.titleTodayColor = UIColor.black
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        self.calendar.select(Date())
        
        self.view.addSubview(self.calendar)
        self.calendar.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(300)
        }
    }
    
    func creatButton() {
        self.view.addSubview(self.addBillButton)
        self.view.bringSubviewToFront(self.addBillButton)
        addBillButton.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        self.addBillButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-5)
            make.height.width.equalTo(50)
        }
        
    }
    
    
    //MARK: - tableView delegate and dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = String(describing: BillTableViewCell.self)
        var cell: BillTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? BillTableViewCell
        if cell == nil {
            cell = BillTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        let bill = billItems[indexPath.row]
        cell?.setBillItemForCell(bill: bill)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
