//
//  TWPCustomModalTransitionAnimator.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPCustomModalTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    override init() {
        super.init()
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            fromView!.view.frame.origin.y = 800
            }, completion: { (completed) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
}

internal enum TWPCustomModalTransitionAnimatorType {
    case Present
    case Dismiss
}
