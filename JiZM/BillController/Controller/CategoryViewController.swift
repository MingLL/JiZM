//
//  CategoryViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/2.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let payCellID = "payCellID"
    
    let incomeCellID = "incomeCellID"
    
    var payCollectionView: UICollectionView!
    
    var incomeCollectionView: UICollectionView!
    
    var payLayout: UICollectionViewFlowLayout!
    
    var incomeLayout: UICollectionViewFlowLayout!
    
    var payDatas:[BillCategory] = []
    
    var incomeDatas: [String]!
    
    var payButton: UIButton!
    
    var incomeButton: UIButton!
    
    var categoryLabel: MyLabel!
    
    var categoryString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.setUpViews()
    }
    
    func setUpViews()  {
        self.payButton = UIButton(frame: .zero)
        self.incomeButton = UIButton(frame: .zero)
        self.payButton.setTitle("支出", for: .normal)
        self.incomeButton.setTitle("收入", for: .normal)
        self.payButton.setTitleColor(.black, for: .normal)
        self.incomeButton.setTitleColor(.black, for: .normal)
        self.payButton.setTitleColor(.red, for: .selected)
        self.incomeButton.setTitleColor(.red, for: .selected)
        self.payButton.isSelected = true
        self.categoryLabel = MyLabel(frame: .zero)
                
        
        payLayout = UICollectionViewFlowLayout()
        payLayout.itemSize = CGSize(width: 50, height: 50)
        payLayout.minimumLineSpacing = 3
        payLayout.minimumInteritemSpacing = 3
        payLayout.scrollDirection = .vertical
        incomeLayout = UICollectionViewFlowLayout()
        incomeLayout.itemSize = CGSize(width: 50, height: 50)
        incomeLayout.minimumLineSpacing = 3
        incomeLayout.minimumInteritemSpacing = 3
        incomeLayout.scrollDirection = .vertical
        self.payCollectionView = UICollectionView(frame: .zero, collectionViewLayout: payLayout)
        self.incomeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: incomeLayout)
        
        
        self.payCollectionView.backgroundColor = .white
        self.incomeCollectionView.backgroundColor = .white
        self.payCollectionView.tag = 100001
        self.incomeCollectionView.tag = 100002
        
        
        self.payCollectionView.delegate = self
        self.payCollectionView.dataSource = self
        
        
        self.incomeCollectionView.delegate = self
        self.incomeCollectionView.dataSource = self
        
        
        self.payCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: payCellID)
        
        
        self.incomeCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: incomeCellID)
        
        
        self.view.addSubview(self.payButton)
        self.view.addSubview(self.incomeButton)
        self.view.addSubview(self.payCollectionView)
        
        self.payButton.addTarget(self, action: #selector(CategoryViewController.payButtonClick), for: .touchUpInside)
        
        self.incomeButton.addTarget(self, action: #selector(CategoryViewController.incomeButtonClick), for: .touchUpInside)
        
        
        self.payButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(3)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.width.equalTo(70)
        }
        
        self.incomeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
            make.width.equalTo(70)
            
        }
        
        
        self.payCollectionView.snp.makeConstraints { (make) in
            make.top.top.equalTo(self.payButton.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    func getData() {
        let data = Plist.readBillCategoryPlist()
        incomeDatas = (data["收入"] as! Array<String>)
        let payKey = data["支出"] as! Dictionary<String, Any>
        for key in payKey.keys {
            let billCategory = BillCategory()
            billCategory.name = key
            billCategory.status = 0
            payDatas.append(billCategory)
        }
    }
    
    
    @objc func payButtonClick() {
        if self.incomeButton.isSelected {
            self.payButton.isSelected = true
            self.incomeButton.isSelected = false
        }
        
        if (self.view.viewWithTag(100002) != nil) {
            self.incomeCollectionView.removeFromSuperview()
        }
        if (self.view.viewWithTag(100001) == nil) {
            self.view.addSubview(self.payCollectionView)
            self.payCollectionView.snp.makeConstraints { (make) in
                make.top.top.equalTo(self.payButton.snp.bottom).offset(2)
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview()
            }
        }
        
    }
    
    @objc func incomeButtonClick() {
        if self.payButton.isSelected {
            self.payButton.isSelected = false
            self.incomeButton.isSelected = true
        }
        if (self.view.viewWithTag(100001) != nil) {
            self.incomeCollectionView.removeFromSuperview()
        }
        if (self.view.viewWithTag(100002) == nil) {
            self.view.addSubview(self.incomeCollectionView)
            self.incomeCollectionView.snp.makeConstraints { (make) in
                make.top.top.equalTo(self.payButton.snp.bottom).offset(2)
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    
    //MARK: -collectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100001 {
            return payDatas.count
        } else {
            return incomeDatas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100001 {
            let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: payCellID, for: indexPath) as! CategoryCollectionViewCell
            cell.setUpCell(string: payDatas[indexPath.row].name!, color: UIColor(0xF08080))
            return cell
        } else {
            let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: incomeCellID, for: indexPath) as! CategoryCollectionViewCell
            cell.setUpCell(string: incomeDatas[indexPath.row], color: UIColor(0x90EE90))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 100001 {
            if payDatas[indexPath.row].status == 0 {
                
                self.categoryString = payDatas[indexPath.row].name
                
                let name = payDatas[indexPath.row].name!
                let data = Plist.readBillCategoryPlist()
                let payKey = data["支出"] as! Dictionary<String, Any>
                let payValue = payKey[name] as! [String]
                payDatas.removeAll()
                let back = BillCategory()
                back.name = "返回"
                back.status = 1
                payDatas.append(back)
                for value in payValue {
                    let billCategory = BillCategory()
                    billCategory.name = value
                    billCategory.status = 1
                    payDatas.append(billCategory)
                }
                collectionView.reloadData()
            }else if payDatas[indexPath.row].status == 1{
                if payDatas[indexPath.row].name == "返回" {
                    let data = Plist.readBillCategoryPlist()
                    let payKey = data["支出"] as! Dictionary<String, Any>
                    payDatas.removeAll()
                    for key in payKey.keys {
                        let billCategory = BillCategory()
                        billCategory.name = key
                        billCategory.status = 0
                        payDatas.append(billCategory)
                    }
                    collectionView.reloadData()
                    
                } else {
                    collectionView.removeFromSuperview()
                    self.payButton.removeFromSuperview()
                    self.incomeButton.removeFromSuperview()
                    self.categoryLabel.text = payDatas[indexPath.row].name
                
                    self.categoryLabel.textInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
                    self.categoryLabel.setLabelColor(color: UIColor(0xF08080))
                    self.view.addSubview(self.categoryLabel)
                    self.categoryLabel.snp.makeConstraints { (make) in
                        make.top.equalToSuperview().offset(3)
                        make.left.equalToSuperview().offset(20)
                        make.height.equalTo(50)
                        make.width.equalTo(50)
                    }
                }
            }
            
        } else {
            self.categoryString = incomeDatas[indexPath.row]
            collectionView.removeFromSuperview()
            self.payButton.removeFromSuperview()
            self.incomeButton.removeFromSuperview()
            self.categoryLabel.text = incomeDatas[indexPath.row]
            self.categoryLabel.textInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
            self.categoryLabel.setLabelColor(color: UIColor(0x90EE90))
            self.view.addSubview(self.categoryLabel)
            self.categoryLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(3)
                make.left.equalToSuperview().offset(20)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
        }
    }
}
