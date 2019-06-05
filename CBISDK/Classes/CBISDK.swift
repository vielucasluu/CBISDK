//
//  CBISDK.swift
//  Pods
//
//  Created by Lucas Luu on 3/4/19.
//
//
//  Copyright (c) 2014-2018 CB/I Digital.INC (https://www.cbidigital.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/**
CBIEngine handle any thing you need to conenct and embeded CBI Platform
 */
public class CBISDK : NSObject {
    /**
     Instance object to using SDK
     */
    public static var shareInstance = CBISDK()
    
    public override init() {
        super.init()
    }
    
    /**
     doSomtthing is test function
     */
    public func doSomething() -> NSString {
        return "The library has did something"
    }
    
    /**
    Platform ID available when you register our service. Contact our admin to create this. Check more details in : www.cbidigital.com/cbi-platform
     */
    public var platformID : String = ""
    public func setPlatformID(id:String) {
        self.platformID = id
    }
    
    // ApplicationDataHandler
    // This clas help user handle all APIs request to service
    public var appDataHandler = ApplicationDataHandler()
    public var userSessionDataSource : UserSessionDataSource?
}
