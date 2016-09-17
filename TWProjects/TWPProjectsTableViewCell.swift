//
//  TWPProjectsTableViewCell.swift
//  TWProjects
//
//  Created by Pritam Hinger on 17/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import UIKit

class TWPProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectStarredImageView: UIImageView!
    @IBOutlet weak var projectDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
