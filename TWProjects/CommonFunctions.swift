//
//  CommonFunctions.swift
//  TWProjects
//
//  Created by Pritam Hinger on 12/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation
import UIKit

struct CommonFunctions {
    
    static func showError(controller:UIViewController, message:String, title:String, style:UIAlertControllerStyle){
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertViewController.addAction(okAction)
        controller.presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    static func showError(controller:UIViewController, error:NSError?, userInfoKey: String, title:String, style:UIAlertControllerStyle){
        
        var errorMessage:String?
        if let errorData = error?.userInfo{
            errorMessage = errorData[userInfoKey] as? String
        }
        
        if errorMessage == nil || errorMessage == ""{
            errorMessage = "Something went wrong. Please try again"
        }
        
        let alertViewController = UIAlertController(title: title, message: errorMessage!, preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertViewController.addAction(okAction)
        controller.presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    static func addToUserDefault(key: String, value:AnyObject){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: key)
    }
    
    static func getUserDefaultForKey(key:String) -> AnyObject?{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let value =  userDefaults.valueForKey(key){
            return value
        }
        else{
            return nil
        }
    }
    
    static func removeProtocolFromURL(urlString:String) -> String{
        let url = NSURL(string: urlString)
        let scheme = url?.scheme
        let trimmedURL = urlString.stringByReplacingOccurrencesOfString(scheme!, withString: "").stringByReplacingOccurrencesOfString("://", withString: "").stringByReplacingOccurrencesOfString("/", withString: "")
        print(trimmedURL)
        return trimmedURL
    }
    
    static func getTWBaseURL()-> String?{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let baseURL = userDefaults.valueForKey(AppConstants.UserDefaultKeys.BaseURL) as? String{
            print(baseURL)
            return baseURL
        }
        
        return nil
    }
    
    static func getFormattedDateForUI(date:NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        return dateFormatter.stringFromDate(date)
    }
    
    static func getFormattedDateForAPI(dateString:String) -> String{
        if dateString == ""{
            return ""
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        let date = dateFormatter.dateFromString(dateString)
        dateFormatter.dateFormat = AppConstants.DateFormats.PassedToAPI
        return dateFormatter.stringFromDate(date!)
    }
    
    static func convertDictionaryToString(dictionary:[String:AnyObject]) -> String{
        var json = ""
        for(key, value) in dictionary{
            json = "\(json)\"\(key)\":\"\(value)\","
        }
        
        let length = json.characters.count
        if( length > 0){
            json = json.substringToIndex(json.endIndex.predecessor())
        }
        
        return json
    }
    
    
}