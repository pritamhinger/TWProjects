//
//  CompanyDAO.swift
//  TWProjects
//
//  Created by Pritam Hinger on 14/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

struct CompanyDAO {
    let id: String?
    let can_see_private: NSNumber?
    let company_name_url: String?
    let name: String?
    let address_one: String?
    let address_two: String?
    let city: String?
    let state: String?
    let zip: String?
    let country: String?
    let website: String?
    let phone: String?
    let fax: String?
    let projects: NSSet?
    
    init(userDictionary:[String:AnyObject]){
            self.id = userDictionary[TWProjectsClient.CompanyResponseKeys.Id] as? String
        self.can_see_private = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? Bool
        self.company_name_url = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.name = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.address_one = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.address_two = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.city = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.state = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.zip = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.country = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.website = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.phone = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.fax = userDictionary[TWProjectsClient.CompanyResponseKeys.CanSeePrivate] as? String
        self.projects = NSSet()
    }
}