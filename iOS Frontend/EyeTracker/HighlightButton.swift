//
//  HighlightButton.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class HighlightButton: UIButton {
    
    override var highlighted: Bool {
        willSet {
            self.backgroundColor = newValue ? Cons.colors.cyan.darkerColor() : Cons.colors.cyan
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = Cons.screenD.roundness
    }
    
}
