//
//  MatchesTableViewController.swift
//  BitDate
//
//  Created by User  on 2015-09-08.
//  Copyright (c) 2015 Wub.com. All rights reserved.
//

import UIKit

class MatchesTableViewController: UITableViewController {

    
    var matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.titleView = UIImageView(image: UIImage(named: "chat-header"))
//        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToPreviousVC:")
//        navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "chat-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToPreviousVC:")
        navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
        fetchMatches({
            matches in
            self.matches = matches
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goToPreviousVC(button: UIBarButtonItem) {
        pageController.goToPreviousVC()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return matches.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        // Configure the cell...
        let user = matches[indexPath.row].user
        cell.nameLabel.text = user.name
        user.getPhoto({
            image in
            cell.avatarImageView.image = image
        })
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = ChatViewController()
        vc.recipient = matches[indexPath.row].user
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
