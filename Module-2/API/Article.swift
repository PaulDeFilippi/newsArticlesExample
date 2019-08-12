//
//  Article.swift
//  Module-2
//
//  Created by Paul Defilippi on 8/9/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import Foundation

class Article: CustomStringConvertible {

    var id: Int = 0
    var title: String = ""
    var author: String = ""
    var content: String = ""
    var thumbnailURL: String = ""
    var articleURL: String = ""
    var excerpt: String = ""
    var creationDate: Date = Date()
    
    var description: String {
        return "Article: \(self.creationDate) -- \(self.title) -- \(self.articleURL)"
    }
}
