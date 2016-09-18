//
//  TWPLoginViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 10/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPLoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var apiKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TWPLoginViewController.tap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        apiKeyTextField.delegate = self
    }

    @IBAction func login(sender: UIButton) {
        
        if apiKeyTextField.text?.characters.count == 0 {
            return
        }
        
        view.endEditing(true)
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.label.text = "Authenticating"
        let authenticationHeader = TWProjectsClient.getAuthorizationString(apiKeyTextField.text!, password: "")
        TWProjectsClient.sharedInstance().getBaseURL(authenticationHeader){ (results, error) in
            if error == nil{
                if let userStatus = results![TWProjectsClient.AuthenticateResponseKeys.Status] as? String{
                    if userStatus == "OK"{
                        let user = User(userDictionary: results![TWProjectsClient.AuthenticateResponseKeys.Account] as! [String:AnyObject]);
                        print("User id is : \(user.userId!)")
                        
                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.BaseURL, value: CommonFunctions.removeProtocolFromURL(user.url!))
                        
                        performUIUpdatesOnMainQueue{
                            hud.hideAnimated(true)
                            
                            let hudAuthorization = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                            hudAuthorization.label.text = "Authorizing"
                            let methodName = TWProjectsClient.getMethodName(TWProjectsClient.APIMethod.ACCOUNT, methodFormat: TWProjectsClient.APIFormat.JSON)
                            TWProjectsClient.sharedInstance().getDataForMethod(methodName, authorizationCookie: authenticationHeader){ (results, error) in
                                if error == nil{
                                    if let accountStatus = results![TWProjectsClient.AccountResponseKeys.Status] as? String{
                                        if accountStatus == "OK"{
                                            let account = Account(accountDictionary: results![TWProjectsClient.AccountResponseKeys.Account] as! [String:AnyObject])
                                            print(account.accountHolderId)
                                            print(account.cacheUUID)
                                        }
                                    }
                                    
                                    performUIUpdatesOnMainQueue{
                                        self.performSegueWithIdentifier("AppSegue", sender: nil)
                                        CommonFunctions.addToUserDefault(AppConstants.UserDefaultKeys.AuthorizationCookie, value: authenticationHeader)
                                    }
                                }
                                else{
                                    print(error)
                                }
                                
                                performUIUpdatesOnMainQueue{
                                    hudAuthorization.hideAnimated(true)
                                }
                            }
                        }
                    }
                }
            }
            else{
                print(error)
            }
        }
    }
    
    // MARK: - Gesture Event
    func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - UITextField Delegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

