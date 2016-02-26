//
//  LoginVC.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 11/2/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var backButton: UIBarButtonItem!
    
    var delegate:LoginDelegate?
    var model:Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UI Actions
    @IBAction func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        if abs(translation.y) > abs(translation.x) && translation.y > 0.0 {
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        guard let model = model else { return }
        if model.dataValidator.isValidEmail(emailTextField.text!) {
            // TODO: Tell the model to login
            guard let email     = emailTextField.text else { return }
            guard let password  = passwordTextField.text else { return }
            model.usersServiceProvider.login(email, password: password, completionHandler: {
                (success:Bool) in
                if success {
                    self.delegate?.userDidLogin(true)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                    })
                } else {
                    print("There was an error logging in")
                    // TODO: Display error to user
                }
            })
            
        } else {
            print("email was not valid")
        }
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}

protocol LoginDelegate {
    func userDidLogin(shouldDismissLogin:Bool)
}
