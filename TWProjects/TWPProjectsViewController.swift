//
//  TWPProjectsViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit
import CoreData

class TWPProjectsViewController: TWPCoreDataHelperViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    var projects = [Project]()
    var projectIds = [String]()
    var sectionTitles = [String]()
    var starredProjects = [Project]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    // MARK: - Controller Life Cycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.title = "All Projects"
        
        entityName = CoreDataStack.EntityName.Project
        let coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"lastChangedOn", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        loadProjectsFromStore()
        syncProjectsFromTWServer()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TWPProjectsViewController.updateUI(_:)), name: AppConstants.NotificationName.DataSaveSuccessNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == AppConstants.SegueIdentifier.EditProjectSegue{
            
            if let cell = sender as? TWPProjectsTableViewCell{
                let projectDetailViewController = segue.destinationViewController as! TWPAddProjectViewController
                let projectId = cell.projectStarredImageView.tag
                print(projectId)
                let project = self.projects.filter{ $0.id! == "\(projectId)" }.first
                projectDetailViewController.project = project
            }
            
        }
    }
    
    // MARK: - Image Tap Gesture Handler
    func projectStarredImageTapped(sender:AnyObject) {
        let gesture = sender as! UITapGestureRecognizer
        let projectId = (gesture.view?.tag)!
        let project = self.projects.filter{ $0.id! == "\(projectId)" }.first
        var resourcePath = ""
        if project!.starred! == 1 {
            project!.starred = NSNumber(int: 0);
            starredProjects.removeAtIndex(starredProjects.indexOf(project!)!)
            resourcePath = TWProjectsClient.APIMethod.UnstarProject
        }
        else{
            project!.starred = NSNumber(int: 1);
            starredProjects.append(project!)
            resourcePath = TWProjectsClient.APIMethod.StarProject
        }
        
        TWProjectsClient.sharedInstance().updateResourceForMethod(resourcePath, urlKey: TWProjectsClient.URLKeys.ProjectId, id: "\(projectId)", authorizationCookie: ""){ (results, error) in
            if error == nil{
                print("Resource Updated")
                performUIUpdatesOnMainQueue{
                    (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack.save()
                    self.tableView.reloadData()
                }
            }
            else{
                print("Resource Update failed")
            }
        }
    }
}
