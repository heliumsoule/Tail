//
//  ViewController.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/20/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MainViewController: OverlayViewController {

    let calibration = CalSequence()
    var updateTimer = NSTimer()
    
    var cancelButton:UIBarButtonItem!
    var recalButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        self.title = "Trackr"
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(MainViewController.stopCalibration))
        
        recalButton = calibration.getRecalButton()
//        recalButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainViewController.startRecalibration)))
        
        self.view.addSubview(calibration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func startRecalibration() {
        self.navigationItem.rightBarButtonItem = cancelButton
        calibration.startCalibration()
    }

    func stopCalibration() {
        calibration.stopCalibration()
        self.navigationItem.rightBarButtonItem = nil
    }

}




