//
//  HomeImageViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/28.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit

class HomeImageViewController: UIViewController {

    var getHomeImageData: Data!
    
    @IBOutlet weak var homeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(data: getHomeImageData)
        homeImageView.image = image

    }
    

   
}
