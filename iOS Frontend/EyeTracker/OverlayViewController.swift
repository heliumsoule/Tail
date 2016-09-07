//
//  OverlayViewController.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradLayer = CAGradientLayer()
        gradLayer.colors = [Cons.colors.lightBlue.CGColor, Cons.colors.darkerBlue.CGColor]
        gradLayer.startPoint = CGPoint(x: 0, y: 0)
        gradLayer.endPoint = CGPoint(x: 1, y: 1)
        gradLayer.frame = CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth, height: Cons.screenD.screenHeight)
        
        self.view.layer.addSublayer(gradLayer)
    }
}
