//
//  APIConstants.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

extension TWProjectsClient{
    struct APIResource {
        static let Scheme = "http"
        static let AuthenticationURL = "authenticate.teamworkpm.net"
        //static let Path = ""
        static let Method = "/authenticate.json"
    }
    
    struct APIMethods {
        static let Accounts = "account"
    }
    
    struct APIFormat {
        static let JSON = "json"
        static let XML = "xml"
    }
    
    struct  AuthenticateResponseKeys {
        static let UserIsMemberOfOwnerCompany = "userIsMemberOfOwnerCompany"
        static let TagsLockedToAdmins = "tagsLockedToAdmins"
        static let FirstName = "firstname"
        static let DateSeperator = "dateSeperator"
        static let Logo = "logo"
        static let ChatEnabled = "chatEnabled"
        static let Id = "id"
        static let StartOnSundays = "startonsundays"
        static let TKOEnabled = "TKOEnabled"
        static let TagsEnabled = "tagsEnabled"
        static let URL = "URL"
        static let DateFormat = "dateFormat"
        static let Code = "code"
        static let RequireHTTPS = "requirehttps"
        static let CanAddProjects = "canaddprojects"
        static let Name = "name"
        static let UserIsAdmin = "userIsAdmin"
        static let CompanyName = "companyname"
        static let CanManagePeople = "canManagePeople"
        static let SSLEnabled = "ssl-enabled"
        static let DocumentEditorEnabled = "documentEditorEnabled"
        static let ProjectsEnabled = "projectsEnabled"
        static let TimeFormat = "timeFormat"
        static let AvatarURL = "avatar-url"
        static let DeskEnabled = "deskEnabled"
        static let LikesEnabled = "likesEnabled"
        static let CompanyId = "companyid"
        static let Lang = "lang"
        static let LastName = "lastname"
        static let UserId = "userId"
        static let PlanId = "plan-id"
        static let Status = "STATUS"
        static let Account = "account"
    }
}