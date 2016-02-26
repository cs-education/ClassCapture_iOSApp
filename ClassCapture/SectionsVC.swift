//
//  SettingsVC.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

class SectionsVC: UITableViewController, SettingsCommunicator {

    @IBOutlet var menuButton: UIBarButtonItem!
    
    var model:Model?
    var menuDelegate:MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = kCOLOR_ONE
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kCOLOR_TWO]
        
        reload()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        model?.coursesServiceProvider.fetchCourses({
            (success:Bool) in
            if success {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Section).count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell", forIndexPath: indexPath)
        
        dispatch_async(GlobalBackgroundQueue, {
            let realm = try! Realm()
            let section = realm.objects(Section).sorted("name")[indexPath.row]
            guard let name          = section.name          else { return }
            guard let course        = section.course        else { return }
            guard let department    = course.department     else { return }
            guard let number        = course.number.value   else { return }
            
            dispatch_async(GlobalMainQueue, {
                cell.textLabel?.text = "\(department) \(number) (\(name))"
            })
        })
        
        return cell
    }

    // MARK: - UI Actions
    @IBAction func menuButtonTapped(sender: AnyObject) {
        menuDelegate?.menuButtonTapped()
    }
}
