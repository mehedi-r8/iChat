//
//  FeedVC.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/13/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var feedContentArray = [FeedContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedContent { (returnMessageArray) in
            self.feedContentArray = returnMessageArray.reversed()
            self.tableView.reloadData()
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedContentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? Feedcell else {
            return UITableViewCell()
        }
        let image = UIImage(named: "profileDefault")
        let feed = feedContentArray[indexPath.row]
        DataService.instance.getUserEmail(forUid: feed.senderID) { (returnUsername) in
            cell.configureCell(profileImage: image!, email: returnUsername, content: feed.content)
        }
        return cell
    }
    
    func autoDimension() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}
