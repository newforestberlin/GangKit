//
//  NSDate+Calculations.swift
//  GangKit
//
//  Created by Ricki Gregersen on 02/06/16.
//  Copyright © 2016 youandthegang.com. All rights reserved.
//

import Foundation

public func <(a: NSDate, b: NSDate) -> Bool {
	return a.compare(b) == NSComparisonResult.OrderedAscending
}

public func ==(a: NSDate, b: NSDate) -> Bool {
	return a.compare(b) == NSComparisonResult.OrderedSame
}

public extension NSDate: Comparable { }