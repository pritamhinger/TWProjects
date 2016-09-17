//
//  TWPDateTimePickerViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPDateTimePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dateSelected(sender: AnyObject) {
        if let delegate = self.transitioningDelegate as? TWPCustomModalTransitioningDelegate{
            delegate.interactiveDismiss = false
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
