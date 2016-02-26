//
//  Course.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

class Course: Object {
    
    let id = RealmOptional<Int>()
    dynamic var department:String?
    let number = RealmOptional<Int>()
    dynamic var semester:String?
    dynamic var createdAt:NSDate?
    dynamic var updatedAt:NSDate?
    let year = RealmOptional<Int>()
    let sections = List<Section>()
    
}
