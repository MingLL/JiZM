//
//  BillViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import FSCalendar

class BillViewController: UIViewController, FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource {
    
    
    var calendar: FSCalendar!
    
    
    
    var tableView: UITableView!
    
    var addBillButton: UIButton!
    
    var billItems: [BillItem] = []
    
    var currentBills: [BillItem] = []
    
    var currentDate: Date = Date()
    
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
        self.getBillDatas()
        self.getCurrentBills()
        self.creatCalendar()
        self.creatTableView()
        self.creatButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getBillDatas()
        self.getCurrentBills()
        self.tableView.reloadData()
        self.calendar.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(BillViewController.isWarning(isWarning:)), name: NSNotification.Name(rawValue: "Warningprompt"), object: nil)
        
    }
    
    func getBillDatas() {
        self.billItems = BillItem.searchBills()
    }
    
    func getCurrentBills() {
        self.currentBills.removeAll()
        for bill in self.billItems {
            let date = bill.date
            if Calendar.current.isDate(date, inSameDayAs: self.currentDate) {
                self.currentBills.append(bill)
            }
        }
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
        self.addBillButton.addTarget(self, action: #selector(BillViewController.clickButton), for: .touchUpInside)
        
    }
    
    @objc func clickButton() {
        let newBillVC = NewBillViewController(date: self.currentDate)
        newBillVC.modalPresentationStyle = .fullScreen
        self.present(newBillVC, animated: true, completion: nil)
    }
    
    
    //MARK: - tableView delegate and dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentBills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = String(describing: BillTableViewCell.self)
        var cell: BillTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? BillTableViewCell
        if cell == nil {
            cell = BillTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        let bill = currentBills[indexPath.row]
        cell?.setBillItemForCell(bill: bill)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            //移除选定的数据
            BillItem.deleteBill(billItem: currentBills[indexPath.row])
            currentBills.remove(at: indexPath.row)
            //增加删除动画
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    
    //MARK: -FSCalendar
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.currentDate = date
        self.currentBills.removeAll()
        self.getCurrentBills()
        self.tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if Calendar.current.isDateInToday(date) {
            return "今"
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        for bill in self.billItems {
            if Calendar.current.isDate(bill.date, inSameDayAs: date) {
                return 3
            }
        }
        return 0
    }
    
    @objc func isWarning(isWarning: NSNotification) {
        if let isW = isWarning.object as? Bool {
            if isW {
                DispatchQueue.main.async {
                    UIAlertController.showAlert(message: "已经消费预算的75%，请谨慎消费", in: self)
                }
            }
        }
    }
    
}
