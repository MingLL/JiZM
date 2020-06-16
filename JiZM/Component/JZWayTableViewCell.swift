//
//  JZWayTableViewCell.swift
//  JiZM
//
//  Created by MingL L on 2020/6/9.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit
import SnapKit

class JZWayTableViewCell: UITableViewCell {
    var roundView: UILabel!
    var nameLabel: UILabel!
    var countLabel: UILabel!
    var progressLabel: UIView!
    var amountLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.roundView = UILabel(frame: .zero)
        self.nameLabel = UILabel(frame: .zero)
        self.countLabel = UILabel(frame: .zero)
        self.progressLabel = UIView(frame: .zero)
        self.amountLabel = UILabel(frame: .zero)
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.amountLabel.adjustsFontSizeToFitWidth = true
        self.countLabel.adjustsFontSizeToFitWidth = true
        self.countLabel.textAlignment = .center
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.roundView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.countLabel)
        self.addSubview(self.progressLabel)
        self.addSubview(self.amountLabel)
    }
    
    override func layoutSubviews() {
        self.roundView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(5)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.roundView.snp.right).offset(3)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(30)
        }
        self.countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.right).offset(4)
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
        }
        self.amountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-2)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
        }
        self.progressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.countLabel.snp.right).offset(3)
            make.centerY.equalToSuperview()
            make.height.equalTo(5)
            make.right.equalTo(self.amountLabel.snp.left).offset(-3)
        }
        
    }
    
    func setUpForCell(progress: Float, color: UIColor, amount: Float, count: Int, name: String) {
        let view = UIView()
        self.progressLabel.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(self.progressLabel.snp.width).multipliedBy(progress)
        }
        view.layer.cornerRadius = 5
        view.layer.backgroundColor = color.cgColor
        self.roundView.layer.cornerRadius = 2.5
        self.countLabel.layer.cornerRadius = 5
        self.roundView.layer.backgroundColor = color.cgColor
        self.countLabel.layer.backgroundColor = color.cgColor
        self.amountLabel.textColor = color
        self.nameLabel.text = name
        self.countLabel.text = String(count)
        self.amountLabel.text = String(format: "%.2f", amount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
