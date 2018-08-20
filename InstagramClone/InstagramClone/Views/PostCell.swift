//
//  PostCell.swift
//  InstagramClone
//
//  Created by Teran on 8/19/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PostCell: UITableViewCell {
    @IBOutlet weak var userImageView:        PFImageView!
    @IBOutlet weak var topUsernameButton:    CustomButton!
    @IBOutlet weak var bottomUsernameButton: CustomButton!
    @IBOutlet weak var postImageView:        PFImageView!
    @IBOutlet weak var likesCount:           UILabel!
    @IBOutlet weak var captionLabel:         UILabel!
    
    
    var post: PFObject! {
        didSet {
            userImageView.file = post["media"] as? PFFile
            postImageView.file = post["media"] as? PFFile
            
            userImageView.loadInBackground()
            postImageView.loadInBackground()
            
            captionLabel.text = post["caption"] as? String
        }
    }
    
    
    @IBAction func viewUserProfile(_ sender: CustomButton) {
        print("Clicked on username")
    }
    
    
    func setPostInfo() {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
