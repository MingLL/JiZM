//
//  FormViewController.swift
//  JiZM
//
//  Created by MingL L on 2020/5/29.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(systemName: "chart.pie", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        self.tabBarItem.title = "报表"
        self.navigationItem.title = "报表"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}