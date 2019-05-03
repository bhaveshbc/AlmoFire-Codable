//
//  NewsFeedTableViewCell.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 03/05/19.
//  Copyright © 2019 Bhavesh Chaudhari. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet var feedsImage : UIImageView!
    @IBOutlet var feedsName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model:NewsFeed) {
        if let username = model.scorer?.Username {
            self.feedsName.text = username
        }
    }

}
