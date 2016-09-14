//
//  Company+CoreDataProperties.swift
//  TWProjects
//
//  Created by Pritam Hinger on 14/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Company {

    @NSManaged var id: String?
    @NSManaged var can_see_private: NSNumber?
    @NSManaged var company_name_url: String?
    @NSManaged var name: String?
    @NSManaged var address_one: String?
    @NSManaged var address_two: String?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var zip: String?
    @NSManaged var country: String?
    @NSManaged var website: String?
    @NSManaged var phone: String?
    @NSManaged var fax: String?
    @NSManaged var projects: NSSet?

}
