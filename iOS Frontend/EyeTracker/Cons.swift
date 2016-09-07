//
//  Cons.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/20/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

struct Cons {
    struct screenD {
        static let screenWidth:CGFloat = UIScreen.mainScreen().bounds.width
        static let screenHeight:CGFloat = UIScreen.mainScreen().bounds.height
        static let navController:CGFloat = 44
        static let statusBar:CGFloat = 20
        static let roundness:CGFloat = 12
    }
    struct colors {
        static let lightBlue:UIColor = UIColor(red: CGFloat(33.0 / 255), green: CGFloat(194.0 / 255), blue: CGFloat(251.0 / 255), alpha: 1.0)
        static let darkerBlue:UIColor = UIColor(red: CGFloat(48.0 / 255), green: CGFloat(152.0 / 255), blue: CGFloat(251.0 / 255), alpha: 1.0)
        static let lightGray = UIColor(red: CGFloat(230.0 / 255), green: CGFloat(230.0 / 255), blue: CGFloat(230.0 / 255), alpha: 1.0)
        static let cyan = UIColor(red: CGFloat(41 / 255), green: CGFloat(250.0 / 255), blue: CGFloat(255.0 / 255), alpha: 1.0)
    }
    struct cal {
        static let rows:Int = 4
        static let cols:Int = 3
        static let circleTime:Double = 4
        static let rowDifference:CGFloat = (Cons.screenD.screenHeight) / CGFloat(Cons.cal.rows)
        static let colDifference:CGFloat = (Cons.screenD.screenWidth) / CGFloat(Cons.cal.cols)
        static let recalArr = ["Recalibration starts in 3", "Recalibration starts in 2", "Recalibration starts in 1"]
    }
    struct location {
        static let distanceToUpdate:Double = 3 // In meters
    }
    
}