//
//  CreatePostViewController.swift
//  InstagramClone
//
//  Created by Teran on 8/20/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class CreatePostViewController: UIViewController {
    @IBOutlet weak var postImageView     : UIImageView!
    @IBOutlet weak var captionTextField  : UITextField!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    
    var postImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.image = postImage
        print("Loaded image")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(uploadPost))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func uploadPost() -> Void {
        activityIndicator.startAnimating()
        
        Post.postUserImage(image: postImage, withCaption: captionTextField.text, withCompletion: { (success: Bool, error: Error?) -> Void in
            DispatchQueue.main.async {
                self.postImageView.image = nil
                self.captionTextField.text = nil
                self.activityIndicator.stopAnimating()
            }}
        )
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
