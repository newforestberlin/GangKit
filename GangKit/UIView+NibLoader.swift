//
//  UIView+NibLoader.swift
//  GangKit
//
//  Created by Ricki Gregersen on 16/06/15.
//  Copyright (c) 2015 HelloFresh GmbH. All rights reserved.
//

import UIKit

extension UINib {
    
    class func instantiateView<T>(fromNib name: String) -> T? {
        
        if let view = UINib(nibName: name, bundle: nil).instantiateWithOwner(nil, options: nil).first as? T {
            return view
        }
        
        return nil
    }
}

extension UIView {
    
    class func loadViewFromNib<T: UIView>(nibName: String) -> T? {
        return UINib.instantiateView(fromNib: nibName) as T?
    }
    
    // Be aware that this removes the constraints from self and copies them to the loaded view!
    // This should be called from awakeAfterUsingCoder, like this:
    // return viewFromNib("TimerStatusView") ?? self
    func viewFromNib<T: UIView>(nibName: String) -> T? {
        if subviews.count == 0 {
            if let view = UIView.loadViewFromNib(nibName) as? T {
                view.translatesAutoresizingMaskIntoConstraints = false
                let contraints = self.constraints
                self.removeConstraints(contraints)
                view.addConstraints(contraints)
                
                return view
            }
        }
        
        return nil
    }
    
}
