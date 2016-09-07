//
//  RegistrationViewController.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/26/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController: OverlayViewController {
    
    let registration = RegistrationView()
    var regButton = HighlightButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        setupRippleCircles()
        
        regButton = registration.getRegButton()
        regButton.addTarget(self, action: #selector(RegistrationView.submitRegistration), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(registration)
    }
    
    func submitRegistration() {
        let createUserData = registration.submitRegistration()
        
        Alamofire.request(Router.create_user(createUserData))
            .responseString { response in
                if response.result.isSuccess {
                    let data = response.result.value!
                    let outputDictionary = data.convertToDictionary()
                    ModelManager.sharedInstance.updateIdentifier(outputDictionary!["data"] as! String)
                    
                    self.navigationController?.pushViewController(MainViewController(), animated: true)
                } else {
                    print("There was an error signing up")
                }
        }
    
    }

    func setupRippleCircles() {
        for _ in 1 ..< 10 {
            let layer = CALayer()
            let diameter = Cons.screenD.screenWidth * 0.1 + Cons.screenD.screenWidth * CGFloat(drand48())
            layer.frame = CGRect(x: Cons.screenD.screenWidth * CGFloat(drand48()),
                                 y: Cons.screenD.screenHeight * CGFloat(drand48()),
                                 width: diameter, height: diameter)
            layer.cornerRadius = diameter / 2
            layer.borderColor = UIColor(red: CGFloat(27.0 / 255),
                                        green: CGFloat(127.0 / 255),
                                        blue: CGFloat(243.0 / 255),
                                        alpha: 1.0).CGColor
            layer.borderWidth = 3
            
            
            self.view.layer.addSublayer(layer)
        }
    }
    
    
}