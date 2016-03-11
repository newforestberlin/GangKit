//
//  NSDateFormatter+DefaultFormatters.swift
//  GangKit
//
//  Created by Ricki Gregersen on 11/03/16.
//  Copyright © 2016 youandthegang.com. All rights reserved.
//

import Foundation

public extension NSDateFormatter {
    
    @nonobjc static let EEEEFormatter = NSDateFormatter.create(NSLocale.currentLocale(), format: "EEEE")
    @nonobjc static let EEEFormatter = NSDateFormatter.create(NSLocale.currentLocale(), format: "EEE")
    @nonobjc static let HHmmFormatter = NSDateFormatter.create(NSLocale.currentLocale(), format: "HH:mm")
    @nonobjc static let MMMddFormatter = NSDateFormatter.create(NSLocale.currentLocale(), format: "MMM dd")
    
    public class func create(locale: NSLocale, format: String) -> NSDateFormatter {
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.dateFormat = format
        return formatter
    }
    
    public class func string(format: DateFormat) -> String {
        return format.string
    }
    
    public enum DateFormat {
        
        case EEEE(date: NSDate)
        case EEE(date: NSDate)
        case HHmm(date: NSDate)
        case MMMdd(date: NSDate)
        
        public var string: String {
            switch self {
            case .EEEE(let date):
                return EEEEFormatter.stringFromDate(date)
            case .EEE(let date):
                return EEEFormatter.stringFromDate(date)
            case .HHmm(let date):
                return HHmmFormatter.stringFromDate(date)
            case .MMMdd(let date):
                return MMMddFormatter.stringFromDate(date)
            }
        }
    }
}