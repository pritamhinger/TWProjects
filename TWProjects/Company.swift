//
//  Company.swift
//  TWProjects
//
//  Created by Pritam Hinger on 14/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation
import CoreData


class Company: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init(companyDAO:CompanyDAO, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        if let entity = NSEntityDescription.entityForName(CoreDataStack.EntityName.Company, inManagedObjectContext: context) {
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            self.address_one = companyDAO.address_one
            self.address_two = companyDAO.address_one
            self.can_see_private = companyDAO.can_see_private
            self.city = companyDAO.city
            self.company_name_url = companyDAO.company_name_url
            self.country = companyDAO.country
            self.fax = companyDAO.fax
            self.id = companyDAO.id
            self.name = companyDAO.name
            self.phone = companyDAO.phone
            self.projects = companyDAO.projects
            self.state = companyDAO.state
            self.website = companyDAO.website
            self.zip = companyDAO.zip
        }
        else{
            fatalError("Unable to find '\(CoreDataStack.EntityName.Company)' entity.")
        }
        
    }
}
