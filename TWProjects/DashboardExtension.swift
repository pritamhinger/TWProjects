//
//  DashboardExtension.swift
//  TWProjects
//
//  Created by Pritam Hinger on 15/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

extension TWPDashboardViewController{
    func readCompaniesFromPersistentStore() {
        if let fc = fetchResultsController{
            do{
                try fc.performFetch()
               
                if let fc = fetchResultsController{
                    var totalLocations = 0;
                    var totalSections = 0;
                    
                    for sec in fc.sections! {
                        totalLocations =  totalLocations + sec.numberOfObjects
                        totalSections = totalSections + 1
                    }
                    
                    
                    print("Totol Locations :\(totalLocations)")
                    print("Totol Sections :\(totalSections)")
                    var sectionIndex = 0
                    var companies = [Company]();
                    
                    for sec in fc.sections! {
                        var index = 0
                        while( index < sec.numberOfObjects){
                            
                            let indexPath = NSIndexPath(forItem: index, inSection: sectionIndex)
                            
                            let obj = fc.objectAtIndexPath(indexPath)
                            let company = (obj as! Company)
                            
                            companies.append(company)
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