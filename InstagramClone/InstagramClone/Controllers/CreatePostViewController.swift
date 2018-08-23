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
import Toucan


class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionText: UITextField!
    let imagePC = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePC.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let resizedImage = Toucan.Resize.resizeImage(originalImage, size: CGSize(width: 414, height: 414))
        imageView.image = resizedImage
        imageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTap(_ sender: AnyObject) {
        print("tap")
        imagePC.allowsEditing = true
        imagePC.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePC, animated: true, completion: nil)
    }
    
    
    @IBAction func onCancel(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "CancelSegue", sender: nil)
    }
    
    
    @IBAction func onShare(_ sender: AnyObject) {
        Post.postUserImage(image: imageView.image, withCaption: captionText.text){ (success, error) in
            if success {
                print("post successful")
                self.performSegue(withIdentifier: "SubmitSegue", sender: nil)
                
            }
            else if let e = error as NSError? {
                print (e.localizedDescription)
            }
        }
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
