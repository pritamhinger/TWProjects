//
//  TWPDateTimePickerViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPDateTimePickerViewController: UIViewController {

    @IBOutlet weak var dateTimePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func setTodayDate(sender: UIBarButtonItem) {
        dateTimePicker.setDate(NSDate(), animated: true)
    }
    
    @IBAction func dateSelected(sender: AnyObject) {
        if let delegate = self.transitioningDelegate as? TWPCustomModalTransitioningDelegate{
            delegate.interactiveDismiss = false
        }
        
        print(dateTimePicker.date)
        NSNotificationCenter.defaultCenter().postNotificationName(AppConstants.NotificationName.DateChosenNotification, object: nil, userInfo: ["ChosenDate":dateTimePicker.date])
        dismissViewControllerAnimated(true, completion: nil)
    }
}
