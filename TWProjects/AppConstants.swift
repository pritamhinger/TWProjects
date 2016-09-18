//
//  AppConstants.swift
//  TWProjects
//
//  Created by Pritam Hinger on 12/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

struct AppConstants {
    struct UserDefaultKeys {
        static let BaseURL = "BaseURL"
        static let AuthorizationCookie = "AuthorizationCookie"
        static let CompanyIds = "companyIds"
        static let CompanyNames = "companyNames"
    }
    
    struct CellIdentifier {
        static let ProjectCell = "projectCell"
        static let ProjectPropertyCell = "projectPropertyCell"
        static let LatestActivityCell = "latestActivityCell"
    }
    
    struct  ErrorKeys {
        static let ErrorDescription = "NSLocalizedDescription"
    }
    
    struct AlertViewTitle {
        static let Error = "Error"
        static let NetworkError = "Network Error"
        static let UnknownError = "Unknown Error"
        static let MoreInformationNeeded = "More Information Needed"
    }
    
    struct  SegueIdentifier {
        static let AddProjectSegue = "addProjectSegue"
        static let EditProjectSegue = "editProjectSegue"
        static let DateTimePickerSegue = "dateTimePickerSegue"
    }
    
    struct StoryboardVCIdentifier {
        static let DateTimePickerVCId = "DateTimePickerVCId"
        static let ProjectDetailVCId = "projectDetailVCId"
    }
    
    struct NotificationName {
        static let DateChosenNotification = "dateChosenNotification"
        static let DataSaveSuccessNotification = "dataSaveSuccessNotification"
    }
    
    struct NotificatioPayloadKeys {
        static let ChosenDate = "ChosenDate"
    }
    
    struct DateFormats {
        static let ShownOnUI = ""
        static let PassedToAPI = "yyyyMMdd"
    }
}