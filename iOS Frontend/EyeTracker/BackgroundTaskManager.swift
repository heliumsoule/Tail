//
//  BackgroundTaskManager.swift
//  EyeTracker
//
//  Created by Jing Lin on 4/25/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class BackgroundTaskManager {
    
    static let sharedInstance = BackgroundTaskManager()
    
    var masterTaskId = UIBackgroundTaskInvalid
    var bgTaskIdList = [UIBackgroundTaskIdentifier]()
    
    private init() {
        
    }
    
    func beginNewBackgroundTask() -> UIBackgroundTaskIdentifier {
        
        let curr_application = UIApplication.sharedApplication()
        var bg_task_id = UIBackgroundTaskInvalid
        
        if curr_application.respondsToSelector(#selector(UIApplication.beginBackgroundTaskWithExpirationHandler(_:))) {
            
            bg_task_id = curr_application.beginBackgroundTaskWithExpirationHandler({ 
                
                self.bgTaskIdList.removeObject(bg_task_id)
                curr_application.endBackgroundTask(bg_task_id)
                bg_task_id = UIBackgroundTaskInvalid
            })
            
            if masterTaskId == UIBackgroundTaskInvalid {
                masterTaskId = bg_task_id
            } else {
                bgTaskIdList.append(bg_task_id)
                endBackgroundTasks()
            }
            
        }
        
        return bg_task_id
            
    }
    
    func endBackgroundTasks() {
        drainBGTaskList(false)
    }
    
    func drainBGTaskList(endAllBackgroundTasks: Bool) {

        let curr_application = UIApplication.sharedApplication()
        if curr_application.respondsToSelector(#selector(UIApplication.endBackgroundTask(_:))) {

            let start_index = endAllBackgroundTasks ? 0 : 1

            for _ in start_index ..< bgTaskIdList.count {
                curr_application.endBackgroundTask(bgTaskIdList.first!)
                bgTaskIdList.removeFirst()
            }

            if (endAllBackgroundTasks) {
                curr_application.endBackgroundTask(masterTaskId)
                masterTaskId = UIBackgroundTaskInvalid
            }

            
        }
    }
}





