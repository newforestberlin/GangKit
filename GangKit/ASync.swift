//
//  ASync.swift
//  GangKit
//
//  Created by Ole Krause-Sparmann on 17.02.15.
//  Copyright (c) 2015 HelloFresh GmbH. All rights reserved.
//

import Foundation

class ASync {
    
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}