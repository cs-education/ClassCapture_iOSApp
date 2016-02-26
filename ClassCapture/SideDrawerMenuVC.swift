//
//  SideDrawerMenuVC.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 19/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit

enum MenuOption:String {
    case Capture = "Capture"
    case Sections = "Sections"
    case Settings = "Settings"
}

class SideDrawerMenuVC: UITableViewController {
    
    let standardMenuOptions:[MenuOption] = [.Capture, .Sections, .Settings]
    var delegate:SideDrawerMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - TableView Data Source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standardMenuOptions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuOptionCell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel?.text = standardMenuOptions[indexPath.row].rawValue
        
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    
    
    // MARK: - TableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        delegate?.didSelectMenuOption(standardMenuOptions[indexPath.row])
        
        for i in 0..<tableView.numberOfRowsInSection(indexPath.section) {
            guard let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as? MenuTableViewCell else { return }
            if indexPath.row != i {
                cell.indicatorView.hidden   = true
                cell.textLabel?.textColor   = .blackColor()
            } else {
                cell.indicatorView.hidden   = false
                cell.textLabel?.textColor   = kCOLOR_ONE
            }
        }
    }
}


protocol SideDrawerMenuDelegate {
    func didSelectMenuOption(option:MenuOption)
}