//
//  TWPLoginViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 10/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPLoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var apiKeyTextField: UITextField!
    
    // MARK: - VC Life Cycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding Tap recongnizer to view to dismiss keyboard when user taps on View
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TWPLoginViewController.tap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        // Setting UITextFieldDelegate  to API Key TextField to capture Return Key Events
        apiKeyTextField.delegate = self
    }

    // MARK: - IBActions
    @IBAction func login(sender: UIButton) {
        // Returning if Secret Key textfield is empty
        if apiKeyTextField.text?.characters.count == 0 {
            return
        }
        
        // Dismissing Keyboard as we have Secret Key to validate
        view.endEditing(true)
        
        // Initialiting Network Activity Control
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // Setting title to Network Activity Control
        hud.label.text = "Authenticating"
        
        // Creating ByteCode representation of Secret Key. This bytecode is sent as Value of Authorization Key in 
        // HTTP Header. Teamwork API support Basic Authentication.
        // Read more at : http://developer.teamwork.com/account#the_'authenti
        let authenticationHeader = TWProjectsClient.getAuthorizationString(apiKeyTextField.text!, password: "")
        
        // Initiating Get Call on Teamwork Server with Secret Key. If secret Key is Valid then API would return
        // Account JSON which contain url to make subsequent API Calls. This URL is specific to this Account. 
        // We would save this URL in UserDefaults and would be accessing it everytime we make a network call.
        TWProjectsClient.sharedInstance().getBaseURL(authenticationHeader){ (results, error) in
            if error == nil{
                if let userStatus = results![TWProjectsClient.AuthenticateResponseKeys.Status] as? String{
                    if userStatus == "OK"{
                        // Response is Ok. Parsing JSON and creating User Instance
                        let user = User(userDictionary: results![TWProjectsClient.AuthenticateResponseKeys.Account] as! [String:AnyObject]);
                        
                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.LoggedInUserAPIKey, value: self.apiKeyTextField.text!)
                        
                        // Adding Base URL, after processing, to UserDefault Dictionary. 
                        // We would be using this for every network call
                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.BaseURL, value: CommonFunctions.removeProtocolFromURL(user.url!))
                        
                        performUIUpdatesOnMainQueue{
                            // Stopping Authentication Newtork Activity indicator View
                            hud.hideAnimated(true)
                            
                            // Initiating a new Network Activity indicator View
                            let hudAuthorization = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                            hudAuthorization.label.text = "Authorizing"
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
                                        // Stopping Authentication Newtork Activity indicator View
                                        hudAuthorization.hideAnimated(true)
                                        self.performSegueWithIdentifier(AppConstants.SegueIdentifier.AppSegue, sender: nil)
                                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.AuthorizationCookie, value: authenticationHeader)
                                    }
                                }
                                else{
                                    // Showing error in alert view. Calling Common function to show AlertView
                                    print(error)
                                    
                                    performUIUpdatesOnMainQueue{
                                        hudAuthorization.hideAnimated(true)
                                        CommonFunctions.showError(self, error: error, userInfoKey: AppConstants.ErrorKeys.ErrorDescription, title: AppConstants.AlertViewTitle.Error, style: .Alert)
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                }
            }
            else{
                // Showing error in alert view. Calling Common function to show AlertView
                print(error)
                performUIUpdatesOnMainQueue{
                    hud.hideAnimated(true)
                    CommonFunctions.showError(self, error: error, userInfoKey: AppConstants.ErrorKeys.ErrorDescription, title: AppConstants.AlertViewTitle.Error, style: .Alert)
                }
            }
        }
    }
    
    // MARK: - Gesture Event
    func tap(sender: UITapGestureRecognizer) {
        // Dismissing Keyboard by ending editing in View
        view.endEditing(true)
    }
    
    // MARK: - UITextField Delegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Dismissing Keyboard on click of Return Key in Keyboard
        textField.resignFirstResponder()
        return true
    }
}

