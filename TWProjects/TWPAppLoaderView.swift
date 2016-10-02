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
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
