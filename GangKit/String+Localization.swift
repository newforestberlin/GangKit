//
//  String+Localization.swift
//  GangKit
//
//  Created by Ricki Gregersen on 30/07/15.
//  Copyright (c) 2015 you & the gang. All rights reserved.
//

import Foundation

extension String {
    
    func localize(comment comment: String) ->String {
        return NSLocalizedString(self, comment: comment)
    }
}