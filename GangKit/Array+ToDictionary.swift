//
//  Array+ToDictionary.swift
//  GangKit
//
//  Created by Olee on 05.11.15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import Foundation

extension Array {
    
    func toDictionary<K, V>(transformer: (element: Element) -> (key: K, value: V)?) -> Dictionary<K, V> {
        return self.reduce([:]) { (var dict, e) in
            if let (key, value) = transformer(element: e) {
                dict[key] = value
            }
            return dict
        }
    }    

}