//
//  UIViewFrameExtension.swift
//  OfficeBacon
//
//  Created by Ricki Gregersen on 25/11/14.
//  Copyright (c) 2014 youandthegang.com. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func setSize(size: CGSize, center: CGPoint) {
        self.frame = CGRectMake(center.x - size.width * 0.5, center.y - size.height * 0.5, size.width, size.height)
    }
    
    public func isInsideSuperview() -> Bool {
        if let sv = superview {
            if center.x > CGRectGetMaxX(sv.frame) || center.x < CGRectGetMinX(sv.frame) {
                return false
            }
            if center.y > CGRectGetMaxY(sv.frame) || center.y < CGRectGetMinY(sv.frame) {
                return false
            }
            return true
        }
        return false
    }
    
    public func scale(scaleX scX: CGFloat, scaleY: CGFloat) {
        let t: CGAffineTransform = self.transform
        let sX = sqrt(t.a * t.a + t.c * t.c)
        let sY = sqrt(t.b * t.b + t.d * t.d)
        if sX != scX || sY != scaleY {
            transform = CGAffineTransformIdentity
            transform = CGAffineTransformMakeScale(scX, scaleY)
        }
    }
}