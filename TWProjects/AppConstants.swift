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
    }
    
    struct CellIdentifier {
        static let ProjectCell = "projectCell"
        static let ProjectPropertyCell = "projectPropertyCell"
    }
    
    struct  SegueIdentifier {
        static let AddProjectSegue = "addProjectSegue"
        static let DateTimePickerSegue = "dateTimePickerSegue"
    }
    
    struct StoryboardVCIdentifier {
        static let DateTimePickerVCId = "DateTimePickerVCId"
    }
    
    struct NotificationName {
        static let DateChosenNotification = "dateChosenNotification"
    }
}