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