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
            var post: PFObject! {
                didSet {
                    userImageView.file = post["media"] as? PFFile
                    userImageView.loadInBackground()
                    
                    topUsernameButton.setTitle((post["author"] as? PFUser)?.username, for: .normal)
                    bottomUsernameButton.setTitle((post["author"] as? PFUser)?.username, for: .normal)
//                    locationLabel.text = post["location"] as? String
                    
                    postImageView.file = post["media"] as? PFFile
                    self.postImageView.loadInBackground()
                    
//                    likeButtonImageView.image        = #imageLiteral(resourceName: "favor-icon")
//                    commentButtonImageView.image     = #imageLiteral(resourceName: "comment-icon")
//                    offlineSaveButtonImageView.image = #imageLiteral(resourceName: "offline-save-icon")
                    likesCount.text   = post["likesCount"] as? String
                    captionLabel.text = post["caption"]    as? String
                }
            }
        }
    }
    
    
    @IBAction func viewUserProfile(_ sender: CustomButton) {
        print("Clicked on username")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
