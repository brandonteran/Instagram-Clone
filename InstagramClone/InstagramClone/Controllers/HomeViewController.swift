//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Teran on 8/15/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    
    
    @IBAction func LogUserOut(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                print("Error logging user out")
            }
            else {
                print("Logged out")
            }
        }
    }
    
    
    fileprivate func getUserPosts() {
        let query = PFQuery()
        query.whereKey("username", lessThan: 21)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate   = self
        postsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
}
