//
//  CategoryViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/10.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import AAInfographics

class CategoryFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var chartView: AAChartView!
    var categoryTabelView: UITableView!
    
    
    var billCategoryDic: Dictionary<String, Float> = Dictionary()
    var billArray: [BillItem] = []
    
    var categoryArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategoryData()
        self.creatViews()
        self.setUpChart()
        
    }
    
    func getCategoryData() {
        let datas = BillItem.searchBills()
        for bill in datas {
            if bill.status == "支出" {
                if var temp = billCategoryDic[bill.category] {
                    temp += bill.price
                    billCategoryDic[bill.category] = temp
                } else {
                    billCategoryDic[bill.category] = bill.price
                    categoryArray.append(bill.category)
                }
            }
        }
    }
    
    func setUpChart() {
        
        var data: Array<Any> = Array()
        for key in billCategoryDic.keys {
            let temp = [key as String, billCategoryDic[key]!] as [Any]
            data.append(temp)
        }
        
        
        // 初始化图表模型
        let chartModel = AAChartModel()
            .chartType(.pie) //图表类型
            .title("分类统计")//图表主标题
            .inverted(false)//是否翻转图形
            .dataLabelsEnabled(true)
            .series(
                [
                    AASeriesElement()
                        .name("消费金额")
                        .allowPointSelect(false)
                        .data(data).toDic()!,
                ]
        )
        
        // 图表视图对象调用图表模型对象,绘制最终图形
        self.chartView.aa_drawChartWithChartModel(chartModel)
    }
    
    
    func creatViews() {
        self.chartView = AAChartView(frame: .zero)
        self.categoryTabelView = UITableView(frame: .zero)
        self.categoryTabelView.delegate = self
        self.categoryTabelView.dataSource = self
        self.view.addSubview(self.chartView)
        self.view.addSubview(self.categoryTabelView)
        self.chartView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(350)
        }
        
        self.categoryTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.chartView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().offset(3)
            make.bottom.equalToSuperview()
        }
    }
    
    
    //    MARK: -tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billCategoryDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "categoryFormCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "categoryFormCell")
        }
        let key = categoryArray[indexPath.row]
        let price = billCategoryDic[key]!
        cell?.textLabel?.text = key
        cell?.detailTextLabel?.text = String(price)
        return cell!
    }
    
}
