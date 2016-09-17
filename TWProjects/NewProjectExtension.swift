//
//  NewProjectExtension.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation


extension TWPAddProjectViewController{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AppConstants.CellIdentifier.ProjectPropertyCell, forIndexPath: indexPath) as UITableViewCell
        
        cell.detailTextLabel?.text = ""
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Company: "
        case 1:
            cell.textLabel?.text = "Tags: "
            cell.detailTextLabel?.text = "Not Tagged"
        case 2:
            cell.textLabel?.text = "Category: "
            cell.detailTextLabel?.text = "No Category"
        case 3:
            cell.textLabel?.text = "Start Date: "
            if let date = startDate{
                cell.detailTextLabel?.text = "\(date)"
            }
        case 4:
            cell.textLabel?.text = "End Date: "
            if let date = endDate{
                cell.detailTextLabel?.text = "\(date)"
            }
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenIndexPath = indexPath
        if indexPath.row > 2{
            performSegueWithIdentifier(AppConstants.SegueIdentifier.DateTimePickerSegue, sender: nil)
        }
    }
}

extension TWPAddProjectViewController{
    func setDate(notification:NSNotification) {
        if let data = notification.userInfo{
            switch (chosenIndexPath?.row)! {
            case 3:
                startDate = data["ChosenDate"] as? NSDate
                break
            case 4:
                endDate = data["ChosenDate"] as? NSDate
                break
            default:
                break
            }
        }
        
        tableView.reloadData()
    }
}