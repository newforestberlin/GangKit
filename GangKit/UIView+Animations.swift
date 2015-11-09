//
//  UIView+Animations.swift
//  GangKit
//
//  Created by Ricki Gregersen on 05/10/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import UIKit

extension UIView {
    
    func animateBackgroundColor(color: UIColor, completion: ((done: Bool)->())?) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.backgroundColor = color
            }) { (done) -> Void in
                completion?(done: done)
        }
    }
    
    class func springAnimationWithDuration(duration: NSTimeInterval, animations: (() -> Void), completion: ((Bool) -> Void)? ) {
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: animations, completion: completion)        
    }
    
    class func animate(withRandomMaxDelay maxDelay: NSTimeInterval, duration: NSTimeInterval, maxRandomDurationOffset: NSTimeInterval, animations: (() -> Void), completion: ((Bool) -> Void)? = nil ) {
        UIView.animateWithDuration(duration+NSTimeInterval.random(min: 0.0, max: maxRandomDurationOffset), delay: NSTimeInterval.random(min: 0.0, max: maxDelay), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: animations, completion: completion)
    }
}