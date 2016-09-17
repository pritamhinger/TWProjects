//
//  TWPCustomPresentationController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPCustomPresentationController: UIPresentationController {
    var _backgroundView:UIView?
    var backgroundView:UIView{
        if let bgView = _backgroundView{
            return bgView
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (containerView?.bounds.width)!, height: (containerView?.bounds.height)!))
        
        // Adding Blur Effect to View
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        
        // Adding Vibrancy Effect to Blur Effect View
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        
        _backgroundView = view
        return view
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        return CGRect(x: 0, y: (containerView?.bounds.height)!/2, width: (containerView?.bounds.width)!, height: (containerView?.bounds.height)!/2)
    }
    
    override func presentationTransitionWillBegin() {
        let bgView = backgroundView
        if let containerView = self.containerView, coordinator = presentingViewController.transitionCoordinator(){
            bgView.alpha = 0.0
            containerView.addSubview(bgView)
            bgView.addSubview(presentedViewController.view)
            coordinator.animateAlongsideTransition({ (context) -> Void in
                bgView.alpha = 1.0
                self.presentingViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator(){
            coordinator.animateAlongsideTransition({ (context) -> Void in
                self.backgroundView.alpha = 0
                self.presentingViewController.view.transform = CGAffineTransformIdentity
                }, completion: { (completed) -> Void in
                    
            })
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed{
            backgroundView.removeFromSuperview()
            _backgroundView = nil
        }
    }
}
