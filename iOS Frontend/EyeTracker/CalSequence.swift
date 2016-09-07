//
//  CalSequence.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class CalSequence: UIView {
    
    private var calibrationCircles:[UIView] = [UIView]()
    private let centerLabel:UILabel = AlignedLabel()
    private let calButton:UIButton = HighlightButton()
    
    private var recalCount:Int = 0
    private var calCircleCount:Int = -1
    private var calibrationTimer:NSTimer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth, height: Cons.screenD.screenHeight))
        
        for row in 0..<Cons.cal.rows {
            for col in 0..<Cons.cal.cols {
                let currCal = ConCircles()
                currCal.center = CGPoint(x: (CGFloat(col) + 0.5) * Cons.cal.colDifference , y: (CGFloat(row) + 0.5) * Cons.cal.rowDifference)
                currCal.alpha = 0
                
                calibrationCircles.append(currCal)
                self.addSubview(currCal)
            }
        }
        calibrationCircles.shuffle()
        
        centerLabel.text = Cons.cal.recalArr[recalCount]
        
        calButton.addTarget(self, action: #selector(CalSequence.startCalibration), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(centerLabel)
        self.addSubview(calButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerLabel.frame = CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.5, height: Cons.screenD.screenHeight * 0.2)
        centerLabel.center = CGPoint(x: Cons.screenD.screenWidth * 0.5, y: Cons.screenD.screenHeight * 0.5)
        centerLabel.alpha = 0
        
        calButton.frame = CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.40, height: Cons.screenD.screenWidth * 0.12)
        calButton.center = CGPoint(x: Cons.screenD.screenWidth * 0.5, y: Cons.screenD.screenHeight * 0.5)
        calButton.setTitle("Recalibrate", forState: UIControlState.Normal)
        calButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        calButton.backgroundColor = Cons.colors.cyan

    }
    
    func getRecalButton() -> UIButton {
        return calButton
    }
    
    func startCalibration() {
        calButton.alpha = 0
        centerLabel.alpha = 1
        calibrationCircles.shuffle()
        calibrationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(CalSequence.changeTime), userInfo: nil, repeats: true)
        calibrationTimer.fire()
    }
    
    func changeTime() {
        recalCount += 1
        if recalCount == Cons.cal.recalArr.count {
            calibrationTimer.invalidate()
            calibrationTimer = NSTimer.scheduledTimerWithTimeInterval(Cons.cal.circleTime, target: self, selector: #selector(CalSequence.changeCalCircle), userInfo: nil, repeats: true)
            calibrationTimer.fire()
        } else {
            centerLabel.text = Cons.cal.recalArr[recalCount]
        }
    }
    
    func changeCalCircle() {
        centerLabel.alpha = 0
        calCircleCount += 1
        if calCircleCount == calibrationCircles.count {
            calibrationTimer.invalidate()
        } else {
            calibrationCircles[max(0, calCircleCount - 1)].alpha = 0
            calibrationCircles[calCircleCount].alpha = 1.0
        }
    }
    
    func stopCalibration() {
        calibrationTimer.invalidate()
        
        recalCount = 0
        calibrationCircles[max(0, calCircleCount)].alpha = 0
        calCircleCount = -1
        
        centerLabel.text = Cons.cal.recalArr[recalCount]
        centerLabel.alpha = 0
        
        calButton.alpha = 1.0
    }
    
}






