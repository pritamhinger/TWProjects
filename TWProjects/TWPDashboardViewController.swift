//
//  TWPDashboardViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit
import CoreData

class TWPDashboardViewController: UIViewController {

    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var fetchResultsController: NSFetchedResultsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
        let fetchRequest = NSFetchRequest(entityName: CoreDataStack.EntityName.Company)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"id", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        readCompaniesFromPersistentStore()
        
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            let methodName = TWProjectsClient.getMethodName(TWProjectsClient.APIMethod.Companies, methodFormat: TWProjectsClient.APIFormat.JSON)
            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authorizationCookie){ (results, error) in
                
                if error == nil{
                    print(results!)
                    if let status = results![TWProjectsClient.CompanyResponseKeys.Status] as? String{
                        if status == "OK"{
                            if let companiesJSON = results![TWProjectsClient.CompanyResponseKeys.Companies] as? [[String:AnyObject]]{
                                var companiesDAO = [CompanyDAO]()
                                var companyDAO:CompanyDAO?
                                for companyJSON in companiesJSON{
                                    companyDAO = CompanyDAO(userDictionary: companyJSON)
                                    if companyDAO != nil{
                                        companiesDAO.append(companyDAO!)
                                    }
                                }
                                
                                print(companiesDAO)
                                
                                for comp in companiesDAO{
                                    let company = Company(companyDAO: comp, insertIntoManagedObjectContext: self.fetchResultsController!.managedObjectContext)
                                    print(company)
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
