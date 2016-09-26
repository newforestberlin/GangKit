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

open class ProgressView: UIView {
    
    fileprivate let circlePathLayer = CAShapeLayer()
    
    open var progress: CGFloat = 0.0 {
        
        didSet {
            
            var value = progress
            if value > 1 {
                value = 0
            } else if value < 0 {
                value = 0
            }
            
            let swipe = CABasicAnimation(keyPath: "strokeEnd")
            swipe.duration = 0.25
            swipe.fromValue = Double(oldValue)
            swipe.toValue = progress
            swipe.fillMode = kCAFillModeForwards
            swipe.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            swipe.isRemovedOnCompletion = false
            circlePathLayer.strokeEnd = progress
            circlePathLayer.add(swipe, forKey: "strokeEnd Animation")
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    fileprivate func configure() {
        
        isOpaque = true
        
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.white.cgColor
        
        circlePathLayer.shadowColor = UIColor.black.cgColor
        circlePathLayer.shadowOffset = CGSize(width: 1, height: 1)
        circlePathLayer.shadowRadius = 1.0
        circlePathLayer.shadowOpacity = 0.5
        
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.clear
    }
    
    open func set(color: UIColor) {
        circlePathLayer.strokeColor = color.cgColor
    }
    
    open func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: bounds)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
}
