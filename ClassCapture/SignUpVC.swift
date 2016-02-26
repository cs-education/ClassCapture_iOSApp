//
//  SignUpVC.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 27/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    var model:Model?
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var existingUserButton: UIButton!
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var lastNameTextField: UITextField!

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    
    var delegate:LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = kCOLOR_ONE
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kCOLOR_TWO]
        
    }
    
    
    func isSignUpDataValid() -> Bool {
        guard let model = model else { print("No model"); return false }
        guard let firstNameStr = firstNameTextField.text else { print("no first name"); return false }
        guard let lastNameStr = lastNameTextField.text else { print("no last name"); return false }
        guard let emailStr = emailTextField.text else { print("no email"); return false }
        guard let passwordStr = passwordTextField.text else { print("no password"); return false }
        
        if !model.dataValidator.isValidFirstName(firstNameStr) {
            // TODO: Send error that first name is wrong
            print("invalid first name")
            return false
        } else if !model.dataValidator.isValidLastName(lastNameStr) {
            // TODO: Send error that last name is wrong
            print("invalid last name")
            return false
        } else if !model.dataValidator.isValidEmail(emailStr) {
            // TODO: Send error that email was invalid
            print("invalid email")
            return false
        } else if !model.dataValidator.isValidPassword(passwordStr) {
            // TODO: Send error that password was invalid
            print("invalid password")
            return false
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UIActions
    @IBAction func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        if abs(translation.y) > abs(translation.x) && translation.y > 0.0 {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        if isSignUpDataValid() {
            model?.usersServiceProvider.registerNewUser(firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, completionHandler: {(success:Bool) in
                if success {
                    self.delegate?.userDidLogin(true)
                } else {
                    print("Error registering user")
                    // TODO: Show an error message to the user
                }
            })
        }
    }
    
    @IBAction func existingUserButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("ShowLogin", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowLogin" {
            guard let destVC    = segue.destinationViewController as? LoginVC else { return }
            destVC.delegate     = delegate
            destVC.model        = model
        }
    }

}
