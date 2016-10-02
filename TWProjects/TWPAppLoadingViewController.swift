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
