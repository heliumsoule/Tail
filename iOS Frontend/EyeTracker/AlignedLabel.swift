//
//  AlignedLabel.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class AlignedLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.35, height: Cons.screenD.screenHeight * 0.1))
        self.textAlignment = NSTextAlignment.Center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let actualCenter = self.center
        let height = self.text!.boundingHeight(self.frame.width, font: self.font)
        
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
        self.center = actualCenter
        
        self.textColor = UIColor.whiteColor()
    }
}
