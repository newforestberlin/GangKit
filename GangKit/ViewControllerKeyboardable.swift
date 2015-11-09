//
//  ViewControllerKeyboardable.swift
//  TodayTickets
//
//  Created by Ricki Gregersen on 16/09/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import UIKit

public protocol ViewControllerKeyboardable {
    
    func setupKeyboardable()
    func removeKeyboardable()
    
    func keyboardWillShow(n: NSNotification)
    func keyboardWillHide(n: NSNotification)
    
    func bottomConstraint() ->NSLayoutConstraint
}

public extension ViewControllerKeyboardable where Self: UIViewController {
    
    //    var bottomConstraint
    //
    public func setupKeyboardable() {
        print("")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func removeKeyboardable() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func keyboardWillShow(n: NSNotification) {
        
        if let keyboardSize = n.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size {
            
            self.view.layoutIfNeeded()
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                
                self.bottomConstraint().constant = keyboardSize.height
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    public func keyboardWillHide(n: NSNotification) {
        
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.bottomConstraint().constant = 0.0
            self.view.layoutIfNeeded()
        })
    }
}