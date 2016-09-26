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

public extension UINib {
    
    public class func instantiateView<T>(fromNib name: String) -> T? {
        
        if let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T {
            return view
        }
        
        return nil
    }
}

public extension UIView {
    
    public class func loadViewFromNib<T: UIView>(_ nibName: String) -> T? {
        return UINib.instantiateView(fromNib: nibName) as T?
    }
    
    // Be aware that this removes the constraints from self and copies them to the loaded view!
    // This should be called from awakeAfterUsingCoder, like this:
    // return viewFromNib("TimerStatusView") ?? self
    public func viewFromNib<T: UIView>(_ nibName: String) -> T? {
        if subviews.count == 0 {
            if let view = UIView.loadViewFromNib(nibName) as? T {
                view.translatesAutoresizingMaskIntoConstraints = false
                let contraints = self.constraints
                self.removeConstraints(contraints)
                view.addConstraints(contraints)
                
                return view
            }
        }
        
        return nil
    }
    
}
