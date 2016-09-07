//
//  LocationShareModel.swift
//  EyeTracker
//
//  Created by Jing Lin on 4/26/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class LocationShareModel: NSObject {
    
    static let sharedInstance = LocationShareModel()
    
    var locationsArray = [Dictionary<String, AnyObject>]()
    var timer:NSTimer? = nil
    var delayedTimer:NSTimer? = nil
    
    var bgTask = BackgroundTaskManager.sharedInstance
    
    private override init() {
        super.init()
    }
    
}
