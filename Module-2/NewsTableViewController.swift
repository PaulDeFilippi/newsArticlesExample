//
//  NewsTableViewController.swift
//  Module-2
//
//  Created by Paul Defilippi on 7/12/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit
import RealmSwift

class NewsTableViewController: UITableViewController {

    var articles: Results<Article> {
        get {
            let realm = try! Realm()
            
            return realm.objects(Article.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onArticlesReceived(notification:)), name: API.articlesReceivedNotification, object: nil)
        
        API.sharedInstance.requestArticles()

    }
    
    @objc func onArticlesReceived(notification: Notification) {
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Deque a tableViewCell
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        
        // if there is no cell create one
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellIdentifier")
        }
        
        let article = articles[indexPath.row]
        
        cell!.textLabel?.text = article.title
        cell!.detailTextLabel?.text = article.excerpt
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: nil)
        
        detailVC.article = articles[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
