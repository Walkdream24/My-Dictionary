//
//  ViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/21.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
   
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var expansionImageLabel: UILabel!
    @IBOutlet weak var saveBut: UIButton!
    @IBOutlet weak var bkgW: UIImageView!
    @IBOutlet weak var bkgD: UIImageView!
    @IBOutlet weak var bkgP: UIImageView!
    @IBOutlet weak var viewW: UIView!
    @IBOutlet weak var viewD: UIView!
    @IBOutlet weak var viewP: UIView!
    @IBOutlet weak var viewWLabel: UILabel!
    @IBOutlet weak var viewSubWLabel: UILabel!
    @IBOutlet weak var viewWImageview: UIImageView!
    @IBOutlet weak var viewDLabel: UILabel!
    @IBOutlet weak var viewSubDLabel: UILabel!
    @IBOutlet weak var viewDImageView: UIImageView!
    @IBOutlet weak var viewPLabel: UILabel!
    @IBOutlet weak var viewSubPLabel: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var noImageLabelMain: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordTextField.delegate = self
        detailTextField.delegate = self
        successLabel.isHidden = true
        imageView.image = UIImage(named: "default.png")
        saveBut.layer.cornerRadius = 10
        saveBut.layer.masksToBounds = true
        bkgW.layer.cornerRadius = 20
        bkgW.layer.masksToBounds = true
        bkgD.layer.cornerRadius = 20
        bkgD.layer.masksToBounds = true
        bkgP.layer.cornerRadius = 20
        bkgP.layer.masksToBounds = true

    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func saveButton(_ sender: Any) {
        newWordIDAndSave()
        success()
        
    }
    
    func newWordIDAndSave() {
        let realm = try! Realm()
        let lastWord = realm.objects(myWordObject.self).sorted(byKeyPath: "id", ascending: false)
        var addId: Int = 1
        
        if lastWord.count > 0 {
            addId = lastWord[0].id + 1
        }
        
        let addNewWord = myWordObject()
        addNewWord.id = addId
        addNewWord.wordDetail = detailTextField.text!
        addNewWord.wordName = wordTextField.text!
        let value = imageView.image
        let data = value!.pngData()
        addNewWord.imageData = data!

        try! realm.write {
            realm.add(addNewWord, update: true)
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let addNewWord = myWordObject()
        addNewWord.wordName = wordTextField.text!
        addNewWord.wordDetail = detailTextField.text!
        
        wordTextField.resignFirstResponder()
        detailTextField.resignFirstResponder()
        return true
    }
    
    func success() {
        successLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.successLabel.isHidden = true
        }
    }
    
    @IBAction func sendImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true)
        }
    }
    @IBAction func noImageButton(_ sender: Any) {
        imageView.image = UIImage(named: "noImagepic.jpg")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        self.imageView.image = image
        self.dismiss(animated: true, completion:  nil)
    }
    
    @IBAction func homeImageTapped(_ sender: Any) {
        performSegue(withIdentifier: "image", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "image") {
            let homeImageVC: HomeImageViewController = (segue.destination as? HomeImageViewController)!
            let value = imageView.image
            let data = value!.pngData()
            homeImageVC.getHomeImageData = data
        }
    }
    
    
    
}



