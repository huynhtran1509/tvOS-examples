//
//  DetailViewController.swift
//  tvOS-Examples
//
//  Copyright (c) 2016 WillowTree, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var topRightButton: UIButton!
    @IBOutlet var bottomLeftButton: UIButton!
    
    var toTopRightFocusGuide: UIFocusGuide!
    var toBottomLeftFocusGuide: UIFocusGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Focus guide that will allow a swipe up from the bottom button to focus on the top button
        self.toTopRightFocusGuide = UIFocusGuide()
        self.view.addLayoutGuide(self.toTopRightFocusGuide)
        self.toTopRightFocusGuide.preferredFocusedView = topRightButton
        
        // Focus guide that will allow a swipe down from the top button to focus on the bottom left 
        // button
        self.toBottomLeftFocusGuide = UIFocusGuide()
        self.view.addLayoutGuide(self.toBottomLeftFocusGuide)
        self.toBottomLeftFocusGuide.preferredFocusedView = bottomLeftButton

        // Add constraints to the focus guides
        let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:[toBottomFocusGuide(1)]-(0)-[toTopFocusGuide(1)]-(0)-[button]", options: [], metrics: nil, views: ["toBottomFocusGuide": self.toBottomLeftFocusGuide, "toTopFocusGuide": self.toTopRightFocusGuide,
            "button": self.bottomLeftButton])
        
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("|[focusGuide]|", options: [], metrics: nil, views: ["focusGuide": self.toTopRightFocusGuide])
        let toBottomHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("|[toBottomHorizontal]|", options: [], metrics: nil, views: ["toBottomHorizontal": self.toBottomLeftFocusGuide])
        self.view.addConstraints(vertical + horizontal + toBottomHorizontal)
    }
}
