//
//  DetailViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/22.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.


import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var getWord: String!
    var getDetail: String!
    var getImageData: Data!
    var getId: Int!
   
    
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.text = getDetail
        self.detailTextView.isEditable = false
        wordLabel.text = getWord
        let image = UIImage(data: getImageData)
        detailImage.image = image
        
        detailTextView.layer.borderColor = UIColor.black.cgColor
        detailTextView.layer.borderWidth = 2.0
        
        let keyboardToorBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyboardToorBar.barStyle = UIBarStyle.default
        keyboardToorBar.sizeToFit()
   
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let endButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.endTapped))
        keyboardToorBar.items = [spacer, endButton]
        detailTextView.inputAccessoryView = keyboardToorBar
        
    }
    @objc func endTapped() {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func tapImageButton(_ sender: Any) {
        performSegue(withIdentifier: "image", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "image") {
            let ImageVC: ImageViewController = (segue.destination as? ImageViewController)!
            
            ImageVC.getImage = getImageData
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Edit", message: "編集が可能です", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        self.present(alert, animated: true, completion: nil)
        detailTextView.isEditable = true
    }
    
    @IBAction func updateButton(_ sender: Any) {
        
        detailTextView.isEditable = false
        let realm = try! Realm()
        let editObj = myWordObject()
        editObj.wordName = getWord
        editObj.imageData = getImageData
        editObj.wordDetail = detailTextView.text
        editObj.id = getId
        try! realm.write {
            realm.add(editObj, update: true)
        }
        let alert = UIAlertController(title: "Update", message: "編集を更新しました", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        
        self.present(alert, animated: true, completion: nil)
        }
      
   
      
}
