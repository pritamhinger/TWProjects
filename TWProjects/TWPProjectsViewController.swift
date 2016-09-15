//
//  TWPProjectsViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit
import CoreData

class TWPProjectsViewController: TWPCoreDataHelperViewController {

    var projects = [Project]()
    var projectIds = [String]()
    
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
        
        if projects.count == 0{
            getProjectsFromTWServer()
        }
    }
    
    func getProjectsFromTWServer(){
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            
            let methodName = TWProjectsClient.getMethodName(TWProjectsClient.APIMethod.Projects, methodFormat: TWProjectsClient.APIFormat.JSON)
            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authorizationCookie){ (results, error) in
                
                if error == nil{
                    if let status = results![TWProjectsClient.CompanyResponseKeys.Status] as? String{
                        if status == "OK"{
                            if let projectsJSON = results![TWProjectsClient.ProjectResponseKeys.ResponseStatus] as? [[String:AnyObject]]{
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
                                        print("Saving Project \n \(project) ")
                                    }
                                    else{
                                        // TODO: Sync Company Data as passed from Server with the Company data stored in Persistent Store
                                        print("Skipping Save. Will update project data in future releases")
                                    }
                                }
                                
                                (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack.save()
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
