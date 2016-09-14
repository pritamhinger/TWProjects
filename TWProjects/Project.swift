//
//  Project.swift
//  TWProjects
//
//  Created by Pritam Hinger on 14/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation
import CoreData


class Project: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init(projectDAO: ProjectDAO, insertIntoManagedObjectContext context: NSManagedObjectContext){
        if let entity = NSEntityDescription.entityForName(CoreDataStack.EntityName.Project, inManagedObjectContext: context){
            self.init(entity:entity, insertIntoManagedObjectContext: context)
            self.announcement = projectDAO.announcement
            self.announcementHTML =  projectDAO.announcementHTML
            self.company = nil
            self.created0n = projectDAO.createdOn
            self.defaultPrivacy = projectDAO.defaultPrivacy
            self.desc = projectDAO.desc
            self.endDate = projectDAO.endDate
            self.filesAutoNewVersion = projectDAO.filesAutoNewVersion
            self.harvestTimersEnabled = projectDAO.harvestTimersEnabled
            self.id = projectDAO.id
            self.isProjectAdmin = projectDAO.isProjectAdmin
            self.lastChangedOn = projectDAO.lastChangedOn
            self.logo = projectDAO.logo
            self.name = projectDAO.name
            self.notifyEveryone = projectDAO.notifyEveryone
            self.privacyEnabled = projectDAO.privacyEnabled
            self.replyByEmailEnabled = projectDAO.replyByEmailEnabled
            self.showAnnouncement = projectDAO.showAnnouncement
            self.status = projectDAO.status
            self.starred = projectDAO.starred
            self.startDate = projectDAO.startDate
            self.startPage = projectDAO.startPage
            self.subStatus = projectDAO.subStatus
            self.tags = projectDAO.tags
        }
        else{
            fatalError("Unable to find '\(CoreDataStack.EntityName.Project)' entity.")
        }
    }

}
