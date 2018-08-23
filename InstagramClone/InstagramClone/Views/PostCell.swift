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
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var postCaption: UILabel!
    
    
    var instagramPost: PFObject! {
        didSet {
            self.postImage.file = instagramPost["image"] as? PFFile
            self.postImage.loadInBackground()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
