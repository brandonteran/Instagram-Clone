//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Teran on 8/15/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var postsTableView: UITableView!
    
    
    var posts     : [Post] = []
    var raw_posts : [PFObject] = []
    
    
    @IBAction func LogUserOut(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                print("Error logging user out")
            }
            else {
                print("Logged out")
                self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
            }
        }
    }
    
    
    fileprivate func getUserPosts(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) -> Void {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print("Posts are: ", posts)
                // do something with the data fetched
                self.raw_posts = posts
                completion(true, nil)
                
            } else {
                print("Error! : ", error?.localizedDescription ?? "No localized description for error")
                // handle error
                completion(false, error)
            }
            self.postsTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate   = self
        postsTableView.dataSource = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        activityIndicator.startAnimating()
        
        getUserPosts(completion: {(success: Bool, error: Error?) -> Void in
//            self.activityIndicator.stopAnimating()
            
            if success {
                print ("successfully received data")
                
            } else {
                print (error?.localizedDescription ?? "no error")
            }
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.raw_posts.count != 0 {
            return self.raw_posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.post = self.raw_posts[indexPath.row]
        return cell
    }
}
