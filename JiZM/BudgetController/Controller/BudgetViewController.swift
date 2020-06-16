//
//  BudgetViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class BudgetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!
    
    var projectItems: Dictionary<String,Array<ProjectItem>> = Dictionary()
    
    var projectCategory:[String] = ["进行中", "未开始", "已结束"]
    // MARK: - lifeStyle
    init() {
        self.tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(systemName: "creditcard", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        self.tabBarItem.title = "项目/预算"
        self.navigationItem.title = "项目/预算"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProjectDatas()
        self.setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getProjectDatas()
        self.tableView.reloadData()
    }
    
    func setUpViews() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(BudgetViewController.rightBtnClick))
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - tableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return projectCategory.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return projectCategory[section]
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectItems[projectCategory[section]]?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = String(describing: ProjectTableViewCell.self)
        var cell: ProjectTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? ProjectTableViewCell
        if cell == nil {
            cell = ProjectTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        let projectKey = projectCategory[indexPath.section]
        if let projectValue = projectItems[projectKey] {
            let project = projectValue[indexPath.row]
            cell?.setProjectItemForCell(project: project)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            //移除选定的数据
            let key =  projectCategory[indexPath.section]
            var keyValue = projectItems[key]!
            ProjectItem.deleteProject(projectItem: keyValue[indexPath.row])
            keyValue.remove(at: indexPath.row)
            //增加删除动画
            projectItems[key] = keyValue
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func getProjectDatas() {
        self.projectItems.removeAll()
        let datas = ProjectItem.searchProjects()
        for project in datas {
            switch project.status {
            case projectCategory[0]:
                if self.projectItems["进行中"] != nil {
                    var keyValue = self.projectItems["进行中"]
                    keyValue!.append(project)
                    self.projectItems["进行中"] = keyValue
                } else {
                    self.projectItems["进行中"] = [project]
                }
            case projectCategory[1]:
                if self.projectItems["未开始"] != nil {
                    var keyValue = self.projectItems["未开始"]
                    keyValue!.append(project)
                    self.projectItems["未开始"] = keyValue
                } else {
                    self.projectItems["未开始"] = [project]
                }
            case projectCategory[2]:
                if self.projectItems["已结束"] != nil {
                    var keyValue = self.projectItems["已结束"]
                    keyValue!.append(project)
                    self.projectItems["已结束"] = keyValue
                } else {
                    self.projectItems["已结束"] = [project]
                }
            default:
                print("error")
            }
        }
    }
    
    @objc func rightBtnClick() {
        let NewBudgetVC = NewBudgetViewController()
        self.navigationController?.pushViewController(NewBudgetVC, animated: true)
    }
    
}
