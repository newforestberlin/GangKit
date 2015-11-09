//
//  GangKitTests.swift
//  GangKitTests
//
//  Created by Ricki Gregersen on 09/11/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import XCTest
import GangKit

class GangKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testMutableAttributesStringExtension() {
//        
//        let font = UIFont.systemFontOfSize(10, weight: UIFontWeightBold)
//        let color = UIColor.cyanColor()
//        let substring = "Hello"
//        let range = NSMakeRange(0, substring.characters.count)
//        let mutableString = NSMutableAttributedString(string: "\(substring), World")
//
//        mutableString.setColor(color, subString: substring)
//        mutableString.setFont(font, subString: substring)
//        
//        mutableString.attributesAtIndex(<#T##location: Int##Int#>, effectiveRange: <#T##NSRangePointer#>)
//        let measuredColor: UIColor = mutableString.attribute(NSForegroundColorAttributeName, atIndex: 0, effectiveRange: range)
//        let measuredFont: UIFont = mutableString.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: range)
//        
//        XCTAssert(color == measuredColor, "Wrong color detected")
//        XCTAssert(font == measuredFont, "Wrong font detected")
//    }
    
    func testPersistUtility() {
        
        let value = "Hello, World"
        let key = "persistenceKey"
        Persist.persist(value: value, forKey: key)
        if let retrievedValue = Persist.retrieve(valueforKey: key) as? String {
            
            XCTAssert(retrievedValue == value, "Value not retrieved correctly")
        } else {
            XCTAssert(false, "Value not of type String")
        }

        Persist.resetDefaults()
        
        XCTAssert(Persist.retrieve(valueforKey: key) == nil, "Persist store not correctly reset")
    }
    
    func testASync() {
        
        let expectation = self.expectationWithDescription("Async delay")
        
        ASync.delay(1) { () -> () in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
