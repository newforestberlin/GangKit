// The MIT License (MIT)
//
// Copyright (c) 2015 you & the gang UG(haftungsbeschränkt)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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