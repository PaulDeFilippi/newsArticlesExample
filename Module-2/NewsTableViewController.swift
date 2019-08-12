//
//  NewsTableViewController.swift
//  Module-2
//
//  Created by Paul Defilippi on 7/12/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var articles: [Article] = [Article]()
    
    var titles: [String] = [
        "New York Yankess win again!",
        "Welcome to the Thunderdome",
        "The new Apple iWatch is amazing!",
        "Scientists dicover 20,000 year old Wooly Mammoth",
        "Today at Wimbleton",
        "Exclusive new diet pill!",
        ""
    ]

    var authors: [String] = [
        "Mary",
        "Thomas",
        "Bill",
        "Paul",
        "Alice",
        "Tom"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onArticlesReceived(notification:)), name: API.articlesReceivedNotification, object: nil)
        
        API.sharedInstance.requestArticles()

    }
    
    @objc func onArticlesReceived(notification: Notification) {
        if let articles: [Article] = notification.object as? [Article] {
            print("All Articles: \(articles)")
            
            self.articles = articles
            self.tableView.reloadData()
            
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //return titles.count - 1
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Deque a tableViewCell
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        
        // if there is no cell create one
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellIdentifier")
        }
        
//        cell!.textLabel?.text = titles[indexPath.row]
//        cell!.detailTextLabel?.text = authors[indexPath.row]
        
        let article = articles[indexPath.row]
        
        cell!.textLabel?.text = article.title
        cell!.detailTextLabel?.text = article.excerpt
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: nil)
        
        detailVC.title = titles[indexPath.row]
        detailVC.author = authors[indexPath.row]
        
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
