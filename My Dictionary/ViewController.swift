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
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveBut: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordTextField.delegate = self
        detailTextField.delegate = self
        successLabel.isHidden = true
        imageView.image = UIImage(named: "default.jpg")
        saveBut.layer.cornerRadius = 10
        saveBut.layer.masksToBounds = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(true, animated: false)
        
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
    
        
        
        if addNewWord.wordName == "" {
            dismiss(animated: true, completion: nil)
            
        }
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        self.imageView.image = image
        self.dismiss(animated: true, completion:  nil)
    }
    
    
    
    
    
}



