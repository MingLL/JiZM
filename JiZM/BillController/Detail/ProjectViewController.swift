//
//  ProjectViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/1.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var projectItems: Dictionary<String,Array<ProjectItem>> = ["进行中":[ProjectItem(name: "生活消费", beginDate: Date(), endDate: Date(timeIntervalSinceNow: 86400), totalAmount: 1500.0, imageName: "03.circle")]]
    
    var projectCategory:[String] = ["进行中", "未开始", "已结束"]
    // MARK: - lifeStyle
    init() {
        self.tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(systemName: "creditcard", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        self.tabBarItem.title = "项目"
        self.navigationItem.title = "项目"
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    func setUpViews() {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectKey = projectCategory[indexPath.section]
        if let projectValue = projectItems[projectKey] {
            let project = projectValue[indexPath.row]
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "projectName"), object:project.name)
            }
        }

    }
    
    
    
}
