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
    
    public func addConstraintsWithFormat(_ visualFormat: String, options: NSLayoutFormatOptions, metrics: [String : Any], views: [String : Any]) {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: options, metrics: metrics, views: views))
    }
    
    public func addConstraintsWithFormats(_ visualFormats: [String], options: NSLayoutFormatOptions, metrics: [String : Any], views: [String : Any]) {
        for format in visualFormats {
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views))
        }
    }
    
    public func addConstraintWithItem(_ withItem: UIView, withAttribute: NSLayoutAttribute, withRelation: NSLayoutRelation, toItem: UIView?, toAttribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) {
        self.addConstraint(NSLayoutConstraint(item: withItem, attribute: withAttribute, relatedBy: withRelation, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant))
    }
    
    public func addConstraintsWithFormats(_ visualFormats: [String], views: [String : Any]) {
        self.addConstraintsWithFormats(visualFormats, options: NSLayoutFormatOptions(), metrics: nil, views: views)
    }
    
    public func addConstraintsWithFormat(_ visualFormat: String, views: [String : Any]) {
        self.addConstraintsWithFormats([visualFormat], views: views)
    }
    
    public func removeAllConstraints() {
        for c in self.constraints {
            self.removeConstraint(c)
        }
    }
    
    public func removeAllSubviews() {
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
