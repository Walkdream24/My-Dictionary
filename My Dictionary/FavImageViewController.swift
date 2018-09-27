//
//  FavImageViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/27.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit

class FavImageViewController: UIViewController {
    
    var favImage: Data!
    
    @IBOutlet weak var favImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(data: favImage)
        favImageView.image = image

        
    }
    

   
}
