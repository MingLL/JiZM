//
//  NewBudgetViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/15.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class NewBudgetViewController: UIViewController {
    
    var nameText: MyTextField!
    var priceText: MyTextField!
    var beginTimeBtn: MyButton!
    var endTimeBtn: MyButton!
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    var beginTime: Date!
    var endTime: Date!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatViews()
        
    }
    func creatViews()  {
        self.view.backgroundColor = .white
        self.navigationItem.title = "新建项目"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(NewBudgetViewController.rightClick))
        self.nameText = MyTextField(frame: .zero)
        self.priceText = MyTextField(frame: .zero)
        self.beginTimeBtn = MyButton(frame: .zero)
        self.endTimeBtn = MyButton(frame: .zero)
        self.nameText.placeholder = "名称"
        self.priceText.placeholder = "项目金额"
        self.beginTimeBtn.setTitle("开始时间", for: .normal)
        self.beginTimeBtn.setTitleColor(UIColor(0xFF7F50), for: .normal)
        self.endTimeBtn.setTitle("结束时间", for: .normal)
        self.endTimeBtn.setTitleColor(UIColor(0xFF7F50), for: .normal)

        self.beginTimeBtn.addTarget(self, action: #selector(NewBudgetViewController.beginButtonClick), for: .touchUpInside)
        self.endTimeBtn.addTarget(self, action: #selector(NewBudgetViewController.endButtonClick), for: .touchUpInside)
        self.view.addSubview(self.nameText)
        self.view.addSubview(self.priceText)
        self.view.addSubview(self.beginTimeBtn)
        self.view.addSubview(self.endTimeBtn)
        self.nameText.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.priceText.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameText.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.beginTimeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.priceText.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.endTimeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.beginTimeBtn.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
    }
    
    @objc func beginButtonClick() {
        let dataPicker = EWDatePickerViewController()
        self.definesPresentationContext = true
        /// 回调显示方法
        dataPicker.backDate = { [weak self] date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let dateString: String = dateFormatter.string(from: date)
            self?.beginTimeBtn.setTitle(dateString, for: .normal)
            self?.beginTime = date
        }
        dataPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        dataPicker.picker.reloadAllComponents()
        /// 弹出时日期滚动到当前日期效果
        self.present(dataPicker, animated: true) {
            dataPicker.picker.selectRow(0, inComponent: 0, animated: true)
            dataPicker.picker.selectRow((self.currentDateCom.month!) - 1, inComponent: 1, animated:   true)
            
        }
    }
    
    @objc func endButtonClick() {
        let dataPicker = EWDatePickerViewController()
        self.definesPresentationContext = true
        /// 回调显示方法
        dataPicker.backDate = { [weak self] date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let dateString: String = dateFormatter.string(from: date)
            self?.endTimeBtn.setTitle(dateString, for: .normal)
            self?.endTime = date

        }
        dataPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        dataPicker.picker.reloadAllComponents()
        /// 弹出时日期滚动到当前日期效果
        self.present(dataPicker, animated: true) {
            dataPicker.picker.selectRow(0, inComponent: 0, animated: true)
            dataPicker.picker.selectRow((self.currentDateCom.month!) - 1, inComponent: 1, animated:   true)
            dataPicker.picker.selectRow((self.currentDateCom.day!) - 1, inComponent: 2, animated: true)
        }
    }
    
    @objc func rightClick() {
        let price = Float(self.priceText.text!)!
        let project = ProjectItem(name: self.nameText.text!, beginDate: beginTime, endDate: endTime, totalAmount: price  , imageName: "")
        ProjectItem.saveProject(projectItem: project)
        self.navigationController?.popViewController(animated: true)
    }

}
