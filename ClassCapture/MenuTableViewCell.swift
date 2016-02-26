//
//  MenuCellTableViewCell.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 26/2/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet var indicatorViewWidth: NSLayoutConstraint!
    @IBOutlet var indicatorView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame.origin.x = bounds.size.width*(1.0/3.0)+32.0
        indicatorViewWidth.constant = bounds.size.width*(1.0/3.0)
        
        if tag == 0 {
            indicatorView.hidden = false
            textLabel?.textColor = kCOLOR_ONE
        } else {
            indicatorView.hidden = true
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
