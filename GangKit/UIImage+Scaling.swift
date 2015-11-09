//
//  UIImage+Scaling.swift
//  GangKit
//
//  Created by Olee on 28.10.15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scale(maxWidth maxWidth: CGFloat) -> UIImage {
        
        let scalingFactor = maxWidth / self.size.width
        
        let size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(scalingFactor, scalingFactor))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

