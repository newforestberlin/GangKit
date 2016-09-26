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

public extension UIColor {
    
    public class func colorWithRGBHex(_ hex: Int, alpha: Float = 1.0) -> UIColor {
        
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    
    public func tinted(withColor color: UIColor, factor: CGFloat) -> UIColor {

        var f: CGFloat = 0.0
        // Get RGBA components of self
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Get RGBA components of tint color
        var tr: CGFloat = 0.0
        var tg: CGFloat = 0.0
        var tb: CGFloat = 0.0
        var ta: CGFloat = 0.0
        color.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)

        // Make sure factor is in [0,1] bounds
        f = fmin(factor, 1.0)
        f = fmax(factor, 0.0)
        
        // Own factor is inverse of tint color factor
        let ownFactor = 1.0 - f
        
        // Do linear combination of self and tint color
        r = ownFactor * r + f * tr
        g = ownFactor * g + f * tg
        b = ownFactor * b + f * tb
        a = ownFactor * a + f * ta

        // Create new color with those components
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}
