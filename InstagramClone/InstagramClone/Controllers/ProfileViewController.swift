//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by Teran on 8/20/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var interactionButton: UIButton!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    
    var user: PFUser! {
        didSet {
            self.title = user.username
            usernameLabel.text = user.username
        }
    }
    
    
    fileprivate func UISetup() {
        profileImageView.layer.cornerRadius  = profileImageView.layer.frame.height / 2
        interactionButton.layer.cornerRadius = 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
