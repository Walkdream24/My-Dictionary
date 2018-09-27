//
//  MyWordObject.swift
//  My Dictionary
//
//  Created by 中重歩夢 on 2018/09/22.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class myWordObject: Object {
    @objc dynamic var wordName: String = ""
    @objc dynamic var wordDetail: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imageData = Data()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    
}
