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

public protocol Keyboardable {
    
    var keyboardableBottomConstraint: NSLayoutConstraint { get }
    
    func enableKeyboardable()
    func disableKeyboardable()
    
    func keyboardWillHide(_ n: Notification)
    func keyboardWillChangeFrame(_ n: Notification)
    
}

public extension Keyboardable where Self: UIViewController {
    
    func enableKeyboardable() {

		NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil, using: keyboardWillChangeFrame)
		NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil, using: keyboardWillHide)

    }
    
    func disableKeyboardable() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Keyboard notifications
    
    func keyboardWillHide(_ n: Notification) {
        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.keyboardableBottomConstraint.constant = 0.0
            self.view.layoutIfNeeded()
            
        }) { (complete) -> Void in
        }
    }

    func keyboardWillChangeFrame(_ n: Notification) {
        
        var height: CGFloat = 0
        var duration: TimeInterval = 0
        let option = UIViewAnimationOptions()

		if let rect = (n.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			height = rect.size.height
		}

		if let interval = n.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double {
			duration = interval
		}


        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, options: option, animations: { () -> Void in
            
            self.keyboardableBottomConstraint.constant = height
            self.view.layoutIfNeeded()
            
        }) { (complete) -> Void in
        }
    }
    
    
}
