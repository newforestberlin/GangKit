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

open class Persist {
    
    fileprivate class func defaults() ->UserDefaults {
        return UserDefaults.standard
    }
    
    fileprivate class func synchronize() {
        Persist.defaults().synchronize()
    }
    
    fileprivate class func prefix() -> String {
        if let identifier = Bundle.main.bundleIdentifier {
            return identifier
        }
        return "unique.random.com"
    }
    
    fileprivate class func prefixedKey(forKey key: String) ->String {
        return "\(Persist.prefix()).\(key))"
    }
    
    //Clears all values with the app prefix
    
    open class func resetDefaults() {
        
        let prefix = Persist.prefix()
        
        for (key, _) in Persist.defaults().dictionaryRepresentation() {
            if key.hasPrefix(prefix) {
                Persist.defaults().removeObject(forKey: key)
            }
        }
        
        Persist.synchronize()
    }
    
    open class func persist(value: Any?, forKey key: String) {
		guard let value = value else {
			Persist.remove(valueForKey: key)
			Persist.defaults().synchronize()
			return
		}

		Persist.defaults().set(value, forKey: Persist.prefixedKey(forKey: key))
		Persist.defaults().synchronize()
//
//        if value == nil {
//            Persist.remove(valueForKey: key)
//        } else {
//			Persist.defaults().set(value, forKey: Persist.prefixedKey(forKey: key))
////            Persist.defaults().setValue(value, forKey: Persist.prefixedKey(forKey: key))
//        }
//        Persist.defaults().synchronize()
    }
    
    open class func retrieve(valueforKey key: String) ->Any? {
    
        if let value = Persist.defaults().value(forKey: Persist.prefixedKey(forKey: key)) {
            return value as Any?
        }
        return nil
    }
    
    open class func remove(valueForKey key: String) {
        
        Persist.defaults().removeObject(forKey: Persist.prefixedKey(forKey: key))
        Persist.synchronize()
    }
}


