//
//  ChatTableViewCell.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/31.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
//        label.contentView.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
