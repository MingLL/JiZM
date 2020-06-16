//
//  AccountDetailViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/6/15.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SwiftTTPageController

class AccountDetailViewController: UIViewController, TTHeadViewDelegate, TTPageViewControllerDelegate {
      func tt_headViewSelectedAt(_ index: Int) {
          pagevc.scrollToPageAtIndex(index)
      }
      
      func tt_pageControllerSelectedAt(_ index: Int) {
          headView.scrollToItemAtIndex(index)
      }
    
    var headView: TTHeadView!
    var pagevc: TTPageViewController!
    
    let account: AccountItem!
    
    init(account: AccountItem) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = self.account.name
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatViews()
        // Do any additional setup after loading the view.
    }
    
    func creatViews() {
        let titles: [String] = ["交易明细", "账户信息"]
        var attri = TTHeadTextAttribute()
        attri.itemWidth = self.view.bounds.width / CGFloat(titles.count)
        attri.needBottomLine = true
        self.headView = TTHeadView(frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35), titles: titles, delegate: self, textAttributes: attri)
        self.view.addSubview(self.headView)
        self.headView.backgroundColor = .white
        
        let vcs: [UIViewController] = [TransactionViewController(account: self.account),DetailViewController(account: self.account)]
        self.pagevc = TTPageViewController.init(controllers: vcs, frame: .zero, delegate: self)
        self.addChild(pagevc)
        self.view.addSubview(pagevc.view)
        self.pagevc.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

}
