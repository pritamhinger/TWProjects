//
//  TWProjectsHelper.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

extension TWProjectsClient{
    
    // MARK: - Helper Methods
    
    func getBaseURL(username: String, password:String, completionHandler: (results:AnyObject?, error:NSError?) -> Void) {
        let authorizationString = TWProjectsClient.getAuthorizationString(username, password: password)
        
        TWProjectsClient.sharedInstance().taskForAuthentication(authorizationString){ (results, error) in
            if error == nil{
                completionHandler(results: results, error: nil)
            }
            else{
                completionHandler(results: nil, error: error)
            }
        }
    }
    
    // MARK: - Class Methods
    class func getAuthorizationString(username:String, password:String) -> String{
        let authString = NSString(format: "%@:%@", username,password)
        let authData = authString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64AuthData = authData.base64EncodedStringWithOptions([])
        print("Auth header value: \(base64AuthData)")
        return base64AuthData
    }
    
    class func flickrURLFromParameters() -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = TWProjectsClient.APIResource.Scheme
        components.host = TWProjectsClient.APIResource.AuthenticationURL
        components.path = TWProjectsClient.APIResource.Method
        
        return components.URL!
    }
}