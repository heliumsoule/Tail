//
//  LocationTracker.swift
//  EyeTracker
//
//  Created by Jing Lin on 4/26/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class LocationTracker : NSObject, UIAlertViewDelegate {
    
    let sharedModel = LocationShareModel.sharedInstance
    
    lazy var locationManager:CLLocationManager = {
        
        let locManager = CLLocationManager()
        locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locManager.allowsBackgroundLocationUpdates = true
        locManager.pausesLocationUpdatesAutomatically = false
        
        return locManager
    }()
    
    var lastKnownData = Dictionary<String, AnyObject>()
    
    override init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LocationTracker.applicationEnterBackground), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
    }
    
    func applicationEnterBackground() {
        
        setupLocationManager()
        
        BackgroundTaskManager.sharedInstance.beginNewBackgroundTask()
    }
 
    func restartLocationUpdates() {
//        print("Restarting location")
        
        if let _ = sharedModel.timer {
            sharedModel.timer!.invalidate()
            sharedModel.timer = nil
        }
        
        setupLocationManager()
    }
    
    func startLocationTracking() {
        setupLocationManager()
    }
    
    func setupLocationManager() {
        let otherLocationManager = locationManager
        otherLocationManager.delegate = self
        otherLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        otherLocationManager.distanceFilter = kCLDistanceFilterNone
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways {
            otherLocationManager.requestAlwaysAuthorization()
        }
        otherLocationManager.allowsBackgroundLocationUpdates = true
        otherLocationManager.startUpdatingLocation()
    }
    
}

extension LocationTracker: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations")
        for locIndex in 0..<locations.count {
            let currLocationData = locations[locIndex]
            let accuracy = currLocationData.horizontalAccuracy
            let timeInterval = currLocationData.timestamp.timeIntervalSinceNow
            
            if timeInterval > 30.0 {
                continue;
            }
            
            if accuracy > 0 && accuracy < 100 {
                lastKnownData = formatLocationData(currLocationData)
                
                let dataToServer = formatLocationData(currLocationData)
                sharedModel.locationsArray.append(dataToServer)
            }
            
        }
        
        if let _ = sharedModel.timer {
            return
        }
        
        BackgroundTaskManager.sharedInstance.beginNewBackgroundTask()
        
        sharedModel.timer = NSTimer.scheduledTimerWithTimeInterval(60,
                                                                   target: self,
                                                                   selector: #selector(LocationTracker.restartLocationUpdates),
                                                                   userInfo: nil,
                                                                   repeats: false)
        
        if let _ = sharedModel.delayedTimer {
            sharedModel.delayedTimer!.invalidate()
            sharedModel.delayedTimer = nil
        }
        
        sharedModel.delayedTimer = NSTimer.scheduledTimerWithTimeInterval(10,
                                                                          target: self,
                                                                          selector:#selector(LocationTracker.stopLocationDelay),
                                                                          userInfo: nil,
                                                                          repeats: false)
    }
    
    func stopLocationDelay() {
//        print("Stop updating after 10 seconds")
        locationManager.stopUpdatingLocation()
        
    }
    
    func formatLocationData(location: CLLocation) -> [String: AnyObject] {
        var data = Dictionary<String, AnyObject>()
            
        data["id"] = ModelManager.sharedInstance.user_identifier
        data["altitude"] = location.altitude.description
        data["timestamp"] = location.timestamp.description
        data["speed"] = location.speed.description
        data["latitude"] = String(location.coordinate.latitude)
        data["longitude"] = String(location.coordinate.longitude)
        data["horizontal_acc"] = location.horizontalAccuracy
        data["vertical_acc"] = location.verticalAccuracy
        data["time"] = location.timestamp.description

        data["floor"] = UIApplication.sharedApplication().applicationState == .Background ? "background" : "foreground"
        
        return data
    }

    func updateLocationToServer() {
        
        var bestCurrLocation = lastKnownData
        
        for locIndex in 0 ..< sharedModel.locationsArray.count {
            let currLocation = sharedModel.locationsArray[locIndex]
            
            if currLocation["horizontal_acc"]!.floatValue < bestCurrLocation["horizontal_acc"]!.floatValue {
                bestCurrLocation = currLocation
            }
        }
        
        bestCurrLocation["time"] = NSDate().description
//        print("Updating location to server \(NSDate().description)")
        Alamofire.request(Router.update_user_location(bestCurrLocation))
            .responseString {
                response in
                if response.result.isSuccess {
                    let data = response.result.value!
//                    print("Server response was: \(data)")
                }
        }

        sharedModel.locationsArray.removeAll()
    }
}











