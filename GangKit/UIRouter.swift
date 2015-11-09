//
//  UIRouter.swift
//  OfficerAPIDev
//
//  Created by Olee on 12.10.15.
//  Copyright © 2015 you & the gang. All rights reserved.
//

import UIKit

// Type of storyboards we use. The raw values are used as actual storyboard file names during loading.
public enum StoryboardType: String {
    
    case Onboarding = "Onboarding"
    case Main = "Main"
    
}

// This map is used to determine which storyboard a certain view controller from.
public let UIRouterStoryboardMap = [String : StoryboardType]()// = [
    
//    UIRouter.className(WelcomeViewController): StoryboardType.Onboarding,
//    UIRouter.className(OnboardingViewController): StoryboardType.Onboarding,
//    UIRouter.className(ColorPickerViewController): StoryboardType.Onboarding
    
//    UIRouter.className(OfficeViewController): StoryboardType.Onboarding
//]

public class UIRouter {
    
    public class func instantiateInitialViewControllerFromStoryboard(type: StoryboardType) -> UIViewController? {
        let storyboard = UIStoryboard(name: type.rawValue, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
    
    // Loads vc from storyboard
    public class func loadViewController(vcClass vcClass: AnyClass) -> UIViewController? {
        if let storyboardType = UIRouterStoryboardMap[UIRouter.className(vcClass)] {
            return loadViewControllerFromStoryboard(storyboardType, vcClass: vcClass)
        }
        return nil
    }
    
    // Loads vc from storyboard
    public class func loadViewController(storyboardIdentifier storyboardIdentifier: String) -> UIViewController? {
        
        if let storyboardType = UIRouterStoryboardMap[storyboardIdentifier] {
            return loadViewControllerFromStoryboard(storyboardType, storyboardIdentifier: storyboardIdentifier)
        }
        return nil
    }
    
    // Strips all prefixes from class name
    public class func className(vcClass: AnyClass) -> String {
        
        if let vcClassName = String.fromCString(class_getName(vcClass)) {
            return vcClassName.stringByReplacingOccurrencesOfString("\(UIApplication.currentTarget()).", withString: "")
        }
        
        return ""
    }
    
    // Loads vc from storyboard
    private class func loadViewControllerFromStoryboard(storyboardType: StoryboardType, vcClass: AnyClass) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
        
        if let vcClassName = String.fromCString(class_getName(vcClass)) {
            let justTheClassName = vcClassName.stringByReplacingOccurrencesOfString("\(UIApplication.currentTarget()).", withString: "")
            return storyboard.instantiateViewControllerWithIdentifier(justTheClassName)
        }
        return nil
    }
    
    // Loads vc from storyboard
    private class func loadViewControllerFromStoryboard(storyboardType: StoryboardType, storyboardIdentifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
        
        return storyboard.instantiateViewControllerWithIdentifier(storyboardIdentifier)
    }
    
}
