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
}
