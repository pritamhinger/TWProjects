//
//  TWPAddProjectViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPAddProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var customModalTransitioningDelegate: TWPCustomModalTransitioningDelegate?
    var chosenIndexPath:NSIndexPath?
    var startDate:NSDate?
    var endDate:NSDate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TWPAddProjectViewController.setDate(_:)), name: AppConstants.NotificationName.DateChosenNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AppConstants.NotificationName.DateChosenNotification, object: nil)
    }
    
    @IBAction func cancelAddProjectForm(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveProject(sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == AppConstants.SegueIdentifier.DateTimePickerSegue{
            let dateTimePickerVC = self.storyboard?.instantiateViewControllerWithIdentifier(AppConstants.StoryboardVCIdentifier.DateTimePickerVCId) as! TWPDateTimePickerViewController

            self.customModalTransitioningDelegate = TWPCustomModalTransitioningDelegate(viewController: self, presentingViewController: dateTimePickerVC)
            segue.destinationViewController.modalPresentationStyle = .Custom
            segue.destinationViewController.transitioningDelegate = customModalTransitioningDelegate
        }
    }
}
