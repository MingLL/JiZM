//
//  FormViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SwiftTTPageController
import SnapKit


class FormViewController: UIViewController, TTHeadViewDelegate, TTPageViewControllerDelegate{
    func tt_headViewSelectedAt(_ index: Int) {
        pagevc.scrollToPageAtIndex(index)
    }
    
    func tt_pageControllerSelectedAt(_ index: Int) {
        headView.scrollToItemAtIndex(index)
    }
    
    
   
    var headView:TTHeadView!
    var pagevc:TTPageViewController!
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(systemName: "chart.pie", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        self.tabBarItem.title = "报表"
        self.navigationItem.title = "报表"
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatViews()

    }
    
    func creatViews() {
        let titles: [String] = ["总览", "明细", "类别", "排行"]
        var attri = TTHeadTextAttribute()
        attri.itemWidth = self.view.bounds.width / CGFloat(titles.count)
        attri.needBottomLine = true
        self.headView = TTHeadView(frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35), titles: titles, delegate: self, textAttributes: attri)
        self.view.addSubview(self.headView)
        self.headView.backgroundColor = .white
        
        let vcs: [UIViewController] = [AllFormViewController(),DetailFormiewController(),CategoryFormViewController(),RankViewController()]
        self.pagevc = TTPageViewController.init(controllers: vcs, frame: .zero, delegate: self)
        self.addChild(pagevc)
        self.view.addSubview(pagevc.view)
        self.pagevc.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
   
}
