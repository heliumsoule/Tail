//
//  RegistrationView.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/26/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
    let title = UILabel()
    let fname = UITextField()
    let lname = UITextField()
    let regButton = HighlightButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: .zero)

        self.addSubview(title)
        self.addSubview(fname)
        self.addSubview(lname)
        self.addSubview(regButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.7, height: Cons.screenD.screenHeight * 0.8)
        self.center = CGPoint(x: Cons.screenD.screenWidth * 0.5, y: Cons.screenD.screenHeight * 0.5)
        
        title.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.2)
        title.center = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.1)
        title.text = "Trackr Registration"
        title.textColor = UIColor.whiteColor()
        title.textAlignment = .Center
        title.font = UIFont.systemFontOfSize(20)
        
        setupTextField(fname, placeholder: "First name")
        fname.center = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.45)

        setupTextField(lname, placeholder: "Last name")
        lname.center = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.6)
        
        regButton.frame = CGRect(x: 0, y: 0, width: Cons.screenD.screenWidth * 0.45, height: Cons.screenD.screenWidth * 0.105)
        regButton.center = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.8)
        regButton.setTitle("Setup Account", forState: UIControlState.Normal)
        regButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        regButton.backgroundColor = Cons.colors.cyan
        
        
    }
    
    func setupTextField(inputText: UITextField, placeholder: String) {
        inputText.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width * 0.15)
        inputText.placeholder = placeholder
        inputText.backgroundColor = UIColor(red: CGFloat(255.0 / 255),
                                            green: CGFloat(255.0 / 255),
                                            blue: CGFloat(255.0 / 255),
                                            alpha: 0.7)
        inputText.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        inputText.layer.cornerRadius = 7
    }
    
    func submitRegistration() -> [String: String] {

        return ["fname": fname.text!, "lname": lname.text!]
    }
    
    func getRegButton() -> HighlightButton {
        return regButton
    }
    
}










