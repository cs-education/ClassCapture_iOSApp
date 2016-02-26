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

    var videoData:NSData?
    var testValue:String?
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var selectCourseButton: UIButton!
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var selectSectionButton: UIButton!
    
    @IBOutlet var pickerView:UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = kCOLOR_ONE
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kCOLOR_TWO]
        // Do any additional setup after loading the view.
        pickerView = UIPickerView(frame: CGRectMake(0, view.bounds.height, view.bounds.width, kPICKER_VIEW_HEIGHT))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .orangeColor()
        view.addSubview(pickerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UI Actions
    @IBAction func selectCourseButtonTapped(sender: AnyObject) {
        pickerView.reloadAllComponents()
        showPickerView()
    }
    
    @IBAction func selectSectionButtonTapped(sender: AnyObject) {
        print("Select section button tapped")
        pickerView.reloadAllComponents()
        showPickerView()
    }
    
    @IBAction func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        if translation.y > translation.x {
            if translation.y > 0 {
                
            }
        }
    }
    
    
    // MARK: - PickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let realm = try! Realm()
//        switch uploadSelectionType {
//        case .Course:
//            return 0
//        case .Section:
        return 2
//            return realm.objects(Section).count
//        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let realm = try! Realm()
//        switch uploadSelectionType {
//        case .Course:
//            return "Course \(row)"
//        case .Section:
            let section = realm.objects(Section).sorted("name")[row]
            guard let name          = section.name          else { return "" }
            guard let course        = section.course        else { return "" }
            guard let department    = course.department     else { return "" }
            guard let number        = course.number.value   else { return "" }
            
            return "\(department) \(number) (\(name))"
//        }
    }
    
    // MARK: - PickerView Delegate
    func showPickerView() {
        print("Show picker view")
        
        if pickerView.frame.origin.y == view.bounds.height {
            UIView.animateWithDuration(0.3, animations: {
                self.pickerView.frame.origin = CGPointMake(0, self.view.bounds.height - kPICKER_VIEW_HEIGHT)
            })
        }
    }
    
    func hidePickerView() {
        
        if pickerView.frame.origin.y < view.bounds.height {
            UIView.animateWithDuration(0.3, animations: {
                self.pickerView.frame.origin = CGPointMake(0, self.view.bounds.height)
            })
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let title = self.pickerView(pickerView, titleForRow: row, forComponent: component) else { return }
        
//        switch uploadSelectionType {
//        case .Course:
//            selectCourseButton.setTitle(title, forState: .Normal)
//        case .Section:
            selectSectionButton.setTitle(title, forState: .Normal)
//        }
    }
    
    @IBAction func continueButtonTapped(sender: AnyObject) {
        
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
