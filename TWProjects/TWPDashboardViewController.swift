//
//  TWPDashboardViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit
import CoreData

class TWPDashboardViewController: TWPCoreDataHelperViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    var companies = [Company]();
    var companyIDsStoredInDB = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationItem.title = "Dashboard"
        
        entityName = CoreDataStack.EntityName.Company
        let coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"id", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        readCompaniesFromPersistentStore()
        
        getCompaniesFromTWServers()
    }
    
    func getCompaniesFromTWServers() {
        if let authorizationCookie = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.AuthorizationCookie) as? String{
            let methodName = TWProjectsClient.APIMethod.Companies
            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authorizationCookie){ (results, error) in
                
                if error == nil{
                    if let status = results![TWProjectsClient.CompanyResponseKeys.Status] as? String{
                        if status == "OK"{
                            if let companiesJSON = results![TWProjectsClient.CompanyResponseKeys.Companies] as? [[String:AnyObject]]{
                                var companiesDAO = [CompanyDAO]()
                                var companyDAO:CompanyDAO?
                                for companyJSON in companiesJSON{
                                    companyDAO = CompanyDAO(userDictionary: companyJSON)
                                    if companyDAO != nil{
                                        companiesDAO.append(companyDAO!)
                                        if (UIApplication.sharedApplication().delegate as! AppDelegate).currentCompanyDAO == nil{
                                           (UIApplication.sharedApplication().delegate as! AppDelegate).currentCompanyDAO = companyDAO
                                        }
                                    }
                                }
                                
                                print(companiesDAO)
                                var companyNames = [String]()
                                
                                for comp in companiesDAO{
                                    companyNames.append(comp.name!)
                                    if !self.companyIDsStoredInDB.contains(comp.id!){
                                        let company = Company(companyDAO: comp, insertIntoManagedObjectContext: self.fetchResultsController!.managedObjectContext)
                                        print("Saving Company \n \(company) ")
                                        self.companyIDsStoredInDB.append(comp.id!)
                                        (UIApplication.sharedApplication().delegate as! AppDelegate).currentCompany = company
                                    }
                                    else{
                                        // TODO: Sync Company Data as passed from Server with the Company data stored in Persistent Store
                                        print("Skipping Save. Will update company data in future releases")
                                        
                                        let storedCompany = self.companies.filter{ $0.id! == comp.id! }.first
                                        
                                        //Updating old properties values with new properties values
                                        storedCompany?.address_one = comp.address_one
                                        storedCompany?.address_two = comp.address_two
                                        storedCompany?.can_see_private = comp.can_see_private
                                        storedCompany?.id = comp.id
                                        storedCompany?.company_name_url = comp.company_name_url
                                        storedCompany?.name = comp.name
                                        (UIApplication.sharedApplication().delegate as! AppDelegate).currentCompany = storedCompany
                                    }
                                    
                                    
                                }
                                
                                CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.CompanyIds, value: self.companyIDsStoredInDB)
                                CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.CompanyNames, value: companyNames)
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
