//
//  Persist.swift
//  OfficerAPIDev
//
//  Created by Olee on 12.10.15.
//  Copyright © 2015 you & the gang. All rights reserved.
//

import UIKit

public class Persist {
    
    private class func defaults() ->NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    private class func synchronize() {
        Persist.defaults().synchronize()
    }
    
    private class func prefix() -> String {
        if let identifier = NSBundle.mainBundle().bundleIdentifier {
            return identifier
        }
        return "unique.random.com"
    }
    
    private class func prefixedKey(forKey key: String) ->String {
        return "\(Persist.prefix()).\(key))"
    }
    
    //Clears all values with the app prefix
    
    public class func resetDefaults() {
        
        let prefix = Persist.prefix()
        
        for (key, _) in Persist.defaults().dictionaryRepresentation() {
            if key.hasPrefix(prefix) {
                Persist.defaults().removeObjectForKey(key)
            }
        }
        
        Persist.synchronize()
    }
    
    public class func persist(value value: AnyObject?, forKey key: String) {
        
        if value == nil {
            Persist.remove(valueForKey: key)
        } else {
            Persist.defaults().setValue(value, forKey: Persist.prefixedKey(forKey: key))
        }
        Persist.defaults().synchronize()
    }
    
    public class func retrieve(valueforKey key: String) ->AnyObject? {
    
        if let value = Persist.defaults().valueForKey(Persist.prefixedKey(forKey: key)) {
            return value
        }
        return nil
    }
    
    public class func remove(valueForKey key: String) {
        
        Persist.defaults().removeObjectForKey(Persist.prefixedKey(forKey: key))
        Persist.synchronize()
    }
}


