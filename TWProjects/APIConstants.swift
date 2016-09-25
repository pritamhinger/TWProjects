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
        static let DefaultFormat = APIFormat.JSON
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
    
    struct URLKeys {
        static let ProjectId = "project_id"
    }
    
    struct APIMethod {
        static let ACCOUNT = "account.\(APIResource.DefaultFormat)"
        static let Companies = "companies.\(APIResource.DefaultFormat)"
        static let Projects = "projects.\(APIResource.DefaultFormat)"
        static let StarProject = "projects/{project_id}/star.\(APIResource.DefaultFormat)"
        static let UnstarProject = "/projects/{project_id}/unstar.\(APIResource.DefaultFormat)"
        static let UpdateProject = "projects/{project_id}.\(APIResource.DefaultFormat)"
        static let AllActivity = "latestActivity.\(APIResource.DefaultFormat)"
    }
}