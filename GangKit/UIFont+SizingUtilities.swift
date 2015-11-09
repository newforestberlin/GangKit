//
//  UIFont+Utilities.swift
//  GangKit
//
//  Created by Ricki Gregersen on 02/10/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import UIKit

public extension UIFont {

    public func sizeOfString (string: String, constrainedToWidth width: CGFloat) -> CGSize {
        
        let options: NSStringDrawingOptions = [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading]
        let attributes = [NSFontAttributeName: self]
        let maxSize = CGSize(width: width, height: CGFloat.max)
        return NSString(string: string).boundingRectWithSize(maxSize,
            options: options,
            attributes: attributes,
            context: nil).size
    }
}

public extension String {
    
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
    
//    extension NSAttributedString {
//        func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
//            let constraintRect = CGSize(width: width, height: CGFloat.max)
//            let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
//            
//            return ceil(boundingBox.height)
//        }
//    }