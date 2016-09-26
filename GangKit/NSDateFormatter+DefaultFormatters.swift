//
//  NSDateFormatter+DefaultFormatters.swift
//  GangKit
//
//  Created by Ricki Gregersen on 11/03/16.
//  Copyright © 2016 youandthegang.com. All rights reserved.
//

import Foundation

public extension DateFormatter {
    
    @nonobjc static let EEEEFormatter = DateFormatter.create(Locale.current, format: "EEEE")
    @nonobjc static let EEEFormatter = DateFormatter.create(Locale.current, format: "EEE")
    @nonobjc static let HHmmFormatter = DateFormatter.create(Locale.current, format: "HH:mm")
    @nonobjc static let MMMddFormatter = DateFormatter.create(Locale.current, format: "MMM dd")
    @nonobjc static let EEEEMMMddAtHHmmFormatter = DateFormatter.create(Locale.current, format: "EEEE MMM dd 'at' HH:mm")
    @nonobjc static let EEEMMMddFormatter = DateFormatter.create(Locale.current, format: "EEE, MMM dd")
    
    public class func create(_ locale: Locale, format: String) -> DateFormatter {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter
    }
    
    public class func string(_ format: DateFormat) -> String {
        return format.string
    }
    
    public enum DateFormat {
        
        case eeee(date: Date)
        case eee(date: Date)
        case hHmm(date: Date)
        case mmMdd(date: Date)
        case eeeemmMddAtHHmm(date: Date)
        case eeemmMdd(date: Date)
        
        public var string: String {
            switch self {
            case .eeee(let date):
                return EEEEFormatter.string(from: date)
            case .eee(let date):
                return EEEFormatter.string(from: date)
            case .hHmm(let date):
                return HHmmFormatter.string(from: date)
            case .mmMdd(let date):
                return MMMddFormatter.string(from: date)
            case .eeeemmMddAtHHmm(let date):
                return EEEEMMMddAtHHmmFormatter.string(from: date)
            case .eeemmMdd(let date):
                return EEEMMMddFormatter.string(from: date)
            }
        }
    }
}
