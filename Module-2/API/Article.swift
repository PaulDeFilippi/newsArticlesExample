//
//  Article.swift
//  Module-2
//
//  Created by Paul Defilippi on 8/9/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var thumbnailURL: String = ""
    @objc dynamic var articleURL: String = ""
    @objc dynamic var excerpt: String = ""
    @objc dynamic var creationDate: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
