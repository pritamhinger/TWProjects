//
//  User.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

struct User {
    
    let userId:String?
    let planId:String?
    let lastName:String?
    let lang:String?
    let companyId:String?
    let likedEnabled:Bool?
    let deskEnabled:Bool?
    let avatarURL:String?
    let timeFormat:String?
    let projectsEnabled:Bool?
    let documentEditorEnabled:Bool?
    let sslEnabled:Bool?
    let canManagePeople:Bool?
    let companyName:String?
    let userIsAdmin:Bool?
    let name:String?
    let canAddProjects:Bool?
    let requireHTTPs:Bool?
    let code:String?
    let dateFormat:String?
    let url:String?
    let tagsEnabled:Bool?
    let tkoEnaled:Bool?
    let startOnSundays:Bool?
    let id:String?
    let chatEnabled:Bool?
    let logo:String?
    let dateSeparator:String?
    let firstName:String?
    let tagsLockedToAdmins:Bool?
    let userIsMemberOfOwnerCompany:Bool?
    
    init(userDictionary:[String:AnyObject]){
        userId = userDictionary[TWProjectsClient.AuthenticateResponseKeys.UserId] as? String
        planId = userDictionary[TWProjectsClient.AuthenticateResponseKeys.PlanId] as? String
        lastName = userDictionary[TWProjectsClient.AuthenticateResponseKeys.LastName] as? String
        lang = userDictionary[TWProjectsClient.AuthenticateResponseKeys.Lang] as? String
        companyId = userDictionary[TWProjectsClient.AuthenticateResponseKeys.CompanyId] as? String
        likedEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.LikesEnabled] as? Bool
        deskEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.DeskEnabled] as? Bool
        avatarURL = userDictionary[TWProjectsClient.AuthenticateResponseKeys.AvatarURL] as? String
        timeFormat = userDictionary[TWProjectsClient.AuthenticateResponseKeys.TimeFormat] as? String
        projectsEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.ProjectsEnabled] as? Bool
        documentEditorEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.DocumentEditorEnabled] as? Bool
        sslEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.SSLEnabled] as? Bool
        canManagePeople = userDictionary[TWProjectsClient.AuthenticateResponseKeys.CanManagePeople] as? Bool
        companyName = userDictionary[TWProjectsClient.AuthenticateResponseKeys.CompanyName] as? String
        userIsAdmin = userDictionary[TWProjectsClient.AuthenticateResponseKeys.UserIsAdmin] as? Bool
        name = userDictionary[TWProjectsClient.AuthenticateResponseKeys.Name] as? String
        canAddProjects = userDictionary[TWProjectsClient.AuthenticateResponseKeys.CanAddProjects] as? Bool
        requireHTTPs = userDictionary[TWProjectsClient.AuthenticateResponseKeys.RequireHTTPS] as? Bool
        code = userDictionary[TWProjectsClient.AuthenticateResponseKeys.Code] as? String
        dateFormat = userDictionary[TWProjectsClient.AuthenticateResponseKeys.DateFormat] as? String
        url = userDictionary[TWProjectsClient.AuthenticateResponseKeys.URL] as? String
        tagsEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.TagsEnabled] as? Bool
        tkoEnaled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.TKOEnabled] as? Bool
        startOnSundays = userDictionary[TWProjectsClient.AuthenticateResponseKeys.StartOnSundays] as? Bool
        id = userDictionary[TWProjectsClient.AuthenticateResponseKeys.Id] as? String
        chatEnabled = userDictionary[TWProjectsClient.AuthenticateResponseKeys.ChatEnabled] as? Bool
        logo = userDictionary[TWProjectsClient.AuthenticateResponseKeys.Logo] as? String
        dateSeparator = userDictionary[TWProjectsClient.AuthenticateResponseKeys.DateSeperator] as? String
        firstName = userDictionary[TWProjectsClient.AuthenticateResponseKeys.FirstName] as? String
        tagsLockedToAdmins = userDictionary[TWProjectsClient.AuthenticateResponseKeys.TagsLockedToAdmins] as? Bool
        userIsMemberOfOwnerCompany = userDictionary[TWProjectsClient.AuthenticateResponseKeys.UserIsMemberOfOwnerCompany] as? Bool
    }
}