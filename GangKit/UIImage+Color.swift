//
//  UIImage+Color.swift
//  UIImageGangKit
//
//  Created by Olee on 09.08.15.
//  Copyright (c) 2015 you & the gang. All rights reserved.
//

import UIKit

public extension UIImage {

    public class func color(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}