//
//  User.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 1/2/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift


class User: Object {
    let id                          = RealmOptional<Int>()
    dynamic var firstName:String?   = nil
    dynamic var lastName:String?    = nil
    dynamic var email:String?       = nil
    dynamic var password:String?    = nil
    dynamic var createdAt:NSDate?   = nil
    let sections    = List<Section>()
    
//    let comments = List<Comment>()
}
