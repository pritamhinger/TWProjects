//
//  TWPCustomModalInteractiveTransition.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPCustomModalInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController
    var presentingViewController: UIViewController?
    var panGestureRecognizer: UIPanGestureRecognizer
    
    var shouldComplete: Bool = false
    
    override var completionSpeed: CGFloat {
        get{
            return 1.0 - self.percentComplete
        }
        set{}
    }
    
    init(viewController: UIViewController, withView view:UIView, presentingViewController: UIViewController?) {
        self.panGestureRecognizer = UIPanGestureRecognizer()
        self.viewController = viewController
        super.init()
        self.presentingViewController = presentingViewController
        self.panGestureRecognizer.addTarget(self, action: #selector(TWPCustomModalInteractiveTransition.panRecognizerHandler(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
    }
    
    func panRecognizerHandler(panRecognizer: UIPanGestureRecognizer) -> Void {
        let translation = panRecognizer.translationInView(panRecognizer.view?.superview)
        
        switch panRecognizer.state {
        case .Began:
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            break
        case .Changed:
            let screenHeight = UIScreen.mainScreen().bounds.size.height - 50
            let dragAmount = screenHeight
            let threshold: Float = 0.2
            var percent: Float = Float(translation.y) / Float(dragAmount)
            
            percent = fmaxf(percent, 0.0)
            percent = fminf(percent, 1.0)
            
            updateInteractiveTransition(CGFloat(percent))
            shouldComplete = percent > threshold
            break
        case .Ended, .Cancelled:
            if panRecognizer.state == .Cancelled || !shouldComplete {
                cancelInteractiveTransition()
            }
            else {
                finishInteractiveTransition()
            }
            break
        default:
            cancelInteractiveTransition()
        }
    }
}
