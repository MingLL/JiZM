//
//  File.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProjectItem {
    
    var name: String
    var beginDate: Date
    var endDate: Date
    var imageName: String
    var status: String {
        get {
            let nowDate = Date()
            if self.beginDate.compare(nowDate) == .orderedAscending {
                if self.endDate.compare(nowDate) == .orderedDescending {
                    return "进行中"
                } else {
                    return "已结束"
                }
            } else {
                return "未开始"
            }
        }
    }
    var totalAmount: Float
    var amount: Float
    
    
    init(name: String, beginDate: Date, endDate: Date,totalAmount:Float, imageName: String) {
        self.name = name
        self.beginDate = beginDate
        self.endDate = endDate
        self.totalAmount = totalAmount
        self.imageName = imageName
        self.amount = 0.0
    }
    
    init() {
        self.name = ""
        self.beginDate = Date()
        self.endDate = Date()
        self.totalAmount = 0.0
        self.imageName = ""
        self.amount = 0.0
    }
    
    static func searchProject(projectItem: ProjectItem?) ->Project? {
        if projectItem != nil{
            let project: Project?
            let app = UIApplication.shared.delegate as! AppDelegate
            let context = app.persistentContainer.viewContext
            
            let  request = NSFetchRequest<Project>.init(entityName: "Project")
            let predicate = NSPredicate(format: "name = %@", projectItem?.name ?? "")
            request.predicate = predicate
            
            do {
                let fetchedObjects = try context.fetch(request)
                project = fetchedObjects.first ?? nil
            } catch {
                fatalError("查询错误：\(error)")
            }
            return project
        }
        return nil
    }
    
    static func toProjectItme(project: Project) -> ProjectItem {
        let projectItem = ProjectItem()
        projectItem.name = project.name!
        projectItem.beginDate = project.beginDate!
        projectItem.endDate = project.endDate!
        projectItem.imageName = project.imageName!
        projectItem.amount = project.amount
        return projectItem
    }
    
    static func searchProjects() -> [ProjectItem] {
        var projectItems: [ProjectItem] = []
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let request = NSFetchRequest<Project>.init(entityName: "Project")
        do {
            let fetchObjects = try context.fetch(request)
            for project in fetchObjects {
                let projectItem = ProjectItem()
                projectItem.name = project.name!
                projectItem.beginDate = project.beginDate!
                projectItem.endDate = project.endDate!
                projectItem.imageName = project.imageName!
                projectItem.amount = project.amount
                projectItem.totalAmount = project.totalAmount
                projectItems.append(projectItem)
            }
        } catch {
            print("error")
        }
        return projectItems
    }
    
    static func saveProject(projectItem: ProjectItem) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let project = NSEntityDescription.insertNewObject(forEntityName: "Project", into: app.persistentContainer.viewContext) as! Project
        project.name = projectItem.name
        project.amount = projectItem.amount
        project.imageName = projectItem.imageName
        project.beginDate = projectItem.beginDate
        project.endDate = projectItem.endDate
        project.totalAmount = projectItem.totalAmount
        project.status = projectItem.status
        app.saveContext()
    }
}
