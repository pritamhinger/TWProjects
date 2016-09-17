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
        
        entityName = CoreDataStack.EntityName.Project
        let coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"lastChangedOn", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        loadProjectsFromStore()
        syncProjectsFromTWServer()
    }
    
    // MARK: - Image Tap Gesture Handler
    func projectStarredImageTapped(sender:AnyObject) {
        let gesture = sender as! UITapGestureRecognizer
        let project = projects[(gesture.view?.tag)!]
        if project.starred! == 1 {
            project.starred = NSNumber(int: 0);
            starredProjects.removeAtIndex((gesture.view?.tag)!)
        }
        else{
            project.starred = NSNumber(int: 1);
            starredProjects.append(project)
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack.save()
        tableView.reloadData()
    }
}
