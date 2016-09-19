//
//  TWProjectsClient.swift
//  TWProjects
//
//  Created by Pritam Hinger on 11/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation

class TWProjectsClient: NSObject {
    
    // MARK: Shared Instance
    class func sharedInstance() -> TWProjectsClient{
        struct Singleton{
            static var instance = TWProjectsClient()
        }
        
        return Singleton.instance
    }
    
    // MARK: - Properties
    let session = NSURLSession.sharedSession()
    
    // MARK: - Authentication Methods
    func taskForAuthentication(authorizationCookie:String, completionHandler: (result: AnyObject!, error:NSError?) -> Void) -> NSURLSessionDataTask {
        
        let request = NSMutableURLRequest(URL: TWProjectsClient.twAuthenticationURL())
        request.HTTPMethod = TWProjectsClient.HTTPMethod.GET
        request.addValue("Basic \(authorizationCookie)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        print(request.URL?.absoluteString)
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(errorString: String) {
                let userInfo = [NSLocalizedDescriptionKey : errorString]
                var err:NSError?
                if error != nil{
                    err = NSError(domain: (error?.domain)!, code: (error?.code)!, userInfo: userInfo)
                }
                else{
                    err = NSError(domain: "", code: 0, userInfo: userInfo)
                }
                completionHandler(result: nil, error: err)
            }
            
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Login Failed. Please try again")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
        }
        
        task.resume()
        return task
    }
    
    // MARK: - Get Tasks
    func taskForGet(methodName: String, authorizationCookie:String = "", urlKey: String = "", id: String = "", completionHandler:(results:AnyObject?, error:NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: TWProjectsClient.twAPIUrlForMethod(methodName, id: id, urlKey: urlKey))
        request.HTTPMethod = TWProjectsClient.HTTPMethod.GET
        request.addValue("Basic \(authorizationCookie)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        print(request.URL?.absoluteString)
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(errorString: String) {
                let userInfo = [NSLocalizedDescriptionKey : errorString]
                var err:NSError?
                if error != nil{
                    err = NSError(domain: (error?.domain)!, code: (error?.code)!, userInfo: userInfo)
                }
                else{
                    err = NSError(domain: "", code: 0, userInfo: userInfo)
                }
                completionHandler(results: nil, error: err)
            }
            
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
        }
        
        task.resume()
        return task
    }
    
    func taskForPut(methodName: String, authorizationCookie:String = "", jsonBody: String = "", urlKey: String = "", id: String = "", completionHandler:(results:AnyObject?, error:NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: TWProjectsClient.twAPIUrlForMethod(methodName, id: id, urlKey: urlKey))
        request.HTTPMethod = TWProjectsClient.HTTPMethod.PUT
        request.addValue("Basic \(authorizationCookie)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        if jsonBody != ""{
            request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(errorString: String) {
                let userInfo = [NSLocalizedDescriptionKey : errorString]
                var err:NSError?
                if error != nil{
                    err = NSError(domain: (error?.domain)!, code: (error?.code)!, userInfo: userInfo)
                }
                else{
                    err = NSError(domain: "", code: 0, userInfo: userInfo)
                }
                completionHandler(results: nil, error: err)
            }
            
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
        }
        
        task.resume()
        return task
    }
    
    func taskForPost(methodName: String, jsonBody:String, authorizationCookie:String = "", urlKey: String = "", id: String = "", completionHandler:(results:AnyObject?, error:NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: TWProjectsClient.twAPIUrlForMethod(methodName, id: id, urlKey: urlKey))
        request.HTTPMethod = TWProjectsClient.HTTPMethod.POST
        request.addValue("Basic \(authorizationCookie)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        print(request.URL?.absoluteString)
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(errorString: String) {
                let userInfo = [NSLocalizedDescriptionKey : errorString]
                var err:NSError?
                if error != nil{
                    err = NSError(domain: (error?.domain)!, code: (error?.code)!, userInfo: userInfo)
                }
                else{
                    err = NSError(domain: "", code: 0, userInfo: userInfo)
                }
                completionHandler(results: nil, error: err)
            }
            
            guard (error == nil) else {
                sendError((error?.localizedDescription)!)
                return
            }
            
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
        }
        
        task.resume()
        return task
    }
    
    // MARK: - Private Methods
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            //print(parsedResult)
        } catch {
            let output = NSString(data: data, encoding: NSUTF8StringEncoding)
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(output)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
}