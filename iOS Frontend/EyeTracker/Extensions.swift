//
//  Extensions.swift
//  EyeTracker
//
//  Created by Jing Lin on 3/24/16.
//  Copyright © 2016 Lin. All rights reserved.
//

import UIKit

extension String {
    
    func boundingHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingRect = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingRect.height
    }
    
    func convertToDictionary() -> [String: AnyObject]? {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        
        return nil
    }
}

extension Array {
    
    mutating func shuffle() {
        var randomShuffle = [Element]()
        while self.count != 0 {
            randomShuffle.append(self.removeAtIndex(Int(Double(self.count) * drand48())))
        }
        
        self = randomShuffle
    }
}

extension Array where Element: Equatable {
    
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

extension UIColor {
    
    func lighterColor() -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: min(a + 0.2, 1.0))
        } else {
            return self
        }
    }
    
    func darkerColor() -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r - 0.2, 1.0), green: min(g - 0.2, 1.0), blue: max(b - 0.2, 0), alpha: max(a - 0.2, 0))
        } else {
            return self
        }
    }

}

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let dismissKeyboardTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.hideKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardTap)
    }

    func hideKeyboard() {
        self.view.endEditing(true)
    }
}




