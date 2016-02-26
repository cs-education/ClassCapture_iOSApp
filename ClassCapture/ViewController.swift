//
//  ViewController.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 19/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, SideDrawerMenuDelegate, MenuDelegate, LoginDelegate {

    @IBOutlet var backgroundTintView: UIView!
    @IBOutlet var menuLeadingSpace: NSLayoutConstraint!

    @IBOutlet var menuContainer: UIView!

    @IBOutlet var captureContainer: UIView!
    @IBOutlet var sectionsContainer: UIView!
    @IBOutlet var settingsContainer: UIView!

    
    
    var settingsCom:SettingsCommunicator?
    
    var model:Model = Model()
    
    let MAX_MENU_ANIMATION_DURATION                     = 0.4
    let OPEN_MENU_LEADING_SPACE_TO_CONTAINER:CGFloat    = -UIScreen.mainScreen().bounds.width/3.0
    let CLOSED_MENU_LEADING_SPACE_TO_CONTAINER:CGFloat  = -UIScreen.mainScreen().bounds.width
    let OPEN_MENU_BLACK_TINT_VIEW_ALPHA:CGFloat         = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let realm = try! Realm()
        let users = realm.objects(User)
        let sections = realm.objects(Section)
        let courses = realm.objects(Course)
        
        try! realm.write {
            realm.delete(users)
            realm.delete(sections)
            realm.delete(courses)
        }
        */

        // Prepare the initial view hierarchy
        backgroundTintView.alpha = 0.0
        menuLeadingSpace.constant = -view.bounds.width
        
        view.bringSubviewToFront(captureContainer)
        view.bringSubviewToFront(backgroundTintView)
        view.bringSubviewToFront(menuContainer)
    }
    
    override func viewDidAppear(animated: Bool) {
        // If there is no user logged in, present the log in UI
        if !model.usersServiceProvider.isLocalUserLoggedIn() {
            performSegueWithIdentifier("PresentLoginUI", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        // Get data from the gesture recognizer
        let translation = recognizer.translationInView(view)
        let velocity = recognizer.velocityInView(view)
        
        if recognizer.state == UIGestureRecognizerState.Changed {
            
            // Move the menu horizontally with the user's finger while panning
            let targetLeadingSpaceToContainer = max(CLOSED_MENU_LEADING_SPACE_TO_CONTAINER, min(OPEN_MENU_LEADING_SPACE_TO_CONTAINER, menuLeadingSpace.constant + translation.x))
            menuLeadingSpace.constant = targetLeadingSpaceToContainer
            
            // Tint the background UI
            let targetBlackTintViewAlpha = ((CLOSED_MENU_LEADING_SPACE_TO_CONTAINER - targetLeadingSpaceToContainer) / (CLOSED_MENU_LEADING_SPACE_TO_CONTAINER - OPEN_MENU_LEADING_SPACE_TO_CONTAINER)) * OPEN_MENU_BLACK_TINT_VIEW_ALPHA
            backgroundTintView.alpha = targetBlackTintViewAlpha
            
        } else if recognizer.state == UIGestureRecognizerState.Ended {
            
            // Once the pan has ended, animate the menu fully open or close
            if velocity.x >= 0 {
                
                // If the user's finger was moving open when the pan stopped, animate open the menu
                openMenuAnimationWithVelocity(velocity.x)
                
            } else {
                
                // If the user's finger was moving close when the pan stopped, animate close the menu
                closeMenuAnimationWithVelocity(velocity.x)
            }
        }
        
        // Reset the recognizer's relative translation
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    func openMenuAnimationWithVelocity(velocity:CGFloat) {
        
        // Bring the menu to the front of the view hierarchy
        view.layoutIfNeeded()
        
        // Calculate the animation duration
        var animationDuration = min(MAX_MENU_ANIMATION_DURATION, Double((OPEN_MENU_LEADING_SPACE_TO_CONTAINER - menuLeadingSpace.constant)/velocity))
        if velocity == 0.0 {
            animationDuration = MAX_MENU_ANIMATION_DURATION
        }
        
        // Run the animation
        menuLeadingSpace.constant = OPEN_MENU_LEADING_SPACE_TO_CONTAINER
        UIView.animateWithDuration(animationDuration,
            animations: {
                self.setNeedsStatusBarAppearanceUpdate()
                self.view.layoutIfNeeded()
                self.backgroundTintView.alpha = self.OPEN_MENU_BLACK_TINT_VIEW_ALPHA
            }, completion: nil)
    }
    
    // Animate close the side menu with a given velocity
    func closeMenuAnimationWithVelocity(velocity:CGFloat) {
        
        view.layoutIfNeeded()
        
        // Calculate the animation duration
        var animationDuration = min(MAX_MENU_ANIMATION_DURATION, Double((CLOSED_MENU_LEADING_SPACE_TO_CONTAINER - menuLeadingSpace.constant)/velocity))
        if velocity == 0.0 {
            animationDuration = MAX_MENU_ANIMATION_DURATION
        }
        
        // Run the animation
        menuLeadingSpace.constant = CLOSED_MENU_LEADING_SPACE_TO_CONTAINER
        UIView.animateWithDuration(animationDuration,
            animations: {
                self.setNeedsStatusBarAppearanceUpdate()
                self.view.layoutIfNeeded()
                self.backgroundTintView.alpha = 0.0
            }, completion:  nil)
    }
    
    
    // MARK: - Side Drawer Menu Delegate
    func didSelectMenuOption(option: MenuOption) {
        switch option {
        case .Capture:
            view.insertSubview(captureContainer, belowSubview: backgroundTintView)
        case .Sections:
            view.insertSubview(sectionsContainer, belowSubview: backgroundTintView)
        case .Settings:
            view.insertSubview(settingsContainer, belowSubview: backgroundTintView)
        }
        closeMenuAnimationWithVelocity(0.0)
    }
    
    
    // MARK: - Login Delegate
    func userDidLogin(shouldDismissLogin: Bool) {
        settingsCom?.reload()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EmbedSideDrawerMenuSegue" {
            guard let destVC = segue.destinationViewController as? SideDrawerMenuVC else { return }
            destVC.delegate = self
        } else if segue.identifier == "EmbedSectionsSegue" {
            guard let navVC = segue.destinationViewController as? UINavigationController else { return }
            guard let destVC = navVC.topViewController as? SectionsVC else { return }
            settingsCom         = destVC
            destVC.menuDelegate = self
            destVC.model        = model
        } else if segue.identifier == "EmbedCaptureSegue" {
            guard let navVC = segue.destinationViewController as? UINavigationController else { return }
            guard let destVC = navVC.topViewController as? CaptureVC else { return }
            destVC.menuDelegate = self
        } else if segue.identifier == "EmbedSettingsSegue" {
            // TODO: Setup the settings menu
            
        } else if segue.identifier == "PresentLoginUI" {
            guard let navVC = segue.destinationViewController as? UINavigationController else { return }
            guard let destVC = navVC.topViewController as? SignUpVC else { return }
            destVC.model    = model
            destVC.delegate = self
        }
    }
    
    func menuButtonTapped() {
        openMenuAnimationWithVelocity(0.0)
    }
}


protocol MenuDelegate {
    func menuButtonTapped()
}

protocol SettingsCommunicator {
    func reload()
}