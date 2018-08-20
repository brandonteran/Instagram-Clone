//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Teran on 8/13/18.
//  Copyright © 2018 Brandon Teran. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func signup(username: String, password : String) {
        let newUser = PFUser()
        newUser.username = username
        newUser.password = password
        
        newUser.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                // Sign up was unsuccessful. Show alert and ask user to try again
                
                let errorString = error.localizedDescription
                let alertController = UIAlertController(title: "Error Signing Up. Try again", message: errorString, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {
                    (action) in
                })
                
                alertController.addAction(okAction)
                
                self.activityIndicator.stopAnimating()
                self.present(alertController, animated: true)
            }
            else {
                // Sign up was successful. Take user to home page
                
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
    
    
    func login(username: String, password: String) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                // User account exists. Take user to home page
                
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            else {
                // User login was unsuccessful. Show alert and ask user to try again
                let errorMessage = error?.localizedDescription
                let alertController = UIAlertController(title: "Error Signing Up. Try again", message: errorMessage, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in })
                
                alertController.addAction(okAction)
                
                self.activityIndicator.stopAnimating()
                self.present(alertController, animated: true)
            }
        }
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        activityIndicator.startAnimating()
        let username = usernameTextField.text! as String
        let password = passwordTextField.text! as String

        if username != "" && password != ""{
            signup(username: username, password: password)
        }
        else {
            let alertController = UIAlertController(title: "Error Signing Up", message: "Please enter a valid email and password", preferredStyle: .alert)

            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in })

            alertController.addAction(okButton)

            present(alertController, animated: true)
        }
    }
    
    
    
    @IBAction func signIn(_ sender: Any) {
        activityIndicator.startAnimating()
        
        let username = usernameTextField.text! as String
        let password = passwordTextField.text! as String
        
        if username != "" && password != "" {
            login(username : username, password: password)
        }
        else {
            let alertController = UIAlertController(title: "Error Signing In", message: "Please enter a valid email and password", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in
            })
            
            alertController.addAction(okButton)
            
            present(alertController, animated: true)
        }
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//extension UIViewController {
//    class func displaySpinner(onView : UIView) -> UIView {
//        let spinnerView = UIView.init(frame: onView.bounds)
//        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//
//        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
//        ai.startAnimating()
//        ai.center = spinnerView.center
//
//        DispatchQueue.main.async {
//            spinnerView.addSubview(ai)
//            onView.addSubview(spinnerView)
//        }
//
//        return spinnerView
//    }
//
//    class func removeSpinner(spinner :UIView) {
//        DispatchQueue.main.async {
//            spinner.removeFromSuperview()
//        }
//    }
//}
