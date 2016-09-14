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
    
    func getBaseURL(authorizationString: String, completionHandler: (results:AnyObject?, error:NSError?) -> Void) {
        TWProjectsClient.sharedInstance().taskForAuthentication(authorizationString){ (results, error) in
            if error == nil{
                completionHandler(results: results, error: nil)
            }
            else{
                completionHandler(results: nil, error: error)
            }
        }
    }
    
    func getDataForMethod(methodName: String, authorizationCookie: String, completionHandler: (results:AnyObject?, error: NSError?) -> Void){
        TWProjectsClient.sharedInstance().taskForGet(methodName, authorizationCookie: authorizationCookie){ (results, error) in
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
    
    class func twAuthenticationURL() -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = TWProjectsClient.APIResource.Scheme
        components.host = TWProjectsClient.APIResource.AuthenticationURL
        components.path = TWProjectsClient.APIResource.Path + TWProjectsClient.APIResource.Method
        
        return components.URL!
    }
    
    class func twAPIUrlForMethod(methodName:String, id:String="", urlKey:String="") -> NSURL{
        let components = NSURLComponents()
        components.scheme = TWProjectsClient.APIResource.Scheme
        if let baseURL = CommonFunctions.getTWBaseURL(){
            components.host = baseURL
        }
        else{
            fatalError("Account not configured.")
        }
        
        if(id != "" && urlKey != ""){
            let substitutedMethodName = TWProjectsClient.sharedInstance().subtituteKeyInMethod(methodName, key: urlKey, value: id)
            components.path = TWProjectsClient.APIResource.Path + "/" + substitutedMethodName!
        }
        else{
            components.path = TWProjectsClient.APIResource.Path + "/" + methodName
        }
        
        return components.URL!
    }
    
    class func getMethodName(methodName:String, methodFormat:String) -> String{
        return "\(methodName).\(methodFormat)"
    }
    
    private func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
}