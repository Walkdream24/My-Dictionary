//
//  ImageViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/24.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var getImage: Data!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(data: getImage)
        
        imageView.image = image

       
    }
    

  

}
