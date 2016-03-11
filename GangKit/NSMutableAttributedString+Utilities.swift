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

//infix operator += {associativity left precedence 140}
public func += (inout left: NSMutableAttributedString, right: String) {
    
    left.appendAttributedString(NSAttributedString(string: right))
}

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
    
//    public func underline() {
//        
//    }
    
    public func underline(subString string: String) {
        
        let range = (self.string as NSString).rangeOfString(string)
        self.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range)
    }
    
}