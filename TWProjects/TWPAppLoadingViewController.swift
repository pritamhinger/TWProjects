//
//  TWPAppLoadingViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 02/10/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPAppLoadingViewController: UIViewController, AppLoaderViewDelegate {

    var appLoaderView = TWPAppLoaderView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addLoaderView()
    }
    
    func animateCompanyLabel() {
        appLoaderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        let label = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "AvenirNext-Bold", size: 170.0)
        label.textAlignment = .Center
        label.text = "TW"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        
        let frame = CGRectMake(label.frame.origin.x, label.frame.origin.y + label.frame.height, label.frame.width, CGFloat(25))
        let label2 = UILabel(frame: frame)
        label2.textColor = Colors.white
        label2.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label2.textAlignment = .Center
        label2.text = "Projects"
        label2.transform = CGAffineTransformScale(label2.transform, 0.25, 0.25)
        view.addSubview(label2)
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .CurveEaseInOut, animations: {
            label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            label2.transform = CGAffineTransformScale(label2.transform, 4.0, 4.0)
            }, completion: { finished in
        })
    }
    
    func addLoaderView() {
        let viewBox:CGFloat = 100.0
        appLoaderView.frame = CGRect(x: view.bounds.width/2 - viewBox/2,
                                     y: view.bounds.height/2 - viewBox/2,
                                     width: viewBox,
                                     height: viewBox)
        appLoaderView.parentFrame = view.frame
        appLoaderView.delegate = self
        view.addSubview(appLoaderView)
        appLoaderView.addCirclePath()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
