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
    // Below procedure is used to populate collections to be used as data source for Table View.
    // It loads the collection with data from Persistent Store
    func loadProjectsFromStore()  {
        if let fc = fetchResultsController{
            do{
                // Trying to make a fetch request on Persistent Store
                try fc.performFetch()
                
                if let fc = fetchResultsController{
                    // Initializing count variables
                    var totalProjects = 0;
                    var totalSections = 0;
                    
                    // Figuring out total number of section and total number of objects across sections
                    // Note: Although, the number of section is always 1 but to make code generic, I have
                    // added a for loop here.
                    for sec in fc.sections! {
                        totalProjects =  totalProjects + sec.numberOfObjects
                        totalSections = totalSections + 1
                    }
                    
                    print("Total projects : \(totalProjects)")
                    
                    var sectionIndex = 0
                    
                    // Iterating over Sections to populate Collection to be used as TableView DataSource
                    for sec in fc.sections! {
                        var index = 0
                        while( index < sec.numberOfObjects){
                            
                            // Creating IndexPath
                            let indexPath = NSIndexPath(forItem: index, inSection: sectionIndex)
                            
                            // Getting object at indexpath
                            let obj = fc.objectAtIndexPath(indexPath)
                            // Casting Object
                            let project = (obj as! Project)
                            
                            // Adding project ids in separate Collection.
                            // We would be using this collection to check if we have a new project created by any other user or project
                            // created from WebSite. Basically, if in Get Call of Projects we have a ProjectId not contained in this
                            // collection, then we need to store that project in out persistent store as well
                            projectIds.append(project.id!)
                            
                            // Adding project instance to Projects Collections
                            projects.append(project)
                            
                            // Checking if project is already starred. If Yes, then adding the project to Starred Collection
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
    // The below procedure make network call to Teamwork servers and try to get Projects with their properties at this moment.
    // This procedure would also try to sync projects state as on Server and update local store with new values and then update UI with new values
    func syncProjectsFromTWServer(){
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            
            let methodName = TWProjectsClient.APIMethod.Projects
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authorizationCookie){ (results, error) in
                
                if error == nil{
                    print(results)
                    if let status = results![TWProjectsClient.ProjectResponseKeys.ResponseStatus] as? String{
                        if status == "OK"{
                            if let projectsJSON = results![TWProjectsClient.ProjectResponseKeys.Projects] as? [[String:AnyObject]]{
                                
                                var projectsDAO = [ProjectDAO]()
                                var projectDAO:ProjectDAO?
                                // Iterating over response JSON and creating ProjectDAO object which would then be mapped to Project Entity
                                // Instances to be stored in Persistent store
                                let companyDAO = (UIApplication.sharedApplication().delegate as! AppDelegate).currentCompanyDAO
                                for projectJSON in projectsJSON{
                                    projectDAO = ProjectDAO(userDictionary: projectJSON, companyDAO: companyDAO)
                                    if projectDAO != nil{
                                        projectsDAO.append(projectDAO!)
                                    }
                                }
                                
                                // Clearing all starred projects as we would be again iterating over projects list we got from Teamwork
                                // servers. And we have data in latest state.
                                self.starredProjects.removeAll()
                                let comp = (UIApplication.sharedApplication().delegate as! AppDelegate).currentCompany
                                for proj in projectsDAO{
                                    if !self.projectIds.contains(proj.id!){
                                        // If project id is not present in ProjectIds collection then this means this is a new project and we
                                        // need to store this project in out persistent store.
                                        let project = Project(projectDAO: proj, insertIntoManagedObjectContext: self.fetchResultsController!.managedObjectContext)
                                        project.company = comp
                                        // Checking if this new project is starred or not
                                        if project.starred == 1{
                                            self.starredProjects.append(project)
                                        }
                                        self.projects.append(project)
                                    }
                                    else{
                                        // If the project is already stored on persistent store then we would be just mapping
                                        // new value with old values.
                                        // Please note here that old and new values may be same as well.
                                        // Also i am not mapping all properties. Just mapping some important properties.
                                        
                                        // Findind Project instance in projects collection using project id
                                        let storedProject = self.projects.filter{ $0.id! == proj.id! }.first
                                        
                                        //Updating old properties values with new properties values
                                        storedProject?.starred = proj.starred
                                        storedProject?.desc = proj.desc
                                        storedProject?.tags = proj.tags
                                        storedProject?.startDate = proj.startDate
                                        storedProject?.endDate = proj.endDate
                                        storedProject?.lastChangedOn = proj.lastChangedOn
                                        storedProject?.name = proj.name
                                        
                                        // Only need to set company entity to project if the previously stored project doesn't have company entity set which would be rare.
                                        // Thus we don't want to change the company object of previous projects.
                                        if storedProject?.company == nil{
                                            storedProject?.company = comp
                                        }
                                        // Checking if project is starred or not
                                        if storedProject?.starred! == 1{
                                            self.starredProjects.append(storedProject!)
                                        }
                                    }
                                }
                                
                                // Saving state of objects in Persistent Store
                                (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack.save()
                                
                                // Updating TableView by Reloading it.
                                performUIUpdatesOnMainQueue{
                                    
                                    // Please note that i am reloading table view 2 time in below fashion as there is a bug in Apple API
                                    // in calculating Row Height Value.
                                    // Link I Referred is :
                                    // 1. http://useyourloaf.com/blog/self-sizing-table-view-cells/#comment-1783719287
                                    // 2. http://stackoverflow.com/questions/27787552/ios-8-auto-height-cell-not-correct-height-at-first-load
                                    self.tableView.reloadData()
                                    self.tableView.setNeedsLayout()
                                    self.tableView.layoutIfNeeded()
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
                else{
                    print(error)
                    performUIUpdatesOnMainQueue{
                        CommonFunctions.showError(self, error: error, userInfoKey: AppConstants.ErrorKeys.ErrorDescription, title: AppConstants.AlertViewTitle.Error, style: .Alert)
                        self.tableView.reloadData()
                    }
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            }
        }
    }
}

// Extension containing TableView Datasource and Delegate methods
extension TWPProjectsViewController{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselecting Cell after user tap on Table View Cell as we have to Navigate to Add Project VC and we don't
        // want to remember last selection
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? TWPProjectsTableViewCell
        cell?.selected = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowSearchResults{
            return filteredArray.count
        }
        
        if starredProjectShown{
            if starredProjects.count == 0{
                showLabelForNoRecords("No starred projects yet. Go to All Projects Segment and tap the star on the left side to star a project.")
            }
            else{
                self.tableView.backgroundView = nil
            }
            
            return starredProjects.count
        }
        else{
            if projects.count == 0{
                showLabelForNoRecords("No projects yet. Click '+' at the top right corner and get started.")
            }
            else{
                self.tableView.backgroundView = nil
            }
        }
        
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeuing cell from table view
        let cell = tableView.dequeueReusableCellWithIdentifier(AppConstants.CellIdentifier.ProjectCell, forIndexPath: indexPath) as! TWPProjectsTableViewCell
        
        let project: Project?
        
        // If we have starred project and current section is first then we need to get project object from Starred Projects Collection
        // Please note here that if we gave starred projects then that would be our first section always.
        // Is there is not starred projects then first section would be off all projects
        if shouldShowSearchResults{
            project = filteredArray[indexPath.row]
        }
        else{
            if starredProjectShown{
                project = starredProjects[indexPath.row]
            }
            else{
                project = projects[indexPath.row]
            }
        }
        
        // Setting Image based on the Project's Starred State
        if project!.starred! ==  1{
            cell.projectStarredImageView.image = UIImage(named: "Starred")
        }
        else{
            cell.projectStarredImageView.image = UIImage(named: "Unstarred")
        }
        
        // Enabling User Interaction on UIImageView.
        // So that user can tap on UIImage View
        cell.projectStarredImageView.userInteractionEnabled = true
        //Setting ProjectId as Tag to UIImageView.
        // We would be using this tag value to get the project assiciated with Table View Cell, when
        // we would be starring or unstarring projects. Also we would use this tag when we would be
        // editing a project
        cell.projectStarredImageView.tag = Int((project?.id!)!)!
        
        // Adding Tap Gesture Recognizer on UIImageView
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(TWPProjectsViewController.projectStarredImageTapped(_:)))
        imageTapGesture.numberOfTapsRequired = 1
        cell.projectStarredImageView.addGestureRecognizer(imageTapGesture)
        
        // Setting Project Name and desc on TableViewCell
        cell.projectDesc.text = project!.desc!
        cell.projectName.text = project!.name!
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if shouldShowSearchResults{
            return 44
        }
        else{
            return 0
        }
    }
}

extension TWPProjectsViewController{
    // Below is the Notification Reciever when a new project is added or an existing project is successfully edited
    func updateUI(notification: NSNotification){
        
        // Clearing DataSource as we would be reloading projects again from persistent store
        self.projects.removeAll()
        self.starredProjects.removeAll()
        loadProjectsFromStore()
        // Calling procedure to sync data from Teamwork servers
        syncProjectsFromTWServer()
    }
}

extension TWPProjectsViewController{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        if starredProjectShown{
            
            if searchString == ""{
                filteredArray = starredProjects
            }
            else{
                filteredArray = starredProjects.filter({ (project) in
                    let currentProjectName = NSString(string: project.name!)
                    print(currentProjectName)
                    return (currentProjectName.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
                    
                })
            }
        }
        else{
            if searchString == ""{
                filteredArray = projects
            }
            else{
                filteredArray = projects.filter({ (project) in
                    let currentProjectName = NSString(string: project.name!)
                    return (currentProjectName.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
                    
                })
            }
        }
        
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
}

extension TWPProjectsViewController{
    func showLabelForNoRecords(message:String){
        let frame:CGRect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        let emptyLabel:UILabel = UILabel(frame: frame);
        emptyLabel.text = message
        emptyLabel.textColor = UIColor.blackColor();
        emptyLabel.numberOfLines = 0;
        emptyLabel.textAlignment = NSTextAlignment.Center;
        let font:UIFont = UIFont(name: "AvenirNext-MediumItalic", size: 20)!
        emptyLabel.font = font;
        emptyLabel.sizeToFit();
        self.tableView.backgroundView = emptyLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
    }
    
    func configureSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type in here to search a project..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
}