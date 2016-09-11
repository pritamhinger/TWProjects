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
        static let Scheme = "https"
        static let AuthenticationURL = "authenticate.teamworkpm.net"
        static let Path = ""
        static let Method = "/authenticate.json"
    }
    
    struct APIMethods {
        static let Accounts = "account"
    }
    
    struct APIFormat {
        static let JSON = "json"
        static let XML = "xml"
    }
    
    struct HTTPMethod {
        static let GET = "GET"
        static let POST = "POST"
        static let PUT = "PUT"
        static let DELETE = "DELETE"
    }
    
    struct APIMethod {
        static let ACCOUNT = "account"
    }
    
    struct AccountResponseKeys {
        static let RealTimeNotifications = "realTimeNotifications"
        static let ShowSwitchToDotCom = "showSwitchToDotCom"
        static let DateSignedUp = "datesignedup"
        static let StrictBranding = "strictBranding"
        static let IsPaid = "isPaid"
        static let CanPreviewFiles = "canPreviewFiles"
        static let TouchIcon = "touchIcon"
        static let MarkdownEnabled = "markdownEnabled"
        static let Logo = "logo"
        static let ChatEnabled = "chatEnabled"
        static let Id = "id"
        static let TKOEnabled = "TKOEnabled"
        static let TagsEnabled = "tagsEnabled"
        static let ShowSiteNameOnLogin = "showSiteNameOnLogin"
        static let PricePlan = "pricePlan"
        static let AllowProjectAdminsCreateUsers = "allowProjectAdminsCreateUsers"
        static let PricePlanBranding = "priceplanBranding"
        static let CanEditCustomDomain = "canEditCustomDomain"
        static let Code = "code"
        static let Requirehttps = "requirehttps"
        static let Name = "name"
        static let UserIsAdmin = "userIsAdmin"
        static let TrialExpiryDate = "trialExpiryDate"
        static let CompanyName = "companyname"
        static let CanShareFiles = "canShareFiles"
        static let DocumentEditorEnabled = "documentEditorEnabled"
        static let CustomCSSEnabled = "customCSSEnabled"
        static let PaymentStatus = "paymentStatus"
        static let CacheUUID = "cacheUUID"
        static let OnTeamworkDomain = "onTeamworkDomain"
        static let DocumentEditorAvailable = "documentEditorAvailable"
        static let AllowKeepMeLoggedIn = "allowKeepMeLoggedIn"
        static let WebhooksEnabled = "webhooksEnabled"
        static let EmailNotificationEnabled = "email-notification-enabled"
        static let CompanyId = "companyid"
        static let PasswordPolicyIsOn = "passwordPolicyIsOn"
        static let NotebooksNewlineMode = "notebooksNewlineMode"
        static let RSSEnabled = "RSSEnabled"
        static let DashboardMessage = "dashboardMessage"
        static let TagsLockedToAdmins = "tagsLockedToAdmins"
        static let PricePlanId = "pricePlanId"
        static let PricePlanAllowSSL = "priceplanAllowSSL"
        static let FavIcon = "favIcon"
        static let AccountHolderId = "account-holder-id"
        static let URL = "URL"
        static let CleanNotebooksOnPaste = "cleanNotebooksOnPaste"
        static let TimeTrackingEnabled = "time-tracking-enabled"
        static let PDFServerLink = "pdfServerLink"
        static let DashboardProjectsList = "dashboardProjectsList"
        static let MemberOfOwnerCompany = "memberOfOwnerCompany"
        static let DashboardMessageHTML = "dashboardMessageHTML"
        static let SSLEnabled = "ssl-enabled"
        static let AllowTeamworkProjectsBrand = "allowTeamworkProjectsBrand"
        static let CreatedAt = "created-at"
        static let ProjectsEnabled = "projectsEnabled"
        static let IsAdmin = "isAdmin"
        static let DeskEnabled = "deskEnabled"
        static let CustomCSS = "customCSS"
        static let LikesEnabled = "likesEnabled"
        static let Lang = "lang"
        static let Status = "STATUS"
        static let Account = "account"
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