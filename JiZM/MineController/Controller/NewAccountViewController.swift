//
//  NewAccountViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/16.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var nameText: MyTextField!
    var priceText: MyTextField!
    var isShowTotalAmout: ItmeView!
    var categoryBtn: MyButton!
    
    var categoryPicker: UIPickerView!
    
    let accountCategorys = Plist.readAccountCategoryPlist()
    
    var accountCategory: String!
    
    var isShowTotalAmoutValue: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatView()
    }
    
    func creatView() {
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(NewAccountViewController.rightClick))
        
        nameText = MyTextField()
        priceText = MyTextField()
        isShowTotalAmout = ItmeView(frame: .zero, name: "是否展示在总额上", view: UISwitch())
        let switchBtn = isShowTotalAmout.typeView as! UISwitch
        switchBtn.addTarget(self, action: #selector(NewAccountViewController.switchBtnValueChange), for: .valueChanged)
        categoryBtn = MyButton()
        categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        nameText.placeholder = "名称"
        priceText.placeholder = "金额"
        
        categoryBtn.setTitle("账户分组", for: .normal)
        self.categoryBtn.setTitleColor(UIColor(0xFF7F50), for: .normal)
        categoryBtn.addTarget(self, action: #selector(NewAccountViewController.categoryBtnClick), for: .touchUpInside)
        
        self.view.addSubview(self.nameText)
        self.view.addSubview(self.priceText)
        self.view.addSubview(self.isShowTotalAmout)
        self.view.addSubview(self.categoryBtn)
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
        self.isShowTotalAmout.snp.makeConstraints { (make) in
            make.top.equalTo(self.priceText.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
        self.categoryBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.isShowTotalAmout.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(50)
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountCategorys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accountCategorys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.accountCategory = accountCategorys[row]
        self.categoryBtn.setTitle(accountCategorys[row], for: .normal)
    }
    
    
    @objc func categoryBtnClick() {
        
        self.view.addSubview(categoryPicker)
        categoryPicker.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
    }
    
    
    
    @objc func switchBtnValueChange() {
        let switchBtn = isShowTotalAmout.typeView as! UISwitch
        isShowTotalAmoutValue = switchBtn.isOn
    }
    
    @objc func rightClick() {
        let price = Float(self.priceText.text!)!
        let account = AccountItem(name: nameText.text!, category: accountCategory, initialAmount: price, isShowTotalAmount: isShowTotalAmoutValue, imageName: "")
        AccountItem.saveAccount(accountItem: account)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
