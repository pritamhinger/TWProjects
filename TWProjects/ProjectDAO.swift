//
//  ProjectDAO.swift
//  TWProjects
//
//  Created by Pritam Hinger on 15/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

struct ProjectDAO {
    let replyByEmailEnabled: NSNumber?
    let starred: NSNumber?
    let showAnnouncement: NSNumber?
    let harvestTimersEnabled: NSNumber?
    let status: String?
    let subStatus: String?
    let defaultPrivacy: String?
    let createdOn: NSDate?
    let filesAutoNewVersion: NSNumber?
    let tags: String?
    let logo: String?
    let startDate: NSDate?
    let id: String?
    let lastChangedOn: NSDate?
    let endDate: NSDate?
    let name: String?
    let privacyEnabled: NSNumber?
    let desc: String?
    let announcement: String?
    let isProjectAdmin: NSNumber?
    let startPage: String?
    let notifyEveryone: NSNumber?
    let announcementHTML: String?
    let company: CompanyDAO?
    
    init(userDictionary:[String:AnyObject], companyDAO:CompanyDAO?){
        self.replyByEmailEnabled = userDictionary[TWProjectsClient.ProjectResponseKeys.ReplyByEmailEnabled] as? Bool
        self.starred = userDictionary[TWProjectsClient.ProjectResponseKeys.Starred] as? Bool
        self.showAnnouncement = userDictionary[TWProjectsClient.ProjectResponseKeys.ShowAnnouncement] as? Bool
        self.harvestTimersEnabled = userDictionary[TWProjectsClient.ProjectResponseKeys.HarvestTimersEnabled] as? Bool
        self.status = userDictionary[TWProjectsClient.ProjectResponseKeys.Status] as? String
        self.subStatus = userDictionary[TWProjectsClient.ProjectResponseKeys.SubStatus] as? String
        self.defaultPrivacy = userDictionary[TWProjectsClient.ProjectResponseKeys.DefaultPrivacy] as? String
        self.createdOn = userDictionary[TWProjectsClient.ProjectResponseKeys.CreatedOn] as? NSDate
        self.filesAutoNewVersion = userDictionary[TWProjectsClient.ProjectResponseKeys.FilesAutoNewVersion] as? Bool
        self.tags = userDictionary[TWProjectsClient.ProjectResponseKeys.Tags] as? String
        self.logo = userDictionary[TWProjectsClient.ProjectResponseKeys.Logo] as? String
        self.startDate = CommonFunctions.getDateFromString(userDictionary[TWProjectsClient.ProjectResponseKeys.StartDate] as! String)
        self.id = userDictionary[TWProjectsClient.ProjectResponseKeys.Id] as? String
        self.lastChangedOn = userDictionary[TWProjectsClient.ProjectResponseKeys.LastChangedOn] as? NSDate
        self.name = userDictionary[TWProjectsClient.ProjectResponseKeys.Name] as? String
        self.endDate = CommonFunctions.getDateFromString(userDictionary[TWProjectsClient.ProjectResponseKeys.EndDate] as! String)
        self.privacyEnabled = userDictionary[TWProjectsClient.ProjectResponseKeys.PrivacyEnabled] as? Bool
        self.desc = userDictionary[TWProjectsClient.ProjectResponseKeys.Description] as? String
        self.announcement = userDictionary[TWProjectsClient.ProjectResponseKeys.Announcement] as? String
        self.isProjectAdmin = userDictionary[TWProjectsClient.ProjectResponseKeys.IsProjectAdmin] as? Bool
        self.startPage = userDictionary[TWProjectsClient.ProjectResponseKeys.StartPage] as? String
        self.notifyEveryone = userDictionary[TWProjectsClient.ProjectResponseKeys.NotifyEveryone] as? Bool
        self.announcementHTML = userDictionary[TWProjectsClient.ProjectResponseKeys.AnnouncementHTML] as? String
        self.company =  companyDAO
    }
    
    
    
    
    
    
}