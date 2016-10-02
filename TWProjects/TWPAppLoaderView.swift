//
//  TWPAppLoaderView.swift
//  TWProjects
//
//  Created by Pritam Hinger on 02/10/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

protocol AppLoaderViewDelegate:class {
    func animateCompanyLabel()
}

class TWPAppLoaderView: UIView {
    
    var parentFrame:CGRect = CGRectZero
    weak var delegate:AppLoaderViewDelegate?
    
    let circleLayer = CircleLayer()
    let triangleLayer = TriangleLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addCirclePath() {
        layer.addSublayer(circleLayer)
        circleLayer.expand()
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(TWPAppLoaderView.shakeCircle), userInfo: nil, repeats: false)
    }
    
    func shakeCircle() {
        circleLayer.wobbleCircle()
        layer.addSublayer(triangleLayer)
        circleLayer.wobbleCircle()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(TWPAppLoaderView.drawTriangleWithAnimation), userInfo: nil, repeats: false)
    }
    
    func drawTriangleWithAnimation() {
        triangleLayer.animateTriangle()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(TWPAppLoaderView.spinAndTransformTriangle), userInfo: nil, repeats: false)
    }
    
    func spinAndTransformTriangle(){
        layer.anchorPoint = CGPointMake(0.5, 0.6)
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
        circleLayer.collapseCircle()
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
