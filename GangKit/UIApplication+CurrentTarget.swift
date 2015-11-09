//
//  UIApplication+CurrentTarget.swift
//  GangKit
//
//  Created by Olee on 12.10.15.
//  Copyright © 2015 you & the gang. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    public class func currentTarget() -> String {
        // we shuld be able to do this because we are dealing with optionals that should never be nil
        let infoDictionary = NSBundle.mainBundle().infoDictionary!
        let bundleName = (infoDictionary["CFBundleName"] as! String).stringByReplacingOccurrencesOfString(" ", withString: "_", options: .CaseInsensitiveSearch, range: nil)
        
        return bundleName
    }
}