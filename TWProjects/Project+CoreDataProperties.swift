//
//  Project+CoreDataProperties.swift
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

extension Project {

    @NSManaged var replyByEmailEnabled: NSNumber?
    @NSManaged var starred: NSNumber?
    @NSManaged var showAnnouncement: NSNumber?
    @NSManaged var harvestTimersEnabled: NSNumber?
    @NSManaged var status: String?
    @NSManaged var subStatus: String?
    @NSManaged var defaultPrivacy: String?
    @NSManaged var created0n: NSDate?
    @NSManaged var filesAutoNewVersion: NSNumber?
    @NSManaged var tags: String?
    @NSManaged var logo: String?
    @NSManaged var startDate: NSDate?
    @NSManaged var id: String?
    @NSManaged var lastChangedOn: NSDate?
    @NSManaged var endDate: NSDate?
    @NSManaged var name: String?
    @NSManaged var privacyEnabled: NSNumber?
    @NSManaged var desc: String?
    @NSManaged var announcement: String?
    @NSManaged var isProjectAdmin: NSNumber?
    @NSManaged var startPage: String?
    @NSManaged var notifyEveryone: NSNumber?
    @NSManaged var announcementHTML: String?
    @NSManaged var company: Company?

}
