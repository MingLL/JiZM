//
//  BillViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import FSCalendar

class BillViewController: UIViewController, FSCalendarDelegate,FSCalendarDataSource {
    
    var calendar: FSCalendar!
    
    var tableView: UITableView!
    
    var addBillButton: UIButton!
    
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
    
   
    
    
}