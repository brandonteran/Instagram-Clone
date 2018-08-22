//
//  ChooseFromAlbumViewController.swift
//  InstagramClone
//
//  Created by Teran on 8/21/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ChooseFromAlbumViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.selectedImage = editedImage
        self.performSegue(withIdentifier: "PostSegue", sender: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: { () -> Void in
            self.dismiss(animated: false, completion: nil)
            self.tabBarController?.selectedIndex = 0
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostSegue" {
            let createPostViewController = segue.destination as! CreatePostViewController
            let size = CGSize(width: 300.0, height: 300.0)
            self.selectedImage = Post.resize(image: self.selectedImage!, newSize: size)
            createPostViewController.postImage = self.selectedImage!
        }
    }
    
    
    
    
    
    
    
    
    
}
