//
//  TWPAppLoadingViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 02/10/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPAppLoadingViewController: UIViewController, AppLoaderViewDelegate {

    var appLoaderView = TWPAppLoaderView(frame: CGRectZero)
    var animationCycleCount = 0
    static let MAX_ANIMATION_CYCLE = 5
    var loginProcessCompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForLogin()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.LoggedOutCalled
            ) == nil || CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.LoggedInUserAPIKey) != nil{
            print("Loading loader view")
            addLoaderView()
        }
        else{
            print("Logged out has been called")
            CommonFunctions.deleteValueForKey(AppConstants.UserDefaultKeys.LoggedOutCalled)
            self.performSegueWithIdentifier(AppConstants.SegueIdentifier.AppSegueLoginVC, sender: nil)
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TWPAppLoadingViewController.logoutNotification(_:)), name: AppConstants.NotificationName.LogoutNotification, object: nil)
    }
    
    func prepareForLogin() {
        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.LoggedIn, value: false)
        if let apiKey = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.LoggedInUserAPIKey) as? String{
            print("API Key is : \(apiKey)")
            tryLoginForUser(apiKey)
        }
        else{
            loginProcessCompleted = true
        }
    }
    
    func logoutNotification(notification:NSNotification) {
        print("Logged Out. Try to show login window")
        //self.performSegueWithIdentifier(AppConstants.SegueIdentifier.AppSegueLoginVC, sender: nil)
    }
    
    func animateCompanyLabel() {
        appLoaderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        let label = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "AvenirNext-Bold", size: 170.0)
        label.textAlignment = .Center
        label.text = "TW"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        
        let frame = CGRectMake(label.frame.origin.x, label.frame.origin.y + label.frame.height, label.frame.width, CGFloat(25))
        let label2 = UILabel(frame: frame)
        label2.textColor = Colors.white
        label2.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label2.textAlignment = .Center
        label2.text = "Projects"
        label2.transform = CGAffineTransformScale(label2.transform, 0.25, 0.25)
        view.addSubview(label2)
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .CurveEaseInOut, animations: {
            label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            label2.transform = CGAffineTransformScale(label2.transform, 4.0, 4.0)
            }, completion: { finished in
                if self.isLoginSuccessful() {
                    // Show segue to Dashboard VC
                    print("Show segue to Dashboard VC")
                    self.performSegueWithIdentifier(AppConstants.SegueIdentifier.AppSegueByPassLogin, sender: nil)
                }
                else if self.animationCycleCount == TWPAppLoadingViewController.MAX_ANIMATION_CYCLE || self.loginProcessCompleted{
                    // Show segue to Login VC
                    print("Show segue to Login VC")
                    let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier(AppConstants.StoryboardVCIdentifier.LoginVCStoryboardId) as! TWPLoginViewController
                    self.presentViewController(loginVC, animated: true, completion: nil)
                }
                else{
                    self.animationCycleCount += 1
                    self.repeatAnimation()
                }
        })
    }
    
    func addLoaderView() {
        let viewBox:CGFloat = 100.0
        appLoaderView.frame = CGRect(x: view.bounds.width/2 - viewBox/2,
                                     y: view.bounds.height/2 - viewBox/2,
                                     width: viewBox,
                                     height: viewBox)
        appLoaderView.parentFrame = view.frame
        appLoaderView.delegate = self
        view.addSubview(appLoaderView)
        appLoaderView.addCirclePath()
    }

    func repeatAnimation(){
        view.backgroundColor = Colors.white
        let superView = view.subviews.map({ $0.removeFromSuperview() })
        print(superView)
        appLoaderView = TWPAppLoaderView(frame: CGRectZero)
        addLoaderView()
    }
    
    func isLoginSuccessful() -> Bool {
        
        if let loggedIn = CommonFunctions.getUserDefaultForKey(AppConstants.UserDefaultKeys.LoggedIn) as? Bool{
            return loggedIn
        }
        else{
            CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.LoggedIn, value: false)
        }
        
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tryLoginForUser(apiKey:String) {
        let authenticationHeader = TWProjectsClient.getAuthorizationString(apiKey, password: "")
        TWProjectsClient.sharedInstance().getBaseURL(authenticationHeader){ (results, error) in
            if error == nil{
                if let userStatus = results![TWProjectsClient.AuthenticateResponseKeys.Status] as? String{
                    if userStatus == "OK"{
                        // Response is Ok. Parsing JSON and creating User Instance
                        let user = User(userDictionary: results![TWProjectsClient.AuthenticateResponseKeys.Account] as! [String:AnyObject]);
                        
                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.LoggedInUserAPIKey, value: apiKey)
                        
                        // Adding Base URL, after processing, to UserDefault Dictionary.
                        // We would be using this for every network call
                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.BaseURL, value: CommonFunctions.removeProtocolFromURL(user.url!))
                        
                        performUIUpdatesOnMainQueue{
                            // Initiating a new Network Activity indicator View
                            let methodName = TWProjectsClient.APIMethod.ACCOUNT
                            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authenticationHeader){ (results, error) in
                                if error == nil{
                                    if let accountStatus = results![TWProjectsClient.AccountResponseKeys.Status] as? String{
                                        if accountStatus == "OK"{
                                            let account = Account(accountDictionary: results![TWProjectsClient.AccountResponseKeys.Account] as! [String:AnyObject])
                                            print(account.accountHolderId)
                                        }
                                    }
                                    
                                    performUIUpdatesOnMainQueue{
                                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.AuthorizationCookie, value: authenticationHeader)
                                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.LoggedIn, value: true)
                                    }
                                }
                                else{
                                    // Showing error in alert view. Calling Common function to show AlertView
                                    print(error)
                                }
                                
                                self.loginProcessCompleted = true
                            }
                        }
                    }
                }
            }
            else{
                // Showing error in alert view. Calling Common function to show AlertView
                print(error)
                self.loginProcessCompleted = true
            }
        }
    }
}
