//
//  CategoryViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/2.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    var payCollectionView: UICollectionView!
    
    var incomeCollectionView: UICollectionView!
    
    var layout: UICollectionViewFlowLayout!
    
    
    var payDatas:[BillCategory] = []
    
    var incomeData: [String]!
    
    var payButton: UIButton!
    
    var incomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.setUpViews()
    }
    
    func setUpViews()  {
        self.payButton = UIButton(frame: .zero)
        self.incomeButton = UIButton(frame: .zero)
        self.payButton.setTitle("收入", for: .normal)
        self.incomeButton.setTitle("支出", for: .normal)
        self.payButton.setTitleColor(.black, for: .normal)
        self.incomeButton.setTitleColor(.black, for: .normal)
        self.payButton.setTitleColor(.red, for: .selected)
        self.incomeButton.setTitleColor(.red, for: .selected)
        self.payButton.isSelected = true
        layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        self.payCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.incomeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.payCollectionView.tag = 100001
        self.incomeCollectionView.tag = 100002
        self.payCollectionView.delegate = self
        self.payCollectionView.dataSource = self
        
        
        self.incomeCollectionView.delegate = self
        self.incomeCollectionView.dataSource = self
        self.payCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "100001")
        self.incomeCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "100002")
        
        
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
            make.right.equalToSuperview().offset(-2)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    func getData() {
        let data = Plist.readBillCategoryPlist()
        incomeData = (data["收入"] as! Array<String>)
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
                make.right.equalToSuperview().offset(-2)
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
                make.right.equalToSuperview().offset(-2)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    
//MARK: -collectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return payDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "100001", for: indexPath)
            let label = UILabel(frame: .zero)
            label.text = payDatas[indexPath.row].name
            label.adjustsFontSizeToFitWidth = true
            cell.contentView.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.centerX.centerY.equalToSuperview()
                make.height.equalTo(35)
            }
            return cell
       
    }
}
