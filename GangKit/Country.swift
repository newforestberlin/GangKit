//
//  Country.swift
//  GangKit
//
//  Created by Olee on 13.05.16.
//  Copyright © 2016 youandthegang.com. All rights reserved.
//

import Foundation

public struct Country {
    
    public let localizedDisplayName: String
    public let isoCode: String
    
    public static func allCountries() -> [Country] {
        
        var result = [Country]()
        
        for code in Locale.isoRegionCodes as [String] {
            let id = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            result.append(Country(localizedDisplayName: name, isoCode: code))
        }
        
        return result
    }
    
    public static func country(withISOCode isoCode: String) -> Country? {
        return Country.allCountries().filter { $0.isoCode.lowercased() == isoCode.lowercased() }.first
    }

}

