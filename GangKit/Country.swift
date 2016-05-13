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
        
        for code in NSLocale.ISOCountryCodes() as [String] {
            let id = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode: code])
            let name = NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: id) ?? "Country not found for code: \(code)"
            result.append(Country(localizedDisplayName: name, isoCode: code))
        }
        
        return result
    }

}

