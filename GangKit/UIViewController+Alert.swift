//
//  UIViewController+Alert.swift
//  GangKit
//
//  Created by Olee on 12.10.15.
//  Copyright © 2015 you & the gang. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(title title: String, message: String, completion: () -> ()) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            completion()
        }
        
        alertVC.addAction(okAction)
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }

    func alert(title title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
        }
        
        alertVC.addAction(okAction)
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func alertQuestion(title title: String, question: String, completion: (yes: Bool) -> ()) {
        
        let alertVC = UIAlertController(title: title, message: question, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) -> Void in
            completion(yes: true)
        }
        alertVC.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .Default) { (action) -> Void in
            completion(yes: false)
        }
        alertVC.addAction(noAction)

        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
}



