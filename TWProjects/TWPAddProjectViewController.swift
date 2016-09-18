//
//  TWPAddProjectViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPAddProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    var customModalTransitioningDelegate: TWPCustomModalTransitioningDelegate?
    var chosenIndexPath:NSIndexPath?
    var startDate:String?
    var endDate:String?
    var companyId:String?
    var tags:String?
    
    var project:Project?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var projectTitle: UITextField!
    @IBOutlet weak var projectDescTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTitle.delegate = self
        projectDescTextView.delegate = self
        
        if project != nil{
            projectTitle.text = project?.name
            projectDescTextView.text = project?.desc
            if let stDate = project?.startDate{
                startDate = CommonFunctions.getFormattedDateForUI(stDate)
                print("Start Date \(startDate!)")
            }
            
            if let edDate = project?.endDate{
                endDate = CommonFunctions.getFormattedDateForUI(edDate)
                print("End Date \(endDate!)")
            }
        }
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
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveProject(sender: UIBarButtonItem) {
        if projectTitle.text?.characters.count == 0{
            CommonFunctions.showError(self, message: "Project should have a title", title: AppConstants.AlertViewTitle.MoreInformationNeeded, style: .Alert)
            return;
        }
        
        if projectDescTextView.text.characters.count == 0{
            CommonFunctions.showError(self, message: "Project description is required", title: AppConstants.AlertViewTitle.MoreInformationNeeded, style: .Alert)
            return;
        }
        
        var row = 0
        var postRequestData = [String:AnyObject]()
        
        postRequestData[TWProjectsClient.ProjectResponseKeys.Name] = projectTitle.text!
        postRequestData[TWProjectsClient.ProjectResponseKeys.Description] = projectDescTextView.text
        while row < 5 {
            let indexPath = NSIndexPath(forRow: row, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            switch row {
            case 0:
                postRequestData[TWProjectsClient.ProjectResponseKeys.CompanyId] = companyId!
                break
            case 1:
                postRequestData[TWProjectsClient.ProjectResponseKeys.CategoryId] = "0"
                break
            case 2:
                postRequestData[TWProjectsClient.ProjectResponseKeys.Tags] = ""
                break
            case 3:
                let stDt = CommonFunctions.getFormattedDateForAPI((cell?.detailTextLabel?.text!)!)
                print(stDt)
                postRequestData[TWProjectsClient.ProjectResponseKeys.StartDate] = stDt
                break
            case 4:
                let endDt = CommonFunctions.getFormattedDateForAPI((cell?.detailTextLabel?.text!)!)
                print(endDt)
                postRequestData[TWProjectsClient.ProjectResponseKeys.EndDate] = endDt
                break
            default:
                break
                
            }
            row = row + 1
        }
        
        var json = CommonFunctions.convertDictionaryToString(postRequestData)
        json = "{\"\(TWProjectsClient.ProjectResponseKeys.Project)\":{\(json)}}"
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.label.text = "Adding Project"
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            if project != nil{
                TWProjectsClient.sharedInstance().updateResourceForMethod(TWProjectsClient.APIMethod.UpdateProject, urlKey: TWProjectsClient.URLKeys.ProjectId, id: (project?.id!)!, jsonBody: json,  authorizationCookie: authorizationCookie){ (results, error) in
                    if error == nil{
                        print(results)
                        NSNotificationCenter.defaultCenter().postNotificationName(AppConstants.NotificationName.DataSaveSuccessNotification, object: nil)
                    }
                    else{
                        print(error)
                    }
                    
                    performUIUpdatesOnMainQueue{
                        hud.hideAnimated(true)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
            else{
                let methodName = TWProjectsClient.getMethodName(TWProjectsClient.APIMethod.Projects, methodFormat: TWProjectsClient.APIFormat.JSON)
                TWProjectsClient.sharedInstance().insertResourceForMethod(methodName, jsonBody: json, authorizationCookie: authorizationCookie){ (results, error) in
                    if error == nil{
                        print(results)
                        NSNotificationCenter.defaultCenter().postNotificationName(AppConstants.NotificationName.DataSaveSuccessNotification, object: nil)
                    }
                    else{
                        print(error)
                    }
                    
                    performUIUpdatesOnMainQueue{
                        hud.hideAnimated(true)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
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
    
    // MARK: - UITextField Delegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UITextView Delegate Methods
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}
