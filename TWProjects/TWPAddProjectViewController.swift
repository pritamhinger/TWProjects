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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AppConstants.CellIdentifier.ProjectPropertyCell, forIndexPath: indexPath) as UITableViewCell
        
        cell.detailTextLabel?.text = ""
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Company: "
        case 1:
            cell.textLabel?.text = "Tags: "
            cell.detailTextLabel?.text = "Not Tagged"
        case 2:
            cell.textLabel?.text = "Category: "
            cell.detailTextLabel?.text = "No Category"
        case 3:
            cell.textLabel?.text = "Start Date: "
        case 4:
            cell.textLabel?.text = "End Date: "
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    @IBAction func cancelAddProjectForm(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveProject(sender: UIBarButtonItem) {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row > 2{
            performSegueWithIdentifier(AppConstants.SegueIdentifier.DateTimePickerSegue, sender: nil)
        }
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
