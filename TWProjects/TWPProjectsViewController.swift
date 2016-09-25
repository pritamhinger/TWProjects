//
//  TWPProjectsViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit
import CoreData

class TWPProjectsViewController: TWPCoreDataHelperViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    // MARK: - Properties
    var projects = [Project]()
    var projectIds = [String]()
    var sectionTitles = [String]()
    var starredProjects = [Project]()
    var filteredArray = [Project]()
    var shouldShowSearchResults = false
    
    var starredProjectShown:Bool{
        get{
            return projectTypeSegmentControl.selectedSegmentIndex == 1
        }
    }
    
    var searchController: UISearchController!
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var projectTypeSegmentControl: UISegmentedControl!
    
    // MARK: - Controller Life Cycle Events
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            // Setting Target and Action on Menu Bar Button to add Slide In capabilities to VC
            // Also adding Pan Gesture Recognizer to View
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        configureSearchController()
        
        // Self Sizing Table View Cell.
        // Setting table view properties to enable self sizing of table view cell when a long text string
        // is to be shown
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Setting title of VC
        self.navigationItem.title = "All Projects"
        
        // Setting Up Persistent Store to Query Project Entity
        entityName = CoreDataStack.EntityName.Project
        let coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"lastChangedOn", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Loading Data from Persistent Store first so that Table View is ready to present data 
        // as soon as VC is visible. Also, in case of no internet connection, User would still be 
        // looking at data from Persistent store
        loadProjectsFromStore()
        
        // Calling Teamwork Servers to get latest information about projects.
        // We would be updating Project Entity instance if there is any change in value of any property.
        // At the end we would be saving/updating Persistent Store as well as we would be updating UI
        syncProjectsFromTWServer()
        
        // Subscribing to Notification broadcasted where a new project is created or an existing project is changed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TWPProjectsViewController.updateUI(_:)), name: AppConstants.NotificationName.DataSaveSuccessNotification, object: nil)
    }
    
    @IBAction func projectTypeChanged(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Checking for Segue Identifier.
        // If segue is called for Editing a Project then we would be setting Project Instance
        // binded to TableView Cell being tapped. 
        // Setting Project instance is required as we are using same VC for Creation as well as 
        // Updation of Project. In case of New Project Creation this project instance is not passed and
        // the Project Instance on Destination VC is nil and thereby we won't be pre populating controls with data
        // from Project Instance. In case of Editing of Existing Project, since we are passing Project Instance,
        // thus we would be pre populating UI Controls with data from Project Instance
        if segue.identifier == AppConstants.SegueIdentifier.EditProjectSegue{
            if let cell = sender as? TWPProjectsTableViewCell{
                let projectDetailViewController = segue.destinationViewController as! TWPAddProjectViewController
                // We have set projectId as Tag to UIImageView control.
                let projectId = cell.projectStarredImageView.tag
                
                // Based on ProjectId retrieved from Cell, we would be filtering our datasource 
                // object, projects collection, and getting appropriate Project Reference
                let project = self.projects.filter{ $0.id! == "\(projectId)" }.first
                print(project)
                projectDetailViewController.project = project
            }
            
        }
    }
    
    // MARK: - Image Tap Gesture Handler
    // This procedure would toggle the state of Project.
    // States are: Starred Projects and Unstarred Projects
    func projectStarredImageTapped(sender:AnyObject) {
        let gesture = sender as! UITapGestureRecognizer
        
        // Retrieving ProjectId which was set as Tag to UIImageView when table view was being populated
        let projectId = (gesture.view?.tag)!
        
        // Filtering Projects Collection to find Project Instance whose state needs to be toggled
        let project = self.projects.filter{ $0.id! == "\(projectId)" }.first
        var resourcePath = ""
        if project!.starred! == 1 {
            // Unstarring Project
            project!.starred = NSNumber(int: 0);
            // Removing project from StarredProjects Collection
            starredProjects.removeAtIndex(starredProjects.indexOf(project!)!)
            // Setting Resourse Path to Unstar Project.
            // We would be using this Resource Path to make call to Teamwork Servers to update Project
            resourcePath = TWProjectsClient.APIMethod.UnstarProject
        }
        else{
            // Starring Project
            project!.starred = NSNumber(int: 1);
            // Adding project to Collection of Starred Projects
            starredProjects.append(project!)
            // Setting Resource Path to Star Project
            resourcePath = TWProjectsClient.APIMethod.StarProject
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        // Making PUT call to resource path as set above
        TWProjectsClient.sharedInstance().updateResourceForMethod(resourcePath, urlKey: TWProjectsClient.URLKeys.ProjectId, id: "\(projectId)", authorizationCookie: ""){ (results, error) in
            if error == nil{
                print("Resource Updated")
                performUIUpdatesOnMainQueue{
                    (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack.save()
                    self.tableView.reloadData()
                }
            }
            else{
                print(error)
                performUIUpdatesOnMainQueue{
                    CommonFunctions.showError(self, error: error, userInfoKey: AppConstants.ErrorKeys.ErrorDescription, title: AppConstants.AlertViewTitle.Error, style: .Alert)
                }
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
