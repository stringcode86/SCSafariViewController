//
//  SCAnimator.swift
//  SCUtils
//
//  Created by stringCode on 3/1/15.
//  Copyright (c) 2015 stringCode. All rights reserved.
//

import UIKit

class SCPopAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    var dismissing = false
    var percentageDriven: Bool = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let view = dismissing ? fromViewController.view : toViewController.view
        let offset = UIScreen.mainScreen().bounds.size.width
        
        transitionContext.containerView()?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        if dismissing { transitionContext.containerView()?.insertSubview(toViewController.view, belowSubview: fromViewController.view) }
        
        view.frame = fromViewController.view.frame
        view.transform = dismissing ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(offset, 0)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: SCPopAnimator.animOpts(), animations: { () -> Void in
                view.transform = self.dismissing ? CGAffineTransformMakeTranslation(offset, 0) : CGAffineTransformIdentity
            }) { (finished ) -> Void in
                view.transform = CGAffineTransformIdentity
                transitionContext.completeTransition(finished)
        }
    }
    
    class func animOpts() -> UIViewAnimationOptions {
        return UIViewAnimationOptions.AllowAnimatedContent.union(UIViewAnimationOptions.BeginFromCurrentState).union(UIViewAnimationOptions.LayoutSubviews)
    }
}