//
//  ListViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/22.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift


class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating {
    
    
    
    var myWordList: [myWordObject] = []
    var selectWord: String!
    var selectImage: Data!
    
    var searchController = UISearchController()
    
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    
    
    
    private var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        listTableView.delegate = self
        listTableView.dataSource = self
        searchSet()
        definesPresentationContext = true
        
        
    }
    func searchSet() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    func updateSearchResults(for SearchController: UISearchController) {
        let predicate = NSPredicate(format: "wordName CONTAINS %@", searchController.searchBar.text!)
        let realm = try! Realm()
        let wordObj = realm.objects(myWordObject.self).filter(predicate)
        myWordList = []
        wordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        let realm = try! Realm()
        let wordObj = realm.objects(myWordObject.self)
        myWordList = []
        wordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListableViewCell
        cell.wordNameLabel.text = myWordList[indexPath.row].wordName
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWordList.count
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "favorite") { (action, view, completionHandler) in
            
            let realm = try! Realm()
            let favWord = realm.objects(favoriteObj.self).sorted(byKeyPath: "id", ascending: false)
            var addId: Int = 1
            if favWord.count > 0 {
                addId = favWord[0].id + 1
            }
            let addFavoWord = favoriteObj()
            addFavoWord.id = addId
            addFavoWord.favName = self.myWordList[indexPath.row].wordName
            addFavoWord.favDetail = self.myWordList[indexPath.row].wordDetail
            addFavoWord.favImage = self.myWordList[indexPath.row].imageData
            
            try! realm.write {
                realm.add(addFavoWord, update: true)
            }

            completionHandler(true)
        }
        favoriteAction.image = UIImage(named: "favorite.png")
        favoriteAction.backgroundColor = UIColor.darkGray
        


        let destructiveAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            let realm = try! Realm()
            try! realm.write {
                realm.delete(self.myWordList[indexPath.row])
            }

                completionHandler(true)
        }


        destructiveAction.image = UIImage(named: "dustBox.png")


        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction, destructiveAction])
        return configuration
    }
    func addFavData() {
        
        let realm = try! Realm()
        let favWord = realm.objects(favoriteObj.self).sorted(byKeyPath: "id", ascending: false)
        var addId: Int = 1
        if favWord.count > 0 {
            addId = favWord[0].id + 1
        }
        let addFavoWord = favoriteObj()
        addFavoWord.id = addId
        
    }
    

  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectWord = myWordList[indexPath.row].wordName
        
        selectImage = myWordList[indexPath.row].imageData
        
        
        
        performSegue(withIdentifier: "toDetailViewController", sender: myWordList[indexPath.row].wordDetail)
        
        listTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailViewController") {
            let detailVC : DetailViewController = (segue.destination as? DetailViewController)!
            detailVC.getDetail = (sender as! String)
            detailVC.getWord = selectWord
            detailVC.getImageData = selectImage
            
            
        }
    }
    
    
    
}
