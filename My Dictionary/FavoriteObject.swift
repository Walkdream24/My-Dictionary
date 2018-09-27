//
//  FavoriteObject.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/27.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class favoriteObj: Object {
    @objc dynamic var favName: String = ""
    @objc dynamic var favDetail: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var favImage = Data()
    
    override static func primaryKey() -> String {
        return "id"
        
    }
}
