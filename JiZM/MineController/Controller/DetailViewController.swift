//
//  DetailViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit


class DetailViewController: UIViewController {

    var account: AccountItem
    var detailView: DetailView
    
    
// MARK: - lifeStyle
    
    init() {
        self.account = AccountItem()
        self.detailView = DetailView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

        
    }
    
    init(account: AccountItem) {
        self.account = account
        self.detailView = DetailView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(detailView)
        self.detailView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.detailView.imageView.image = UIImage(systemName: account.imageName)
        self.detailView.ammountLabel.text = String(account.amount)
        let nameTextField = self.detailView.nameView.typeView as! UITextField
        nameTextField.text = account.name
        let categoryLabel = self.detailView.categoryView.typeView as! UILabel
        categoryLabel.text = account.category
        let initialAmmountTextField = self.detailView.initialAmount.typeView as! UITextField
        initialAmmountTextField.text = String(account.initialAmount)
        let isShowTotalAmoutSwitch = self.detailView.isShowTotalAmout.typeView as! UISwitch
        isShowTotalAmoutSwitch.isOn = account.isShowTotalAmount
        
    }
 
}
