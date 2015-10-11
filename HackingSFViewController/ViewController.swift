//
//  ViewController.swift
//  HackingSFViewController
//
//  Created by stringCode on 10/10/2015.
//  Copyright © 2015 stringCode. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate, UIViewControllerTransitioningDelegate {

    let animator = SCModalPushPopAnimator()
    
    @IBAction func showSafariViewController(sender: AnyObject){
        let safariViewController = SCSafariViewController(URL: NSURL(string: "http://www.stringcode.co.uk")!)
        safariViewController.delegate = self;
        safariViewController.transitioningDelegate = self
        self.presentViewController(safariViewController, animated: true) { () -> Void in
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleGesture:")
            recognizer.edges = UIRectEdge.Left
            safariViewController.edgeView?.addGestureRecognizer(recognizer)
        }
    }
    
    func handleGesture(recognizer:UIScreenEdgePanGestureRecognizer) {
        self.animator.percentageDriven = true
        let percentComplete = recognizer.locationInView(view).x / view.bounds.size.width / 2.0
        switch recognizer.state {
        case .Began: dismissViewControllerAnimated(true, completion: nil)
        case .Changed: animator.updateInteractiveTransition(percentComplete > 0.99 ? 0.99 : percentComplete)
        case .Ended, .Cancelled:
            (recognizer.velocityInView(view).x < 0) ? animator.cancelInteractiveTransition() : animator.finishInteractiveTransition()
            self.animator.percentageDriven = false
        default: ()
        }
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismissing = false
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismissing = true
        return animator
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.animator.percentageDriven ? self.animator : nil
    }
    
}

