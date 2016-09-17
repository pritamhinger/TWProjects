//
//  ProjectsExtension.swift
//  TWProjects
//
//  Created by Pritam Hinger on 15/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

// Extenstion Containing Coredata fetch and update methods
extension TWPProjectsViewController{
    func loadProjectsFromStore()  {
        if let fc = fetchResultsController{
            do{
                try fc.performFetch()
                
                if let fc = fetchResultsController{
                    var totalProjects = 0;
                    var totalSections = 0;
                    
                    for sec in fc.sections! {
                        totalProjects =  totalProjects + sec.numberOfObjects
                        totalSections = totalSections + 1
                    }
                    
                    var sectionIndex = 0
                    
                    for sec in fc.sections! {
                        var index = 0
                        while( index < sec.numberOfObjects){
                            
                            let indexPath = NSIndexPath(forItem: index, inSection: sectionIndex)
                            
                            let obj = fc.objectAtIndexPath(indexPath)
                            let project = (obj as! Project)
                            
                            projectIds.append(project.id!)
                            projects.append(project)
                            
                            if project.starred! == 1{
                                starredProjects.append(project)
                            }
                            
                            index = index + 1
                        }
                        
                        sectionIndex = sectionIndex + 1
                    }
                }
                
            }catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchResultsController)")
            }
        }
    }
}

// Extension Containing code for Network call for Projects
extension TWPProjectsViewController{
    func syncProjectsFromTWServer(){
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            
            let methodName = TWProjectsClient.getMethodName(TWProjectsClient.APIMethod.Projects, methodFormat: TWProjectsClient.APIFormat.JSON)
            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authorizationCookie){ (results, error) in
                
                if error == nil{
                    if let status = results![TWProjectsClient.ProjectResponseKeys.ResponseStatus] as? String{
                        if status == "OK"{
                            if let projectsJSON = results![TWProjectsClient.ProjectResponseKeys.Projects] as? [[String:AnyObject]]{
                                var projectsDAO = [ProjectDAO]()
                                var projectDAO:ProjectDAO?
                                for projectJSON in projectsJSON{
                                    projectDAO = ProjectDAO(userDictionary: projectJSON, companyDAO: nil)
                                    if projectDAO != nil{
                                        projectsDAO.append(projectDAO!)
                                    }
                                }
                                
                                self.starredProjects.removeAll()
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
                                        if storedProject?.starred! == 1{
                                            self.starredProjects.append(storedProject!)
                                        }
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

// Extension containing TableView Datasource and Delegate methods
extension TWPProjectsViewController{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if starredProjects.count > 0{
            return 2
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if starredProjects.count > 0 && section == 0{
            return "Starred Projects"
        }
        
        return "AppDevelapp"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if starredProjects.count > 0 && section == 0{
            return starredProjects.count
        }
        
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath) as! TWPProjectsTableViewCell
        
        let project: Project?
        if starredProjects.count > 0 && indexPath.section == 0{
            project = starredProjects[indexPath.row]
        }
        else{
            project = projects[indexPath.row]
        }
        
        
        if project!.starred! ==  1{
            cell.projectStarredImageView.image = UIImage(named: "Starred")
        }
        else{
            cell.projectStarredImageView.image = UIImage(named: "Unstarred")
        }
        
        cell.projectStarredImageView.userInteractionEnabled = true
        cell.projectStarredImageView.tag = indexPath.row
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(TWPProjectsViewController.projectStarredImageTapped(_:)))
        imageTapGesture.numberOfTapsRequired = 1
        cell.projectStarredImageView.addGestureRecognizer(imageTapGesture)
        
        cell.projectDesc.text = project!.desc!
        cell.projectName.text = project!.name!
        return cell
    }
}