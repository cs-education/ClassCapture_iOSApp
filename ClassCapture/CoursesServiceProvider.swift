//
//  CoursesServiceProvider.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import RealmSwift

class CoursesServiceProvider: NSObject {
    func fetchCourses(completionHandler:(success:Bool)->Void) {

        // Delete all existing cached courses
        let realm = try! Realm()
        let cachedCourses = realm.objects(Course)
        try! realm.write {
            realm.delete(cachedCourses)
        }
        
        
        guard let url = NSURL(string: "http://classcapture.cs.illinois.edu/api/course/") else { return }
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        guard let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: "http://classcapture.cs.illinois.edu")!) else { return }
//        guard let cookiesData = NSUserDefaults.standardUserDefaults().objectForKey("cookiesData") as? NSData else { print("No stored cookies data"); return }
//        guard let cookies = try! NSJSONSerialization.JSONObjectWithData(cookiesData, options: []) as? [NSHTTPCookie] else { print("JSONifying cookies header failed"); return }
        
        let headers = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
        print("\n\n\(headers)\n\n")
        
        request.allHTTPHeaderFields = headers
        request.addValue("999", forHTTPHeaderField: "consumer-device-id")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            print("Response from task")
            
            if error != nil {
                print("Server returned an error: \(error)")
                completionHandler(success: false)
                return
            }
            
            let statusCode = (response as? NSHTTPURLResponse)!.statusCode
            print("Catching status code \(statusCode)")
            print(response)
            
            let realm = try! Realm()
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(json)
                guard let courses = json as? [[String:AnyObject]] else { return }
                for course in courses {
                    // guard let createdAtStr  = course["createdAt"] as? String else { return }
                    guard let department    = course["department"] as? String else { return }
                    guard let id            = course["id"] as? Int else { return }
                    guard let number        = course["number"] as? Int else { return }
                    guard let sections      = course["sections"] as? [[String:AnyObject]] else { return }
                    guard let semester      = course["semester"] as? String else { return }
                    // guard let updatedAtStr  = course["updatedAt"] as? String else { return }
                    guard let year          = course["year"] as? Int else { return }
                    
                    let course = Course()
                    course.department = department
                    course.id.value = id
                    course.number.value = number
                    course.semester = semester
                    course.year.value = year
                    
                    try! realm.write {
                        realm.add(course)
                    }
                    
                    for section in sections {
//                        guard let courseID = section["course"] as? Int else { return }
                        let echo360UUID = section["echo360UUID"] as? String
                        guard let sectionID = section["id"] as? Int else { return }
                        guard let name = section["name"] as? String else { return }
                        
                        let section = Section()
                        section.course = course
                        section.id.value = sectionID
                        section.echo360UUID = echo360UUID
                        section.name = name
                        
                        try! realm.write {
                            realm.add(section)
                        }
                    }
                }
                
                
                // Return success
                print("Return success")
                completionHandler(success: true)
                
            } catch {
                print("Error getting reading data from server")
                completionHandler(success: false)
            }
        })
        print("Resuming task")
        task.resume()
        
    }
    
//    func queryForSections(context:NSManagedObjectContext, completionHandler:(success:Bool, sections:[Section])->Void) {
//        
//        print("Querying for sections")
//        let fetchRequest = NSFetchRequest(entityName: "Section")
//        do {
//            guard let fetchedSections = try context.executeFetchRequest(fetchRequest) as? [Section] else {
//                dispatch_async(dispatch_get_main_queue(), {
//                    completionHandler(success: false, sections: [])
//                })
//                return
//            }
//            if fetchedSections.count > 0 {
//                dispatch_async(dispatch_get_main_queue(), {
//                    completionHandler(success: true, sections: fetchedSections)
//                })
//                return
//            }
//        } catch {
//            dispatch_async(dispatch_get_main_queue(), {
//                completionHandler(success: false, sections: [])
//            })
//            return
//        }
//        
//        guard let url = NSURL(string: "http://classcapture.cs.illinois.edu/api/section/") else { return }
//        let request = NSMutableURLRequest(URL: url)
//        let session = NSURLSession.sharedSession()
//        request.HTTPMethod = "GET"
//        
//        print("Creating task")
//        
//        let task = session.dataTaskWithRequest(request, completionHandler: {(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
//            print("Response from task")
//            
//            if error != nil {
//                print("Server returned an error: \(error)")
//                dispatch_async(dispatch_get_main_queue(), {
//                    completionHandler(success: false, sections: [])
//                })
//                return
//            }
//            
//            let statusCode = (response as? NSHTTPURLResponse)!.statusCode
//            print("Catching status code \(statusCode)")
//            print(response)
//            
//            do {
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
//                print(json)
//                
//                // Return success
//                print("Return success")
//                dispatch_async(dispatch_get_main_queue(), {
//                    completionHandler(success: true, sections: [])
//                })
//                
//            } catch {
//                print("Error getting reading data from server")
//                dispatch_async(dispatch_get_main_queue(), {
//                    completionHandler(success: false, sections: [])
//                })
//            }
//        })
//        print("Resuming task")
//        task.resume()
//
//    }
}
