//
//  Post.swift
//  InstagramClone
//
//  Created by Teran on 8/19/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import Foundation
import Parse


class Post: PFObject, PFSubclassing {
    @NSManaged var media         : PFFile
    @NSManaged var author        : PFUser
    @NSManaged var caption       : String
    @NSManaged var likesCount    : Int
    @NSManaged var commentsCount : Int
    
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = Post()
        
        // Add relevant fields to the object
        post.media         = getPFFileFromImage(image: image)!
        post.author        = PFUser.current()!
        post.caption       = caption!
        post.likesCount    = 0
        post.commentsCount = 0
        
        post.saveInBackground(block: completion)
    }
    
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        
        return nil
    }
    
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
