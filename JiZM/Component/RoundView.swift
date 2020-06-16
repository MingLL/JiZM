//
//  RoundView.swift
//  JiZM
//
//  Created by MingL L on 2020/6/10.
//  Copyright © 2020 MingL L. All rights reserved.
//

import UIKit

class RoundView: UIView {
    var color: UIColor!
    var progress: Double!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let path:CGMutablePath = CGMutablePath()
        context.addArc(center:CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius:40, startAngle: CGFloat(-(Double.pi / 2)), endAngle:CGFloat(self.progress*2*Double.pi - (Double.pi / 2)), clockwise: false)
        context.setLineWidth(10)
        self.color.setStroke()
        context.addPath(path)
        context.drawPath(using: .stroke)
    }


    

}
