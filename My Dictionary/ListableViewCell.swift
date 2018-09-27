//
//  ListableViewCell.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/22.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit

class ListableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var wordNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackground.layer.cornerRadius = 10
        cellBackground.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
