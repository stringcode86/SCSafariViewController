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

    var animator: SCPopAnimator? = SCPopAnimator()
    
    @IBAction func showSafariViewController(sender: AnyObject){
        let url = NSURL(string: "http://www.theverge.com")
        let safariViewController = SCSafariViewController(URL: url!)
        safariViewController.delegate = self;
        safariViewController.transitioningDelegate = self
        self.presentViewController(safariViewController, animated: true) { () -> Void in
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleGesture:")
            recognizer.edges = UIRectEdge.Left
            safariViewController.edgeView?.addGestureRecognizer(recognizer)
        }
    }
    
    func handleGesture(recognizer:UIScreenEdgePanGestureRecognizer) {
        self.animator?.percentageDriven = true
        let percentComplete = recognizer.locationInView(view).x / view.bounds.size.width / 2.0
        switch recognizer.state {
        case .Began: dismissViewControllerAnimated(true, completion: nil)
        case .Changed: animator?.updateInteractiveTransition(percentComplete)
        case .Ended, .Cancelled:
            (recognizer.velocityInView(view).x < 0) ? animator?.cancelInteractiveTransition() : animator?.finishInteractiveTransition()
            self.animator?.percentageDriven = false
        default: ()
        }
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let _animator = self.animator {
            return _animator.percentageDriven ? _animator : nil
        }
        return nil
    }
}

