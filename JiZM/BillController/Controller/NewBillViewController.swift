//
//  NewBillViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/1.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import Customkeyboard

class NewBillViewController: UIViewController {
    
    var blackView: UIView!
    var imageView: UIImageView!
    var priceInputLabel: MyTextField!
    var nameInputLabel: MyTextField!
    var accountButton: MyButton!
    var projectButton: MyButton!
    var shopInputLabel: MyTextField!
    var modeButton: MyButton!
    var dateButtion: MyButton!
    var timeButton: MyButton!
    var remarkInputLabel: UITextView!
    var addButton: UIButton!
    var currentDate: Date?
    
    
    init(date: Date) {
        self.currentDate = date
        super.init(nibName: nil, bundle: nil)
        self.title = "新建记录"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatViews()
        creatAddButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(NewBillViewController.setAccountButtonTitle(title:)), name: NSNotification.Name(rawValue: "accountName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewBillViewController.setProjectButtonTitle(title:)), name: NSNotification.Name(rawValue: "projectName"), object: nil)
    }
    
    private func creatAddButton() {
        addButton = UIButton(frame: .zero)
        addButton.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
        addButton.addTarget(self, action: #selector(ClickButton), for: .touchUpInside)
        self.view.addSubview(self.addButton)
        self.addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-25)
            make.width.height.equalTo(20)
        }
        let cancelButton = UIButton()
        self.view.addSubview(cancelButton)
        cancelButton.setImage(UIImage(systemName: "multiply", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
        cancelButton.addTarget(self, action: #selector(NewBillViewController.cancelButtonClick), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(25)
            make.width.height.equalTo(20)
        }
    }
    
    @objc func ClickButton() {
        self.saveData()
        let alart = UILabel()
        alart.text = "保存成功"
        alart.font = UIFont.systemFont(ofSize: 17)
        alart.textAlignment = .center
        alart.backgroundColor = .orange
        alart.layer.cornerRadius = 5
        
        UIView.animate(withDuration: 1, animations: {
            self.view.addSubview(alart)
            alart.snp.makeConstraints { (make) in
                make.centerY.centerX.equalToSuperview()
            }
        }) { (b:Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alart.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    private func saveData() {
        
    }
    
    private func creatViews() {
        
        blackView = UIView(frame: .zero)
        imageView = UIImageView(frame: .zero)
        priceInputLabel = MyTextField(frame: .zero)
        nameInputLabel = MyTextField(frame: .zero)
        shopInputLabel = MyTextField(frame: .zero)
        remarkInputLabel = UITextView(frame: .zero)
        accountButton = MyButton(frame: .zero)
        projectButton = MyButton(frame: .zero)
        modeButton = MyButton(frame: .zero)
        dateButtion = MyButton(frame: .zero)
        timeButton = MyButton(frame: .zero)
        imageView.image = UIImage(systemName: "photo")
        
        self.view.addSubview(blackView)
        self.view.addSubview(imageView)
        self.view.addSubview(priceInputLabel)
        self.view.addSubview(nameInputLabel)
        self.view.addSubview(shopInputLabel)
        self.view.addSubview(remarkInputLabel)
        self.view.addSubview(accountButton)
        self.view.addSubview(projectButton)
        self.view.addSubview(modeButton)
        self.view.addSubview(dateButtion)
        self.view.addSubview(timeButton)
        
        accountButton.addTarget(self, action: #selector(NewBillViewController.accountButtonClick), for: .touchUpInside)
        accountButton.setTitleColor(.red, for: .normal)
        
        projectButton.addTarget(self, action: #selector(NewBillViewController.projectButtonClick), for: .touchUpInside)
        projectButton.setTitleColor(.red, for: .normal)
        
        
        priceInputLabel.textAlignment = .right
        priceInputLabel.placeholder = "金额"
        priceInputLabel.textColor = .black
        let keyboard = CustomKeyboard(view, field: priceInputLabel)
        keyboard.keyboardStyle = .number
        keyboard.isEnableKeyboard = true
        keyboard.whetherHighlight = true
        keyboard.frame.size.height = 300
        keyboard.customDoneButton(title: "确定", titleColor: .white, theme: .blue, target: self, callback: nil)
        priceInputLabel.becomeFirstResponder()
        
        
        nameInputLabel.textAlignment = .right
        nameInputLabel.textColor = .black
        nameInputLabel.placeholder = "名称"
        
        shopInputLabel.textAlignment = .center
        shopInputLabel.textColor = .black
        shopInputLabel.placeholder = "商店"
        
        remarkInputLabel.textAlignment = .left
        remarkInputLabel.textColor = UIColor.black
        remarkInputLabel.backgroundColor = UIColor.clear
        remarkInputLabel.layer.borderWidth = 0.5
        remarkInputLabel.layer.borderColor = UIColor.gray.cgColor
        remarkInputLabel.insertText("备注信息:")
        
        
        self.currentDate = Date()
        
        dateButtion.setTitle(self.getCurrentDate(), for: .normal)
        timeButton.setTitle(self.getCurrentTime(), for: .normal)

        dateButtion.setTitleColor(.red, for: .normal)
        timeButton.setTitleColor(.red, for: .normal)
        
        
        
        blackView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(100)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(blackView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        priceInputLabel.snp.makeConstraints { (make) in
            make.top.equalTo(blackView.snp.bottom).offset(10)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(45)
        }
        nameInputLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceInputLabel.snp.bottom).offset(10)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(45)
        }
        accountButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        projectButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        shopInputLabel.snp.makeConstraints { (make) in
            make.top.equalTo(accountButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        modeButton.snp.makeConstraints { (make) in
            make.top.equalTo(projectButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        
        dateButtion.snp.makeConstraints { (make) in
            make.top.equalTo(shopInputLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        timeButton.snp.makeConstraints { (make) in
            make.top.equalTo(modeButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        remarkInputLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateButtion.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(150)
        }
        
        
        
    }
    
    private func getCurrentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        return dateformatter.string(from: self.currentDate ?? Date())
    }
    
    private func getCurrentDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY/MM/dd"
        return dateformatter.string(from: self.currentDate ?? Date())
    }
    
    
    @objc func accountButtonClick() {
        let accountVC = AccountViewController()
        self.present(accountVC, animated: false, completion: nil)
    }
    
    @objc func projectButtonClick() {
        let projectVC = ProjectViewController()
        self.present(projectVC, animated: false, completion: nil)
    }
    
    @objc func setAccountButtonTitle(title: NSNotification) {
        if let name = title.object as? String {
            accountButton.setTitle(name, for: .normal)
        }
    }
    
    @objc func setProjectButtonTitle(title: NSNotification) {
        if let name = title.object as? String {
            projectButton.setTitle(name, for: .normal)
        }
    }

    @objc func cancelButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
}
