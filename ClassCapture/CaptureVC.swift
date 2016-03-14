//
//  CaptureVC.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import MobileCoreServices

class CaptureVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet var menuButton: UIBarButtonItem!

    var model:Model?
    var menuDelegate:MenuDelegate?
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var fileImageView: UIImageView!
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var photoLibraryButton: UIButton!
    
    var videoData:NSData?
    
    var imagePicker:UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = kCOLOR_ONE
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kCOLOR_TWO]
        
        cameraImageView.image = UIImage(named: "Camera")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cameraImageView.tintColor = .blackColor()

        
        fileImageView.image = UIImage(named: "File")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        fileImageView.tintColor = .blackColor()

        
        
        imagePicker.delegate = self
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        photoLibraryButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UI Actions
    @IBAction func cameraButtonTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.mediaTypes = [String(kUTTypeMovie)]
            imagePicker.sourceType = .Camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: false, completion: nil)
        }
    }
    
    @IBAction func photoLibraryButtonTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            imagePicker.mediaTypes = [String(kUTTypeMovie)]
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        menuDelegate?.menuButtonTapped()
    }
    
    
    // MARK: - Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
//        if let mediaType = info[UIImagePickerControllerMediaType] {
//            kUTTypeMovie
//        }
        print(info)
        if let fileURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            videoData = NSData(contentsOfURL: fileURL)
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
            performSegueWithIdentifier("UploadRecordingSegue", sender: nil)
        }
    }
    


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UploadRecordingSegue" {
            guard let navVC = segue.destinationViewController as? UINavigationController else { return }
            guard let destVC = navVC.topViewController as? UploadRecordingVC else { return }

            destVC.model = model
            destVC.videoData = videoData
        }
    }
}
