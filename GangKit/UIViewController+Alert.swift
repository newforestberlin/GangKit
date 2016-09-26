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

public extension UIViewController {
    
    public func alert(title: String, message: String, completion: @escaping () -> ()) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            completion()
        }
        
        alertVC.addAction(okAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }

    public func alert(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        }
        
        alertVC.addAction(okAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    public func alertQuestion(title: String, question: String, completion: @escaping (_ yes: Bool) -> ()) {
        
        let alertVC = UIAlertController(title: title, message: question, preferredStyle: UIAlertControllerStyle.alert)
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            completion(false)
        }
        alertVC.addAction(noAction)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            completion(true)
        }
        alertVC.addAction(yesAction)

        self.present(alertVC, animated: true, completion: nil)
    }
    
    public func alertQuestion(title: String, question: String, yes: String, no: String, completion: @escaping (_ yes: Bool) -> ()) {
        
        let alertVC = UIAlertController(title: title, message: question, preferredStyle: UIAlertControllerStyle.alert)
        
        let noAction = UIAlertAction(title: no, style: .default) { (action) -> Void in
            completion(false)
        }
        alertVC.addAction(noAction)
        
        let yesAction = UIAlertAction(title: yes, style: .default) { (action) -> Void in
            completion(true)
        }
        alertVC.addAction(yesAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }

}



