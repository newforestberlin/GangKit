//
//  ModalDismissable.swift
//  OfficeBacon
//
//  Created by Ricki Gregersen on 01/10/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import UIKit

public protocol ModalDismissable {
    
    func dismiss(viewController viewController: UIViewController, animated: Bool)
    
}