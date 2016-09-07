//
//  ConCircles.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class ConCircles: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.12, height: Cons.screenD.screenWidth * 0.12))
        self.backgroundColor = UIColor.whiteColor()
        
        let innerLayer = CALayer()
        innerLayer.frame = CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.045, height: Cons.screenD.screenWidth * 0.045)
        innerLayer.backgroundColor = UIColor.blackColor().CGColor
        innerLayer.position = self.center
        
        self.layer.cornerRadius = self.frame.height / 2
        innerLayer.cornerRadius = innerLayer.frame.height / 2
        
        self.layer.addSublayer(innerLayer)
    }
    
    
}
