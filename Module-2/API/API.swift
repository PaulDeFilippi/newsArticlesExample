//
//  API.swift
//  Module-2
//
//  Created by Paul Defilippi on 8/9/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _API_SharedInstance = API()

class API {
    
    static let Feed_JSON_URL: URL = URL(string: "https://learnappmaking.com/feed/json")!
    
    static let articlesReceivedNotification = Notification.Name("articlesReceived")
    
    class var sharedInstance: API {
        return _API_SharedInstance
    }
    
    func requestArticles() -> Void {
        Alamofire.request(API.Feed_JSON_URL).responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    print("JSON: \(data)")
                    
                    self.processArticles(json: json)
                }
                catch {
                    print("JSON error: \(error)")
                }
            } else {
                print(response.result.error as Any)
            }
        }
    }
    
    func processArticles(json: JSON) {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        var articles: [Article] = [Article]()
        // _ is representing the 'key' but was never mutated
        for (_, item):(String, JSON) in json {
            let article = Article()
            
            if let id: Int = item["id"].int {
                article.id = id
            }
            
            if let title: String = item["title"].string {
                article.title = title
            }
            
            if let author: String = item["author"].string {
                article.author = author
            }
            
            if let excerpt: String = item["excerpt"].string {
                article.excerpt = excerpt
            }
            
            if let content: String = item["content"].string {
                article.content = content
            }
            
            if let articleURL: String = item["permalink"].string {
                article.articleURL = articleURL
            }
            
            if let thumbnailURL: String = item["thumbnail"].string {
                article.thumbnailURL = thumbnailURL
            }
            
            if  let dateString = item["date"].string,
                let creationDate = dateFormatter.date(from: dateString)
            {
                article.creationDate = creationDate
            }
            
            articles += [article]
            
        }
        
        if articles.count > 0 {
            NotificationCenter.default.post(name: API.articlesReceivedNotification, object: articles)
        }
        
        print(articles)
    }
}
