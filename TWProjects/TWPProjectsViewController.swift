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

    var projects = [Project]()
    var projectIds = [String]()
    var sectionTitles = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        entityName = CoreDataStack.EntityName.Project
        let coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"lastChangedOn", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        loadProjectsFromStore()
        syncProjectsFromTWServer()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath)
        let project = projects[indexPath.row]
        cell.textLabel?.text = project.name
        cell.detailTextLabel?.text = project.desc
        return cell
    }
    
    func syncProjectsFromTWServer(){
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            
            let methodName = TWProjectsClient.getMethodName(TWProjectsClient.APIMethod.Projects, methodFormat: TWProjectsClient.APIFormat.JSON)
            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authorizationCookie){ (results, error) in
                
                if error == nil{
                    if let status = results![TWProjectsClient.ProjectResponseKeys.ResponseStatus] as? String{
                        if status == "OK"{
                            print(results!)
                            if let projectsJSON = results![TWProjectsClient.ProjectResponseKeys.Projects] as? [[String:AnyObject]]{
                                var projectsDAO = [ProjectDAO]()
                                var projectDAO:ProjectDAO?
                                for projectJSON in projectsJSON{
                                    projectDAO = ProjectDAO(userDictionary: projectJSON, companyDAO: nil)
                                    if projectDAO != nil{
                                        projectsDAO.append(projectDAO!)
                                    }
                                }
                                
                                for proj in projectsDAO{
                                    if !self.projectIds.contains(proj.id!){
                                        let project = Project(projectDAO: proj, insertIntoManagedObjectContext: self.fetchResultsController!.managedObjectContext)
                                        self.projects.append(project)
                                    }
                                    else{
                                        let storedProject = self.projects.filter{ $0.id! == proj.id! }.first
                                        storedProject?.starred = proj.starred
                                        storedProject?.desc = proj.desc
                                        storedProject?.tags = proj.tags
                                        storedProject?.startDate = proj.startDate
                                        storedProject?.endDate = proj.endDate
                                        storedProject?.name = proj.name
                                    }
                                }
                                
                                (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack.save()
                                
                                performUIUpdatesOnMainQueue{
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
                else{
                    print(error)
                }
                
            }
        }
    }
}
