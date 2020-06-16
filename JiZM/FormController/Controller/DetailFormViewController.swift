//
//  DetailViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/10.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import AAInfographics
import SnapKit

class DetailFormiewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var chartView: AAChartView!
    
    var billTableView: UITableView!
    
    var billDatas: Dictionary<Int, Array<BillItem>> = Dictionary()
    
    var payBillDatas: Dictionary<Int, Float> = Dictionary()
    
    var incomeBillDatas: Dictionary<Int, Float> = Dictionary()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBillDatas()
        self.creatViews()
        self.setUpChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getBillDatas()
        self.billTableView.reloadData()
        var paydata: [Float] = []
        var incomeData: [Float] = []
        for i in 1...12 {
            let pay = self.payBillDatas[i]!
            let income = self.incomeBillDatas[i]!
            paydata.append(pay)
            incomeData.append(income)
        }
        self.chartView!.aa_onlyRefreshTheChartDataWithChartModelSeries([AASeriesElement()
            .name("支出")
            .data(paydata),
                                                                        AASeriesElement()
                                                                            .name("收入")
                                                                            .data(incomeData)])
    }
    
    func getBillDatas() {
        billDatas.removeAll()
        payBillDatas.removeAll()
        incomeBillDatas.removeAll()
        let bills = BillItem.searchBills()
        //初始化
        for i in 1...12 {
            self.billDatas[i] = Array<BillItem>()
            self.payBillDatas[i] = 0.0
            self.incomeBillDatas[i] = 0.0
        }
        
        for bill in bills {
            let date = bill.date
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            
            var array = billDatas[month]!
            array.append(bill)
            billDatas[month] = array
            
            
            if bill.status == "支出" {
                var temp = self.payBillDatas[month]!
                temp += bill.price
                self.payBillDatas[month] = temp
            } else {
                var temp = self.incomeBillDatas[month]!
                temp += bill.price
                self.incomeBillDatas[month] = temp
            }
            
        }
    }
    
    func creatViews() {
        self.chartView = AAChartView(frame: .zero)
        self.billTableView = UITableView(frame: .zero)
        self.billTableView.delegate = self
        self.billTableView.dataSource = self
        self.view.addSubview(self.chartView)
        self.view.addSubview(self.billTableView)
        self.chartView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(200)
        }
        
        self.billTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.chartView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().offset(3)
            make.bottom.equalToSuperview()
        }
    }
    
    func setUpChart() {
        var paydata: [Float] = []
        var incomeData: [Float] = []
        for i in 1...12 {
            let pay = self.payBillDatas[i]!
            let income = self.incomeBillDatas[i]!
            paydata.append(pay)
            incomeData.append(income)
        }
        let chartModel = AAChartModel()
            .chartType(.spline)
            .markerRadius(0)
            .title("年度消费曲线图")//图表主标题
            .inverted(false)//是否翻转图形
            .yAxisTitle("金额")// Y 轴标题
            .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
            .tooltipValueSuffix("元")//浮动提示框单位后缀
            .categories(["一月", "二月", "三月", "四月", "五月","六月","七月","八月","九月","十月","十一月","十二月"])
            .colorsTheme(["#fe117c","#00FA9A"])//主题颜色数组
            .series([
                AASeriesElement()
                    .name("支出")
                    .data(paydata)
                    .toDic()!,
                AASeriesElement()
                    .name("收入")
                    .data(incomeData)
                    .toDic()!])
        chartView.aa_drawChartWithChartModel(chartModel)
        
    }
    
    //MARK: - tableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return billDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billDatas[section + 1]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: BillTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "FormBillCell") as? BillTableViewCell
        if cell == nil {
            cell = BillTableViewCell(style: .default, reuseIdentifier: "FormBillCell")
        }
        let keyValue = billDatas[indexPath.section + 1]!
        let bill = keyValue[indexPath.row]
        cell?.setBillItemForCell(bill: bill)
        return cell!
    }
    //自定义分类头的设计
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView: UIView = UIView(frame: .zero)
        let label: UILabel = UILabel(frame: .zero)
        headView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        label.textAlignment = .center
        label.text = "\(section + 1)月"
        let view: UIView = UIView()
        headView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
            make.height.equalTo(3)
        }
        view.backgroundColor = UIColor(0x808080)
        
        return headView
    }
    
    //自定义分类头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
