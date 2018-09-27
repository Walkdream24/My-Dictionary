//
//  FavoriteTableViewCell.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/27.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bkgImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var favWordNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        bkgImageView.layer.cornerRadius = 10
        bkgImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
