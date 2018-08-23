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
    var posts : [Post] = []
    

//    @IBOutlet weak var composeButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        self.tableView.reloadData()
        fetchPosts()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func onLogout(_ sender: Any) {
//        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
//        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
//
//    }
    //    @IBAction func onLogout(_ sender: AnyObject) {
    //        PFUser.logOutInBackground { (error: Error?) in
    //            if let error = error {
    //                print("User logout failed: \(error.localizedDescription)")
    //            } else {
    //                print("User logout successful")
    //            //need to segue back to login screen
    //                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    //            }
    //        }
    //
    //    }
    
    @IBAction func onCompose(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post    = posts[indexPath.row]
        let caption = post.caption
        cell.postCaption.text = caption
        
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground(block: {(data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.postImage.image = image
                    }
                } else{
                    print(error!.localizedDescription)
                }
            })
        }
        
        return cell
    }
    
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        
        // Configure session so that completion handler is executed on main UI thread
        //let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        fetchPosts()
        // ... Use the new data to update the data source ...
        // Reload the tableView now that there is new data
        tableView.reloadData()
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    
    func fetchPosts() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (Post, error: Error?) -> Void in
            if let posts = Post {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                print("fetch failed")
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if(sender != nil) {
//
//            let cell = sender as! UITableViewCell
//            if let indexPath = tableView.indexPath(for: cell) {
//                let post = posts[indexPath.row]
//                let detailViewController = segue.destination as! DetailViewController
//                detailViewController.post = post
//
//                let postCell = sender as! PostCell
//                detailViewController.postImage = postCell.postImage.image!
//            }
//        }
//    }
}
