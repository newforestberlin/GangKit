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

open class AnimatedProgressView: UIView {
    
    open func startAnimation() {
    }
    
    open func stopAnimation() {
    }
    
}

public protocol AnimatedProgressViewFactory {
    func createAnimatedProgressView(withFrame frame: CGRect) -> AnimatedProgressView?
}

open class ProgressAnimationView: AnimatedProgressView {
    
    fileprivate let radius: CGFloat = 16.0
    
    fileprivate let animationStepCount = 100
    fileprivate let animationDuration = 0.8
    
    fileprivate var circlePositions: [CGPoint] = []
    fileprivate var circleSizes: [CGFloat] = []
    
    fileprivate let circleMinSize: CGFloat = 7
    
    fileprivate let circleMinScale: CGFloat = 0.6
    fileprivate let circleMaxScale: CGFloat = 0.9
    
    //var circle = UIView(frame: CGRectZero)
    
    fileprivate let circleCount = 5
    fileprivate var circles: [UIView] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        
        for _ in 0..<circleCount {
            let circle = UIView(frame: CGRect.zero)
            circle.backgroundColor = UIColor.orange
            circle.frame = CGRect(x: 0, y: 0, width: circleMinSize, height: circleMinSize)
            circle.layer.cornerRadius = 0.5*circleMinSize
            circle.alpha = 0.5 // + 0.5*CGFloat(k)/CGFloat(circleCount)
            circles.append(circle)
            addSubview(circle)
        }
        
        let angleStep = 2 * 3.14159 / Double(animationStepCount-1)
        var angle = 0.0
        
        let sizeDelta = circleMaxScale - circleMinScale
        
        for _ in 0..<animationStepCount {
            let point = CGPoint(x: 0.5*frame.size.width+radius*CGFloat(-sin(angle)), y: 0.5*frame.size.height+radius*CGFloat(cos(angle)))
            circlePositions.append(point)
            circleSizes.append(circleMinScale + 0.5*sizeDelta + 0.5*sizeDelta*CGFloat(sin(-0.5*3.14159+angle)))
            angle += angleStep
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func startAnimation() {
        
        for k in 0..<circleCount {
            let circle = self.circles[k]
            circle.center = self.circlePositions[0]
            circle.transform = CGAffineTransform(scaleX: self.circleSizes[0], y: self.circleSizes[0])
        }
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: UIViewKeyframeAnimationOptions.repeat.rawValue | UIViewKeyframeAnimationOptions().rawValue), animations: { () -> Void in
            
            let keyframeDuration = 1.0 / Double(self.animationStepCount)
            for k in 0..<self.animationStepCount {
                let startTime = Double(k) * keyframeDuration
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: keyframeDuration, animations: { () -> Void in
                    
                    for c in 0..<self.circleCount {
                        let circle = self.circles[c]
                        var frameIndex = k+Int(CGFloat(startTime)*CGFloat(c*10))
                        if frameIndex >= self.animationStepCount {
                            frameIndex = self.animationStepCount - 1
                        }
                        circle.center = self.circlePositions[frameIndex]
                        circle.transform = CGAffineTransform(scaleX: self.circleSizes[frameIndex], y: self.circleSizes[frameIndex])
                    }
                    
                    //self.circle.center = self.circlePositions[k]
                    //self.circle.transform = CGAffineTransformMakeScale(self.circleSizes[k], self.circleSizes[k])
                })
            }
            
            }) { (done) -> Void in
        }
    }
    
    open override func stopAnimation() {
        layer.removeAllAnimations()
    }
    
}

open class Progress {
    
    open class func getProgressFromView(_ view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.tag == Progress_magicTag {
                return subview
            }
        }
    
        return nil
    }
    
    open class func showProgressInView(_ view: UIView, withBackgroundColor bgColor: UIColor = UIColor(white: 1.0, alpha: 0.4), withFactory factory: AnimatedProgressViewFactory? = nil) {
        
        if let existingProgress = getProgressFromView(view) {
            
            if let existingProgress = existingProgress as? ProgressAnimationView {
                existingProgress.startAnimation()
            }
            
            return
        }
        
        var animationView: AnimatedProgressView? = nil
        
        if let factory = factory {
            animationView = factory.createAnimatedProgressView(withFrame: view.bounds)
        }
        
        if animationView == nil {
            animationView = ProgressAnimationView(frame: view.bounds)
        }
        
        if let animationView = animationView {
            animationView.backgroundColor = bgColor
            
            view.addSubview(animationView)
            animationView.frame = view.bounds
            animationView.tag = Progress_magicTag
            
            animationView.startAnimation()
        }
    }

    open class func hideProgressInView(_ view: UIView) {
        if let existingProgress = getProgressFromView(view) as? AnimatedProgressView {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                existingProgress.alpha = 0.0
                }, completion: { (done) -> Void in
                    existingProgress.stopAnimation()
                    existingProgress.removeFromSuperview()
            })
        }
    }
    
    open class func removeProgressInView(_ view: UIView) {
        // Do this immediate without animation
        if let existingProgress = getProgressFromView(view) as? AnimatedProgressView {
            existingProgress.stopAnimation()
            existingProgress.removeFromSuperview()
        }
    }

}
