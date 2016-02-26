//
////
////  CookieStorageService.swift
////  ClassCapture
////
////  Created by Nicholas Garfield on 26/2/16.
////  Copyright © 2016 Nicholas Garfield. All rights reserved.
////
//
//import UIKit
//
//class CookieStorage: NSObject, NSCoding, NSCopying {
//    
//    var subdomainCookies:[String:NSHTTPCookie] = [:]
//    var domainGlobalCookies:[String:NSHTTPCookie] = [:]
//    
//    func cookiesForURL(url:NSURL) -> [NSHTTPCookie] {
//        return []
//    }
//    
//    func setCookie(cookie:NSHTTPCookie) {
//        
//    }
//    
//    func reset() {
//        
//    }
//    
//    func loadCookies(cookies:[NSHTTPCookie]) {
//        for cookie in cookies {
//            setCookie(cookie)
//        }
//    }
//    
//    func handleCookiesInRequest(request:NSMutableURLRequest) {
//        let url = request.URL
//        let cookies = cookiesForURL(url)
//        let headers = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
//        
//        let count = headers.count
//        
//    }
//    
//    func handleCookiesInResponse(response:NSHTTPURLResponse) {
//        
//    }
//    
////    required init?(coder aDecoder: NSCoder) {
////        let cookieProperties = aDecoder.decodeObjectForKey("cookieProperties")
////        if cookieProperties?.isKindOfClass(Dictionary) {
////            return nil
////        }
////        self = self.ini (cookieProperties)
////        return self
////    }
////    
////    ini
////    
//}
