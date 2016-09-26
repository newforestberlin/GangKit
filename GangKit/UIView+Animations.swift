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

public extension UIView {
    
    public func animateBackgroundColor(_ color: UIColor, completion: ((_ done: Bool)->())?) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.backgroundColor = color
            }, completion: { (done) -> Void in
                completion?(done)
        }) 
    }
    
    public func animateBackgroundColor(_ color: UIColor, duration: TimeInterval, completion: ((_ done: Bool)->())?) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.backgroundColor = color
            }) { (complete) -> Void in
                completion?(complete)
        }
    }
    
    public class func springAnimationWithDuration(_ duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? ) {
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: animations, completion: completion)        
    }
    
    public class func animate(withRandomMaxDelay maxDelay: TimeInterval, duration: TimeInterval, maxRandomDurationOffset: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil ) {
        UIView.animate(withDuration: duration+TimeInterval.random(min: 0.0, max: maxRandomDurationOffset), delay: TimeInterval.random(min: 0.0, max: maxDelay), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: animations, completion: completion)
    }
}
