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

private let Progress_magicTag: Int = 3141598

public class ProgressAnimationView: UIView {
    
    private let radius: CGFloat = 16.0
    
    private let animationStepCount = 100
    private let animationDuration = 0.8
    
    private var circlePositions: [CGPoint] = []
    private var circleSizes: [CGFloat] = []
    
    private let circleMinSize: CGFloat = 7
    
    private let circleMinScale: CGFloat = 0.6
    private let circleMaxScale: CGFloat = 0.9
    
    //var circle = UIView(frame: CGRectZero)
    
    private let circleCount = 5
    private var circles: [UIView] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        
        for _ in 0..<circleCount {
            let circle = UIView(frame: CGRectZero)
            circle.backgroundColor = UIColor.orangeColor()
            circle.frame = CGRectMake(0, 0, circleMinSize, circleMinSize)
            circle.layer.cornerRadius = 0.5*circleMinSize
            circle.alpha = 0.5 // + 0.5*CGFloat(k)/CGFloat(circleCount)
            circles.append(circle)
            addSubview(circle)
        }
        
        let angleStep = 2 * 3.14159 / Double(animationStepCount-1)
        var angle = 0.0
        
        let sizeDelta = circleMaxScale - circleMinScale
        
        for _ in 0..<animationStepCount {
            let point = CGPointMake(0.5*frame.size.width+radius*CGFloat(-sin(angle)), 0.5*frame.size.height+radius*CGFloat(cos(angle)))
            circlePositions.append(point)
            circleSizes.append(circleMinScale + 0.5*sizeDelta + 0.5*sizeDelta*CGFloat(sin(-0.5*3.14159+angle)))
            angle += angleStep
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimation() {
        
        for k in 0..<circleCount {
            let circle = self.circles[k]
            circle.center = self.circlePositions[0]
            circle.transform = CGAffineTransformMakeScale(self.circleSizes[0], self.circleSizes[0])
        }
        
        UIView.animateKeyframesWithDuration(animationDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: UIViewKeyframeAnimationOptions.Repeat.rawValue | UIViewKeyframeAnimationOptions.CalculationModeLinear.rawValue), animations: { () -> Void in
            
            let keyframeDuration = 1.0 / Double(self.animationStepCount)
            for k in 0..<self.animationStepCount {
                let startTime = Double(k) * keyframeDuration
                UIView.addKeyframeWithRelativeStartTime(startTime, relativeDuration: keyframeDuration, animations: { () -> Void in
                    
                    for c in 0..<self.circleCount {
                        let circle = self.circles[c]
                        var frameIndex = k+Int(CGFloat(startTime)*CGFloat(c*10))
                        if frameIndex >= self.animationStepCount {
                            frameIndex = self.animationStepCount - 1
                        }
                        circle.center = self.circlePositions[frameIndex]
                        circle.transform = CGAffineTransformMakeScale(self.circleSizes[frameIndex], self.circleSizes[frameIndex])
                    }
                    
                    //self.circle.center = self.circlePositions[k]
                    //self.circle.transform = CGAffineTransformMakeScale(self.circleSizes[k], self.circleSizes[k])
                })
            }
            
            }) { (done) -> Void in
        }
    }
    
    public func stopAnimation() {
        layer.removeAllAnimations()
    }
    
}

public class Progress {
    
    public class func getProgressFromView(view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.tag == Progress_magicTag {
                return subview
            }
        }
    
        return nil
    }
    
    public class func showProgressInView(view: UIView, withBackgroundColor bgColor: UIColor = UIColor(white: 1.0, alpha: 0.4)) {
        
        if let existingProgress = getProgressFromView(view) {
            
            if let existingProgress = existingProgress as? ProgressAnimationView {
                existingProgress.startAnimation()
            }
            
            return
        }
        
        let animationView = ProgressAnimationView(frame: view.bounds)
        
        animationView.backgroundColor = bgColor

        view.addSubview(animationView)
        animationView.frame = view.bounds
        animationView.tag = Progress_magicTag
        
        animationView.startAnimation()
    }

    public class func hideProgressInView(view: UIView) {
        if let existingProgress = getProgressFromView(view) as? ProgressAnimationView {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                existingProgress.alpha = 0.0
                }, completion: { (done) -> Void in
                    existingProgress.stopAnimation()
                    existingProgress.removeFromSuperview()
            })
        }
    }
    
}