//
//  CircleLayer.swift
//  TWProjects
//
//  Created by Pritam Hinger on 02/10/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class CircleLayer: CAShapeLayer {

    override init() {
        super.init()
        fillColor = Colors.red.CGColor
        path = circlePathZero.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CircleLayer init not implemented")
    }
    
    var circlePathZero: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 50.0, y: 50.0, width: 0.0, height: 0.0))
    }
    
    var circlePathFull: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 17.5, width: 95.0, height: 95.0))
    }
    
    var circlePathMoveVertical: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 20.0, width: 95.0, height: 90.0))
    }
    
    var circlePathMoveHorizontal: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 5.0, y: 20.0, width: 90.0, height: 90.0))
    }
    
    func expand() {
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = circlePathZero.CGPath
        expandAnimation.toValue = circlePathFull.CGPath
        expandAnimation.duration = AppConstants.DurationContants.Animation
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        addAnimation(expandAnimation, forKey: nil)
    }
    
    func wobbleCircle() {
        let wobbleAnimation1: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation1.fromValue = circlePathFull.CGPath
        wobbleAnimation1.toValue = circlePathMoveVertical.CGPath
        wobbleAnimation1.beginTime = 0.0
        wobbleAnimation1.duration = AppConstants.DurationContants.Animation
        
        let wobbleAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation2.fromValue = circlePathMoveVertical.CGPath
        wobbleAnimation2.toValue = circlePathMoveHorizontal.CGPath
        wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
        wobbleAnimation2.duration = AppConstants.DurationContants.Animation
        
        let wobbleAnimation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation3.fromValue = circlePathMoveHorizontal.CGPath
        wobbleAnimation3.toValue = circlePathMoveVertical.CGPath
        wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
        wobbleAnimation3.duration = AppConstants.DurationContants.Animation
        
        let wobbleAnimation4: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation4.fromValue = circlePathMoveVertical.CGPath
        wobbleAnimation4.toValue = circlePathFull.CGPath
        wobbleAnimation4.beginTime = wobbleAnimation3.beginTime + wobbleAnimation3.duration
        wobbleAnimation4.duration = AppConstants.DurationContants.Animation
        
        let wobbleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3, wobbleAnimation4]
        wobbleAnimationGroup.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
        wobbleAnimationGroup.repeatCount = 2
        addAnimation(wobbleAnimationGroup, forKey: nil)
    }
    
    func collapseCircle(){
        let collapseAnimation = CABasicAnimation(keyPath: "path")
        collapseAnimation.fromValue = circlePathFull.CGPath
        collapseAnimation.toValue = circlePathZero.CGPath
        collapseAnimation.beginTime = 0.0
        collapseAnimation.duration = AppConstants.DurationContants.Animation
        collapseAnimation.fillMode = kCAFillModeForwards
        collapseAnimation.removedOnCompletion = false
        addAnimation(collapseAnimation, forKey: nil)
    }
}
