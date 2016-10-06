//
//  TWPLogoutViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 05/10/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPLogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutProcedute()
    }
    
    func logoutProcedute() {
        CommonFunctions.deleteValueForKey(AppConstants.UserDefaultKeys.LoggedInUserAPIKey)
        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.LoggedOutCalled, value: true)
        NSNotificationCenter.defaultCenter().postNotificationName(AppConstants.NotificationName.LogoutNotification, object: nil)
        dismissViewControllerAnimated(false, completion: nil)
    }

}
