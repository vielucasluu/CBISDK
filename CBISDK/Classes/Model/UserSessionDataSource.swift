//
//  SessionDataSource.swift
//  Alamofire
//
//  Created by Lucas Luu on 12/7/18.
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
import ObjectMapper

public struct UserSessionDataSource: Mappable {
    
    public var user        : UserDataSource?
    public var wallet      : NSDictionary?
    public var platform    : NSDictionary?
    public var deviceId    : String?
    public var expried     : Double!
    public var tokenKey    : String!
    
    
    public init?(map: Map) {
        //
    }
    
    public mutating func mapping(map: Map) {
        user        <- map["user"]
        wallet      <- map["wallet"]
        platform    <- map["platform"]
        deviceId    <- map["device_id"]
        expried     <- map["exp"]
        tokenKey    <- map["jwt"]
    }
    
    
}
