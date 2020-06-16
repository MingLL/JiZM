//
//  AllFormViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/10.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class AllFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    var priceTableView: UITableView!
    var categoryCollectionView: UICollectionView!
    var topTabelView: UITableView!
    
    
    var ways = ["支出", "收入"]
    
    var billItems: [BillItem] = []
    
    var wayAmount: [String: Float] = ["支出": 0.0, "收入": 0.0]
    
    var categoryAmounts:[CategoryAmount] = []
    
    var counts: [Int] = [0, 0]
    
    var allAmount: Float = 0.0
    
    let categoryColor = [0xFF1493, 0x9400D3, 0x00FFFF]
    
    let wayColor = [0xFF4500,0x00FF7F]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBillDatas()
        self.creatViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getBillDatas()
        self.creatViews()
    }
    
    func creatViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 200)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        self.priceTableView = UITableView(frame: .zero)
        self.topTabelView = UITableView(frame: .zero)
        self.categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.categoryCollectionView.backgroundColor = .white
        
        
        self.view.addSubview(self.priceTableView)
        self.view.addSubview(self.categoryCollectionView)
        self.view.addSubview(self.topTabelView)
        self.priceTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(130)
        }
        
        self.categoryCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.priceTableView.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(200)
        }
        
        self.topTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.categoryCollectionView.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.bottom.equalToSuperview()
        }
        
        self.priceTableView.tag = 1001
        self.priceTableView.isScrollEnabled = false
        self.priceTableView.delegate = self
        self.priceTableView.dataSource = self
        self.topTabelView.tag = 1002
        self.topTabelView.isScrollEnabled = false
        self.topTabelView.delegate = self
        self.topTabelView.dataSource = self
        
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(CategoryFormCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        
    }
    
    //MARK: --tabelViewDetegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1001 {
            return ways.count
        } else {
            if billItems.count < 3 {
                return billItems.count
            } else {
                return 3
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1001 {
            var cell: JZWayTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "JZCell") as? JZWayTableViewCell
            if cell == nil {
                cell = JZWayTableViewCell(style: .default, reuseIdentifier: "JZCell")
            }
            let amount = wayAmount[ways[indexPath.row]]!
            let progress: Float
            if allAmount == 0 {
                progress = 0.0
            } else {
                progress = amount / allAmount
            }
            
            cell?.setUpForCell(progress: progress, color:UIColor.hexColor(wayColor[indexPath.row]) , amount: amount, count: counts[indexPath.row], name: ways[indexPath.row])
            
            return cell!
        } else {
            var cell: BillTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "BillCell") as? BillTableViewCell
            if cell == nil {
                cell = BillTableViewCell(style: .default, reuseIdentifier: "BillCell")
            }
            let bill = billItems[indexPath.row]
            cell?.setBillItemForCell(bill: bill)
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1002 {
            return 80
        } else {
            return 50
        }
    }
    
    
    //MARK: -collectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoryAmounts.count < 3 {
            return categoryAmounts.count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryFormCollectionViewCell
        let payValue = wayAmount["支出"]!
        let progress = categoryAmounts[indexPath.row].price / payValue
        cell.setUpCell(color: UIColor.hexColor(categoryColor[indexPath.row]), progress: Double(progress), name: categoryAmounts[indexPath.row].name, price: categoryAmounts[indexPath.row].price)
        return cell
    }
    
    //MARK: - data
    func getBillDatas() {
        if billItems.count != 0 {
            billItems.removeAll()
        }
        
        wayAmount = ["支出": 0.0, "收入": 0.0]
        
        categoryAmounts.removeAll()
        
        counts = [0, 0]
        
        allAmount = 0.0
        
        self.billItems = BillItem.searchBills()
        for bill in billItems {
            self.allAmount += bill.price
            
            var temp = self.wayAmount[bill.status]!
            temp += bill.price
            if bill.status == "支出" {
                counts[0] += 1
            } else {
                counts[1] += 1
            }
            self.wayAmount[bill.status] = temp
            
            if bill.status == "支出"{
                
                for category in self.categoryAmounts {
                    if bill.category == category.name {
                        category.price += bill.price
                        break
                    } else {
                        let cateAmount = CategoryAmount()
                        cateAmount.name = bill.category
                        cateAmount.price = bill.price
                        self.categoryAmounts.append(cateAmount)
                        break
                    }
                }
                
                if self.categoryAmounts.count == 0 {
                    
                    let cateAmount = CategoryAmount()
                    cateAmount.name = bill.category
                    cateAmount.price = bill.price
                    self.categoryAmounts.append(cateAmount)
                }
            }
            
            self.categoryAmounts.sort(by: {$0.price > $1.price})
            self.billItems.sort(by: {$0.price > $1.price})
        }
    }
    
}
