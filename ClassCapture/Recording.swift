//
//  Recording.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

class Recording: Object {

    dynamic var recordingID:String?
    dynamic var fileName:String?
    dynamic var section:String?
    dynamic var startTime:NSDate?
    dynamic var endTime:NSDate?
    dynamic var dateCreated:NSDate?
    dynamic var dateLastModified:NSDate?
    
}
