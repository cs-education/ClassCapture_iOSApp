//
//  RecordingsServiceProvider.swift
//  ClassCapture
//
//  Created by Nicholas Garfield on 20/1/16.
//  Copyright © 2016 Nicholas Garfield. All rights reserved.
//

import UIKit
import CoreData

class RecordingsServiceProvider: NSObject {
    
    func postRecording(videoData:NSData, sectionID:Int, completionHandler:(success:Bool)->Void) {
        
        print("Posting recording")
        let date = NSCalendar.currentCalendar().components([.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond], fromDate: NSDate())
        let filename = "\(sectionID)\(date.day)\(date.month)\(date.year)\(date.hour)\(date.minute)\(date.second)\(date.nanosecond)"
        
        guard let url = NSURL(string: "http://classcapture.cs.illinois.edu/api/video/\(filename).MOV") else { return }
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        let boundary = "---------------------------Boundary Line---------------------------"
        let contentTpe = "multipart/form-data; boundary=\(boundary)"
        request.addValue(contentTpe, forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        body.appendData("\r\n--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"userfile\"; filename=\"\(filename)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(videoData)
        body.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        print("Created body")
        
        request.HTTPBody = body
        request.addValue("\(body.length)", forHTTPHeaderField: "Content-Length")
        request.addValue("999", forHTTPHeaderField: "consumer-device-id")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            print("Got response")
            if error != nil {
                print("Error")
                print(error)
                completionHandler(success: false)
                return
            }
            print("\n\n\nResponse")
            print(response)
            let statusCode = (response as? NSHTTPURLResponse)!.statusCode
            print("POST Recording: \(statusCode)")
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print("JSON:\n\(json)")
            completionHandler(success: true)
        })
        task.resume()
    }
}
