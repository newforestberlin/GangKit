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


import Foundation
import CoreGraphics

public extension Int {
    /**
    Returns a random integer between 0 and n-1.
    */
    public static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /**
    Create a random num Int
    :param: lower number Int
    :param: upper number Int
    :return: random number Int
    By DaRkDOG
    */
    public static func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
public extension Double {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /**
    Create a random num Double
    :param: lower number Double
    :param: upper number Double
    :return: random number Double
    By DaRkDOG
    */
    public static func random(min: Double, max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}
public extension Float {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    /**
    Create a random num Float
    :param: lower number Float
    :param: upper number Float
    :return: random number Float
    By DaRkDOG
    */
    public static func random(min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}
public extension CGFloat {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    /**
    Create a random num CGFloat
    :param: lower number CGFloat
    :param: upper number CGFloat
    :return: random number CGFloat
    By DaRkDOG
    */
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}
public extension CGPoint {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> CGPoint {
        return CGPoint(x: CGFloat.random(), y: CGFloat.random())
    }
    /**
    Create a random num CGFloat
    :param: lower number CGFloat
    :param: upper number CGFloat
    :return: random number CGFloat
    By DaRkDOG
    */
    public static func random(min: CGFloat, max: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat.random(min: min, max: max), y: CGFloat.random(min: min, max: max))
    }
}



