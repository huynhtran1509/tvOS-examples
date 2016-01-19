//
//  CustomFocusEffectsCollectionViewController.swift
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
//

import UIKit

private let reuseIdentifier = "Cell"

class CustomFocusCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    var gradient: CAGradientLayer!
    
    override func awakeFromNib() {
        self.gradient = CAGradientLayer()
        self.gradient.colors = [UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor, UIColor(white: 0.0, alpha: 0.0).CGColor]
        self.gradient.startPoint = CGPointMake(0.5, 1)
        self.gradient.endPoint = CGPointMake(0.5, 0.5)
        self.gradient.frame = gradientView.bounds
        self.gradientView.layer.addSublayer(self.gradient)
        
        self.titleLabel.font = UIFont.systemFontOfSize(25.0, weight: UIFontWeightLight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient.frame = self.imageView.bounds
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        coordinator.addCoordinatedAnimations({ () -> Void in
            if context.nextFocusedView === self {
                self.enableFocusedState()
            } else {
                self.disableFocusedState()
            }

        }, completion: nil)
    }
    
    func enableFocusedState() {
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -3
        horizontalMotionEffect.maximumRelativeValue = 3
        self.titleLabel.addMotionEffect(horizontalMotionEffect)
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -3
        verticalMotionEffect.maximumRelativeValue = 3
        self.titleLabel.addMotionEffect(verticalMotionEffect)
        
        self.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2)
        
        let gradientHorizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        gradientHorizontalMotionEffect.minimumRelativeValue = -15
        gradientHorizontalMotionEffect.maximumRelativeValue = 15
        self.gradientView.addMotionEffect(gradientHorizontalMotionEffect)
        
        let gradientVerticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        gradientVerticalMotionEffect.minimumRelativeValue = -15
        gradientVerticalMotionEffect.maximumRelativeValue = 15
        self.gradientView.addMotionEffect(gradientVerticalMotionEffect)
        
        self.gradientView.transform = CGAffineTransformMakeScale(1.35, 1.35)

    }
    
    func disableFocusedState() {
        self.titleLabel.motionEffects.forEach { self.titleLabel.removeMotionEffect($0) }
        self.gradientView.motionEffects.forEach { self.gradientView.removeMotionEffect($0) }
        
        self.gradientView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.titleLabel.transform = CGAffineTransformIdentity
        self.titleLabel.font = UIFont.systemFontOfSize(25.0, weight: UIFontWeightLight)

    }
}

class CustomFocusEffectsCollectionViewController: UICollectionViewController {

    // MARK: UICollectionViewDataSource

    let imageArray = ["goat1", "goat2", "goat3", "goat4", "goat5", "goat6", "goat7"]
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        if let imageCell = cell as? CustomFocusCell {
            imageCell.imageView.image = UIImage(named: imageArray[indexPath.item % imageArray.count])
        }
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController {
            self.presentViewController(detail, animated: true, completion: nil)
        }
    }
}
