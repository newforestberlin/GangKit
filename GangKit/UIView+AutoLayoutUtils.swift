//
//  UIView+AutoLayoutUtils.swift
//  GangKit
//
//  Created by Ricki Gregersen on 28/04/15.
//  Copyright (c) 2015 HelloFresh GmbH. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(visualFormat: String, options: NSLayoutFormatOptions, metrics: [String : AnyObject], views: [String : UIView]) {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: options, metrics: metrics, views: views))
    }
    
    func addConstraintsWithFormats(visualFormats: [String], options: NSLayoutFormatOptions, metrics: [String : AnyObject], views: [String : UIView]) {
        for format in visualFormats {
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views))
        }
    }
    
    func addConstraintWithItem(withItem: UIView, withAttribute: NSLayoutAttribute, withRelation: NSLayoutRelation, toItem: UIView?, toAttribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) {
        self.addConstraint(NSLayoutConstraint(item: withItem, attribute: withAttribute, relatedBy: withRelation, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant))
    }
    
    func addConstraintsWithFormats(visualFormats: [String], views: [String : UIView]) {
        self.addConstraintsWithFormats(visualFormats, options: NSLayoutFormatOptions(), metrics: [String : AnyObject](), views: views)
    }
    
    func addConstraintsWithFormat(visualFormat: String, views: [String : UIView]) {
        self.addConstraintsWithFormats([visualFormat], views: views)
    }
    
    func removeAllConstraints() {
        for c in self.constraints {
            self.removeConstraint(c)
        }
    }
    
    func removeAllSubviews() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}
    
    // -----------------------------------------------------------------------------------------------------------------------------------

//    + (void) animateConstraintUpdatesForView:(UIView*) view
//duration:(CGFloat) duration
//animationOption:(UIViewAnimationOptions) option
//completion:(ConstraintAnimationCompletion) completion
//{
//    [UIView animateWithDuration:duration
//        delay:0.0f
//        usingSpringWithDamping:0.5f
//        initialSpringVelocity:0.7f
//        options:UIViewAnimationOptionBeginFromCurrentState | option
//        animations:^{
//        
//        [view layoutIfNeeded];
//        
//        } completion:^(BOOL finished) {
//        if (completion)
//        completion(finished);
//        }];
//}