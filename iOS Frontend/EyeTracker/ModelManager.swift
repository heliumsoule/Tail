//
//  ModelManager.swift
//  EyeTracker
//
//  Created by Jing Lin on 4/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class ModelManager {
    
    static let sharedInstance:ModelManager = ModelManager()
    var user_identifier:String = ""
    
    private init() {
        
        let user_defaults = NSUserDefaults.standardUserDefaults()
        if let user_id = user_defaults.objectForKey("user_identity") {
            user_identifier = user_id as! String
        }
    }
    
    func updateIdentifier(input_identifier: String) {
        
        print("The output ID is \(input_identifier)")
        user_identifier = input_identifier
        NSUserDefaults.standardUserDefaults().setObject(input_identifier, forKey: "user_identity")
        
    }
    
    
}
