//
//  ProjectsExtension.swift
//  TWProjects
//
//  Created by Pritam Hinger on 15/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

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
                    
                    
                    print("Totol Projects :\(totalProjects)")
                    print("Totol Sections :\(totalSections)")
                    var sectionIndex = 0
                    
                    for sec in fc.sections! {
                        var index = 0
                        while( index < sec.numberOfObjects){
                            
                            let indexPath = NSIndexPath(forItem: index, inSection: sectionIndex)
                            
                            let obj = fc.objectAtIndexPath(indexPath)
                            let project = (obj as! Project)
                            
                            projectIds.append(project.id!)
                            projects.append(project)
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