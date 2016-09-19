//
//  CoreDataConstants.swift
//  TWProjects
//
//  Created by Pritam Hinger on 13/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

extension CoreDataStack{
    struct EntityName {
        static let User = "User"
        static let Account = "Account"
        static let Company = "Company"
        static let Project = "Project"
    }
    
    struct  ModelName {
        static let TeamWorkDB = "TeamworkSchema"
    }
    
    struct Constants {
        static let DelaysInSeconds = 15
        static let DropData = true
    }
}