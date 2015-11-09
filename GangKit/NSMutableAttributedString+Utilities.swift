//
//  AttributedStringExtension.swift
//  OfficeBacon
//
//  Created by Ricki Gregersen on 14/11/14.
//  Copyright (c) 2014 youandthegang.com. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
    
    public func setFont(font: UIFont) {
        self.setFont(font, subString:self.string)
    }
    
    public func setFont(font: UIFont, subString:String) {
        let range = (self.string as NSString).rangeOfString(subString)
        self.addAttribute(NSFontAttributeName, value: font, range: range)
    }

    public func setColor(color: UIColor) {
        self.setColor(color, subString: self.string)
    }
    
    public func setColor(color: UIColor, subString:String) {
        let range = (self.string as NSString).rangeOfString(subString)
        self.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
    }
    
    public func setAlignment(alignment:NSTextAlignment) {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment
        let range = (self.string as NSString).rangeOfString(self.string)
        self.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: range)
    }
}