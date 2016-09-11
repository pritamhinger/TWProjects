//
//  Account.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

struct Account {
    let realTimeNotifications:Bool?
    let showSwitchToDotCom:Bool?
    let datesignedup:NSDate?
    let strictBranding:Bool?
    let isPaid:Bool?
    let canPreviewFiles:Bool?
    let touchIcon:String?
    let markdownEnabled:Bool?
    let logo:String?
    let chatEnabled:Bool?
    let id:String?
    let TKOEnabled:Bool?
    let tagsEnabled:Bool?
    let showSiteNameOnLogin:Bool?
    let pricePlan:String?
    let allowProjectAdminsCreateUsers:Bool?
    let priceplanBranding:Bool?
    let canEditCustomDomain:String?
    let code:String?
    let requirehttps:Bool?
    let name:String?
    let userIsAdmin:Bool?
    let trialExpiryDate:NSDate?
    let companyname:String?
    let canShareFiles:Bool?
    let documentEditorEnabled:Bool?
    let customCSSEnabled:Bool?
    let paymentStatus:String?
    let cacheUUID:String?
    let onTeamworkDomain:Bool?
    let documentEditorAvailable:Bool?
    let allowKeepMeLoggedIn:Bool?
    let webhooksEnabled:Bool?
    let emailNotificationEnabled:Bool?
    let companyid:String?
    let passwordPolicyIsOn:Bool?
    let notebooksNewlineMode:Bool?
    let RSSEnabled:Bool?
    let dashboardMessage:String?
    let tagsLockedToAdmins:Bool?
    let pricePlanId:String?
    let priceplanAllowSSL:Bool?
    let favIcon:String?
    let accountHolderId:String?
    let url:String?
    let cleanNotebooksOnPaste:Bool?
    let timeTrackingEnabled:Bool?
    let pdfServerLink:String?
    let dashboardProjectsList:String?
    let memberOfOwnerCompany:Bool?//Handle It Properly
    let dashboardMessageHTML:String?
    let sslEnabled:Bool?
    let allowTeamworkProjectsBrand:Bool?
    let createdAt:NSDate?
    let projectsEnabled:Bool?
    let isAdmin:Bool?
    let deskEnabled:Bool?
    let customCSS:String?
    let likesEnabled:Bool?
    let lang:String?
    
    init(accountDictionary:[String:AnyObject]){
        realTimeNotifications = accountDictionary[TWProjectsClient.AccountResponseKeys.RealTimeNotifications] as? Bool
        showSwitchToDotCom = accountDictionary[TWProjectsClient.AccountResponseKeys.ShowSwitchToDotCom] as? Bool
        datesignedup = accountDictionary[TWProjectsClient.AccountResponseKeys.DateSignedUp] as? NSDate
        strictBranding = accountDictionary[TWProjectsClient.AccountResponseKeys.StrictBranding] as? Bool
        if let isPaid = accountDictionary[TWProjectsClient.AccountResponseKeys.IsPaid] as? String{
            if isPaid == "0"{
                self.isPaid = false
            }
            else{
                self.isPaid = true
            }
        }
        else{
            self.isPaid = false
        }
        
        canPreviewFiles = accountDictionary[TWProjectsClient.AccountResponseKeys.CanPreviewFiles] as? Bool
        touchIcon = accountDictionary[TWProjectsClient.AccountResponseKeys.TouchIcon] as? String
        markdownEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.MarkdownEnabled] as? Bool
        logo = accountDictionary[TWProjectsClient.AccountResponseKeys.Logo] as? String
        chatEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.ChatEnabled] as? Bool
        id = accountDictionary[TWProjectsClient.AccountResponseKeys.Id] as? String
        TKOEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.TKOEnabled] as? Bool
        tagsEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.TagsEnabled] as? Bool
        showSiteNameOnLogin = accountDictionary[TWProjectsClient.AccountResponseKeys.ShowSiteNameOnLogin] as? Bool
        pricePlan = accountDictionary[TWProjectsClient.AccountResponseKeys.PricePlan] as? String
        allowProjectAdminsCreateUsers = accountDictionary[TWProjectsClient.AccountResponseKeys.AllowProjectAdminsCreateUsers] as? Bool
        priceplanBranding = accountDictionary[TWProjectsClient.AccountResponseKeys.PricePlanBranding] as? Bool
        canEditCustomDomain = accountDictionary[TWProjectsClient.AccountResponseKeys.CanEditCustomDomain] as? String
        code = accountDictionary[TWProjectsClient.AccountResponseKeys.Code] as? String
        requirehttps = accountDictionary[TWProjectsClient.AccountResponseKeys.Requirehttps] as? Bool
        name = accountDictionary[TWProjectsClient.AccountResponseKeys.Name] as? String
        userIsAdmin = accountDictionary[TWProjectsClient.AccountResponseKeys.UserIsAdmin] as? Bool
        trialExpiryDate = accountDictionary[TWProjectsClient.AccountResponseKeys.TrialExpiryDate] as? NSDate
        companyname = accountDictionary[TWProjectsClient.AccountResponseKeys.CompanyName] as? String
        canShareFiles = accountDictionary[TWProjectsClient.AccountResponseKeys.CanShareFiles] as? Bool
        documentEditorEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.DocumentEditorEnabled] as? Bool
        customCSSEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.CustomCSSEnabled] as? Bool
        paymentStatus = accountDictionary[TWProjectsClient.AccountResponseKeys.PaymentStatus] as? String
        cacheUUID = accountDictionary[TWProjectsClient.AccountResponseKeys.CacheUUID] as? String
        onTeamworkDomain = accountDictionary[TWProjectsClient.AccountResponseKeys.OnTeamworkDomain] as? Bool
        documentEditorAvailable = accountDictionary[TWProjectsClient.AccountResponseKeys.DocumentEditorAvailable] as? Bool
        allowKeepMeLoggedIn = accountDictionary[TWProjectsClient.AccountResponseKeys.AllowKeepMeLoggedIn] as? Bool
        webhooksEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.WebhooksEnabled] as? Bool
        emailNotificationEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.EmailNotificationEnabled] as? Bool
        companyid = accountDictionary[TWProjectsClient.AccountResponseKeys.CompanyId] as? String
        passwordPolicyIsOn = accountDictionary[TWProjectsClient.AccountResponseKeys.PasswordPolicyIsOn] as? Bool
        notebooksNewlineMode = accountDictionary[TWProjectsClient.AccountResponseKeys.NotebooksNewlineMode] as? Bool
        RSSEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.RSSEnabled] as? Bool
        dashboardMessage = accountDictionary[TWProjectsClient.AccountResponseKeys.DashboardMessage] as? String
        tagsLockedToAdmins = accountDictionary[TWProjectsClient.AccountResponseKeys.TagsLockedToAdmins] as? Bool
        pricePlanId = accountDictionary[TWProjectsClient.AccountResponseKeys.PricePlanId] as? String
        priceplanAllowSSL = accountDictionary[TWProjectsClient.AccountResponseKeys.PricePlanAllowSSL] as? Bool
        favIcon = accountDictionary[TWProjectsClient.AccountResponseKeys.FavIcon] as? String
        accountHolderId = accountDictionary[TWProjectsClient.AccountResponseKeys.AccountHolderId] as? String
        url = accountDictionary[TWProjectsClient.AccountResponseKeys.URL] as? String
        cleanNotebooksOnPaste = accountDictionary[TWProjectsClient.AccountResponseKeys.CleanNotebooksOnPaste] as? Bool
        timeTrackingEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.TimeTrackingEnabled] as? Bool
        pdfServerLink = accountDictionary[TWProjectsClient.AccountResponseKeys.PDFServerLink] as? String
        dashboardProjectsList = accountDictionary[TWProjectsClient.AccountResponseKeys.DashboardProjectsList] as? String
        
        if let memberOfOwnerCompany = accountDictionary[TWProjectsClient.AccountResponseKeys.MemberOfOwnerCompany] as? String{
            if memberOfOwnerCompany == "YES"{
                self.memberOfOwnerCompany = true
            }
            else{
                self.memberOfOwnerCompany = false
            }
        }
        else{
            self.memberOfOwnerCompany = false
        }
        
        dashboardMessageHTML = accountDictionary[TWProjectsClient.AccountResponseKeys.DashboardMessageHTML] as? String
        sslEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.SSLEnabled] as? Bool
        allowTeamworkProjectsBrand = accountDictionary[TWProjectsClient.AccountResponseKeys.AllowTeamworkProjectsBrand] as? Bool
        createdAt = accountDictionary[TWProjectsClient.AccountResponseKeys.CreatedAt] as? NSDate
        projectsEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.ProjectsEnabled] as? Bool
        isAdmin = accountDictionary[TWProjectsClient.AccountResponseKeys.IsAdmin] as? Bool
        deskEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.DeskEnabled] as? Bool
        customCSS = accountDictionary[TWProjectsClient.AccountResponseKeys.CustomCSS] as? String
        likesEnabled = accountDictionary[TWProjectsClient.AccountResponseKeys.LikesEnabled] as? Bool
        lang = accountDictionary[TWProjectsClient.AccountResponseKeys.Lang] as? String
    }
    
    
    
    
    
    
}