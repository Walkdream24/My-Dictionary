//
//  FavoriteListViewController.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/27.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var favList: [favoriteObj] = []
    var selectFavWord: String!
    var selectFavDetail: String!
    var selectFavImage: Data!

    @IBOutlet weak var favListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favListTableView.delegate = self
        favListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let favObj = realm.objects(favoriteObj.self)
        favList = []
        favObj.forEach { (favWord) in
            favList.append(favWord)
        }
        favListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FavoriteTableViewCell
        cell.favWordNameLabel.text = favList[indexPath.row].favName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let destructiveAction = UIContextualAction(style: .destructive, title: "") { (action, view, completiton) in
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(self.favList[indexPath.row])
            }
            completiton(true)
        }
        destructiveAction.image = UIImage(named: "dustBox.png")
        
        let configuration = UISwipeActionsConfiguration(actions: [destructiveAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectFavWord = favList[indexPath.row].favName
        selectFavImage = favList[indexPath.row].favImage
        
        performSegue(withIdentifier: "toFavDetail", sender: favList[indexPath.row].favDetail)
        favListTableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toFavDetail") {
            let favDetailVC: FavoriteDetailViewController = (segue.destination as? FavoriteDetailViewController)!
            favDetailVC.getFavDetail = (sender as! String)
            favDetailVC.getFavWord = selectFavWord
            favDetailVC.getFavImageData = selectFavImage
    }
        
    }


}
