//
//  ViewController.swift
//  TWProjects
//
//  Created by Pritam Hinger on 10/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue()){
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
}

