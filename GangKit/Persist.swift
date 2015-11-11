// The MIT License (MIT)
//
// Copyright (c) 2015 you & the gang UG(haftungsbeschränkt)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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


