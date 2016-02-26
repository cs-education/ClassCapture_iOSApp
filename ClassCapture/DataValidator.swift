//
//  DataValidator.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 27/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit

class DataValidator: NSObject {
    
    func isValidEmail(str:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(str)
    }
    
    let kMIN_PASSWORD_LENGTH = 8
    func isValidPassword(str:String) -> Bool {
        return str.characters.count >= kMIN_PASSWORD_LENGTH
    }
    
    let kMIN_FIRST_NAME_LENGTH = 1
    func isValidFirstName(str:String) -> Bool {
        return str.characters.count >= kMIN_FIRST_NAME_LENGTH
    }
    
    let kMIN_LAST_NAME_LENGTH = 2
    func isValidLastName(str:String) -> Bool {
        return str.characters.count >= kMIN_LAST_NAME_LENGTH
    }
}
