//
//  SCAnimator.swift
//  SCUtils
//
//  Created by stringCode on 3/1/15.
//  Copyright (c) 2015 stringCode. All rights reserved.
//

import UIKit

class SCPopAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    var percentageDriven: Bool = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        transitionContext.containerView()!.insertSubview(toView!, belowSubview: fromViewController!.view)
        
    
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: SCPopAnimator.animOpts(), animations: { () -> Void in
                fromViewController?.view.transform = CGAffineTransformMakeTranslation(UIScreen.mainScreen().bounds.size.width, 0)
            }) { (finished ) -> Void in
                fromViewController?.view.transform = CGAffineTransformIdentity
                transitionContext.completeTransition(finished)
        }
    }
    
    class func animOpts() -> UIViewAnimationOptions {
        return UIViewAnimationOptions.AllowAnimatedContent.union(UIViewAnimationOptions.BeginFromCurrentState).union(UIViewAnimationOptions.LayoutSubviews)
    }
}