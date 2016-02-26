//
//  Section.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class Section: Object {
    
    let id = RealmOptional<Int>()
    dynamic var echo360UUID:String?
    dynamic var name:String?
    dynamic var updatedAt:NSDate?
    dynamic var course:Course?
    
//        let isRegistered:RealmOptional<Bool> =  RealmOptional<Bool>()

}
