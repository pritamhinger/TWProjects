//
//  ViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 10/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPLoginViewController: UIViewController {

    
    @IBOutlet weak var apiKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: UIButton) {
        
        if apiKeyTextField.text?.characters.count == 0 {
            return
        }
        
        print("API Key is : \(apiKeyTextField.text!)")
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.label.text = "Authenticating"
        //board146head:  232035
        //speak564welly: 239072
        //poland47misty: 231257
        let authenticationHeader = TWProjectsClient.getAuthorizationString(apiKeyTextField.text!, password: "")
        TWProjectsClient.sharedInstance().getBaseURL(authenticationHeader){ (results, error) in
            if error == nil{
                if let status = results![TWProjectsClient.AuthenticateResponseKeys.Status] as? String{
                    if status == "OK"{
                        let user = User(userDictionary: results![TWProjectsClient.AuthenticateResponseKeys.Account] as! [String:AnyObject]);
                        print("User id is : \(user.userId!)")
                        print("URL is : \(user.url!)")
                        print("\(user.firstName!) \(user.lastName!)")
                    }
                }
            }
            else{
                print(error)
            }
            
            performUIUpdatesOnMainQueue{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
    }
    
}

