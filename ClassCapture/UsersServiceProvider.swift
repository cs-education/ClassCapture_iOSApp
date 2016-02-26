//
//  UsersServiceProvider.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 27/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

class UsersServiceProvider: NSObject {
    
    func isLocalUserLoggedIn() -> Bool {
        return getLocalUser() != nil
    }
    
    func getLocalUser() -> User? {
        let userID = NSUserDefaults.standardUserDefaults().integerForKey("userID")
        let result:Results<User> = try! Realm().objects(User).filter("id == \(userID)")
        guard let user = result.first else { return nil }
        return user
    }

    func registerNewUser(firstName:String, lastName:String, email:String, password:String, completionHandler:(success:Bool)->Void) {
        
        guard let url = NSURL(string: "http://classcapture.cs.illinois.edu/api/user/register") else { return }
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"

        let params = ["firstName":firstName, "lastName":lastName, "email":email, "password":password]

        do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("999", forHTTPHeaderField: "consumer-device-id")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {
                (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                self.loginHandler(data, response: response, error: error, completionHandler: completionHandler)
            })
            task.resume()
        } catch {
            print("Could not create parameters")
        }
    }
    
    func login(email:String, password:String, completionHandler:(success:Bool)->Void) {
        
        NSHTTPCookieStorage.sharedHTTPCookieStorage().cookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always
        
        guard let url = NSURL(string: "http://classcapture.cs.illinois.edu/api/user/login") else { return }
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
    
        let params = ["email":email, "password":password]
        
        do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("999", forHTTPHeaderField: "consumer-device-id")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {
                (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                self.loginHandler(data, response: response, error: error, completionHandler: completionHandler)
            })
            task.resume()
        } catch {
            print("Could not create parameters")
        }
    }
    
    private func loginHandler(data:NSData?, response:NSURLResponse?, error:NSError?, completionHandler:(success:Bool)->Void) {
        
        if error != nil {
            completionHandler(success: true)
        }
        
        let httpResponse = response as? NSHTTPURLResponse
        let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(httpResponse!.allHeaderFields as! [String:String], forURL: response!.URL!)
        
//        if let cs = httpResponse!.allHeaderFields["Set-Cookie"] {
//            print(cs)
//        }
//        NSUserDefaults.standardUserDefaults().setObject(, forKey: <#T##String#>)
        NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: response!.URL!, mainDocumentURL: nil)

        
        do {
            // Parse JSON response
            guard let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] else { return }
            
//            var cookiesJson:[[String:AnyObject]] = []
//            var newCookies:[NSHTTPCookie] = []
//            for cookie in cookies {
//                var properties = cookie.properties
//                if properties != nil {
//                    properties!["Discard"] = false
//                    if let newCookie = NSHTTPCookie(properties: properties!) {
//                        newCookies += [newCookie]
//                    }
//                }
//            }
//            let cookiesData = try NSJSONSerialization.dataWithJSONObject(cookiesJson, options: [])
//            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(newCookies, forURL: response!.URL!, mainDocumentURL: nil)
            

//            NSUserDefaults.standardUserDefaults().setObject(cookiesData, forKey: "cookiesData")
//            NSUserDefaults.standardUserDefaults().synchronize()
            
//            print(json)
            
            guard let u_email       = json["email"]       as? String        else { return }
            guard let u_firstName   = json["firstName"]   as? String        else { return }
            guard let u_id          = json["id"]          as? Int           else { return }
            guard let u_lastName    = json["lastName"]    as? String        else { return }
            // guard let u_sections    = json["sections"]    as? [AnyObject]   else { return }
            // guard let u_comments    = json["comments"]    as? [AnyObject]   else { return }
            
            
            // Create new user
            let realm = try! Realm()
            let user = User()
            user.id.value   = u_id
            user.firstName  = u_firstName
            user.lastName   = u_lastName
            user.email      = u_email
            try! realm.write { realm.add(user) }
            NSUserDefaults.standardUserDefaults().setInteger(u_id, forKey: "userID")
            NSUserDefaults.standardUserDefaults().synchronize()
            completionHandler(success: true)
            
        } catch {
            print("Error reading data from server")
            completionHandler(success: false)
        }
    }
}
