//
//  ProgressView.swift
//  GangKit
//
//  Created by Ricki Gregersen on 25/09/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import UIKit

public class ProgressView: UIView {
    
    private let circlePathLayer = CAShapeLayer()
    
    public var progress: CGFloat = 0.0 {
        
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
            swipe.removedOnCompletion = false
            circlePathLayer.strokeEnd = progress
            circlePathLayer.addAnimation(swipe, forKey: "strokeEnd Animation")
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        
        opaque = true
        
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        circlePathLayer.strokeColor = UIColor.whiteColor().CGColor
        
        circlePathLayer.shadowColor = UIColor.blackColor().CGColor
        circlePathLayer.shadowOffset = CGSize(width: 1, height: 1)
        circlePathLayer.shadowRadius = 1.0
        circlePathLayer.shadowOpacity = 0.5
        
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.clearColor()
    }
    
    public func set(color color: UIColor) {
        circlePathLayer.strokeColor = color.CGColor
    }
    
    public func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalInRect: bounds)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().CGPath
    }
}