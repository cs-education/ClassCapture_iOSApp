//
//  UploadRecordingVC.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

private let kPICKER_VIEW_HEIGHT:CGFloat = 300.0

class UploadRecordingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var model:Model?
    var videoData:NSData?
    var testValue:String?
    var selectedSectionID:Int?
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var selectCourseButton: UIButton!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var selectSectionButton: UIButton!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var loadingIcon: UIImageView!
    
    @IBOutlet var sectionPickerView:UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = kCOLOR_ONE
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kCOLOR_TWO]
        cancelButton.tintColor = .whiteColor()
        
        // Do any additional setup after loading the view.
        sectionPickerView = UIPickerView(frame: CGRectMake(0, view.bounds.height, view.bounds.width, kPICKER_VIEW_HEIGHT))
        sectionPickerView.delegate = self
        sectionPickerView.dataSource = self
        view.addSubview(sectionPickerView)
        
        loadingView.alpha = 0.0
        loadingView.backgroundColor = kCOLOR_ONE
        view.sendSubviewToBack(loadingView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UI Actions
    @IBAction func selectCourseButtonTapped(sender: AnyObject) {
        sectionPickerView.reloadAllComponents()
        showPickerView()
    }
    
    @IBAction func selectSectionButtonTapped(sender: AnyObject) {
        sectionPickerView.reloadAllComponents()
        showPickerView()
    }
    
    @IBAction func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        if translation.y > translation.x {
            if translation.y > 0 {
                hidePickerView()
            }
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.topViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - PickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Section).count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let realm = try! Realm()
        let section = realm.objects(Section).sorted("name")[row]
        guard let name          = section.name          else { return "" }
        guard let course        = section.course        else { return "" }
        guard let department    = course.department     else { return "" }
        guard let number        = course.number.value   else { return "" }
        return "\(department) \(number) (\(name))"
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48.0
    }
    
    // MARK: - PickerView Delegate
    func showPickerView() {
        UIView.animateWithDuration(0.3, animations: {
            self.sectionPickerView.frame.origin = CGPointMake(0, self.view.bounds.height - kPICKER_VIEW_HEIGHT)
        })
    }
    
    func hidePickerView() {
        UIView.animateWithDuration(0.3, animations: {
            self.sectionPickerView.frame.origin = CGPointMake(0, self.view.bounds.height)
        })
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let title = self.pickerView(sectionPickerView, titleForRow: row, forComponent: component) else { return }
        selectSectionButton.setTitle(title, forState: .Normal)
        
        let realm = try! Realm()
        selectedSectionID = realm.objects(Section).sorted("name")[row].id.value
    }
    
    func spinLoadingIcon() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = 2.0
        rotateAnimation.repeatCount = Float(CGFloat.max)
        loadingIcon.layer.addAnimation(rotateAnimation, forKey: nil)
    }
    
    @IBAction func continueButtonTapped(sender: AnyObject) {
        hidePickerView()
        view.bringSubviewToFront(loadingView)
        spinLoadingIcon()
        
        UIView.animateWithDuration(0.5, animations: {
            self.loadingView.alpha = 1.0
        })
        
        guard let videoData = videoData else { return }
        guard let sectionID = selectedSectionID else { return }
        model?.recordingsServiceProvider.postRecording(videoData, sectionID: sectionID, completionHandler: {
            (success:Bool) in

            
            dispatch_async(GlobalMainQueue, {
                UIView.animateWithDuration(0.5, animations: {
                    self.loadingView.alpha = 0.0
                    }, completion: {
                        (complete:Bool) in
                        if complete {
                            self.view.sendSubviewToBack(self.loadingView)
                        }
                })
            })
            
            if success {
                print("Success posting video")
                self.navigationController?.topViewController?.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print("Error posting recording")
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
