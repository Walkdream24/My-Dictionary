//
//  FavoriteDetailViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/27.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    var getFavWord: String!
    var getFavDetail: String!
    var getFavImageData: Data!
    
    @IBOutlet weak var favWordLabel: UILabel!
    @IBOutlet weak var favDetailTextView: UITextView!
    @IBOutlet weak var favImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        favDetailTextView.text = getFavDetail
        self.favDetailTextView.isEditable = false
        
        favWordLabel.text = getFavWord
        
        let image = UIImage(data: getFavImageData)
        favImageView.image = image
        
        favDetailTextView.layer.borderColor = UIColor.black.cgColor
        favDetailTextView.layer.borderWidth = 2.0

        
    }
  
    @IBAction func favImageTapped(_ sender: Any) {
        performSegue(withIdentifier: "favImage", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "favImage") {
            let favImageVC: FavImageViewController = (segue.destination as? FavImageViewController)!
            
            favImageVC.favImage = getFavImageData
        }
    }
    
}
