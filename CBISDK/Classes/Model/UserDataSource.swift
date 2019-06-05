//
//  UserDataSource.swift
//  CBISDK
//
//  Created by Lucas Luu on 11/2/18.
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

public struct UserDataSource : Mappable {
    
    public var userID       : String!   = ""
    public var userName     : String!   = ""
    public var email        : String!   = ""
    public var avatarURL    : String?
    public var address      : String?
    public var phone        : String?
    public var shortName    : String?
    public var fullName     : String?
    public var isSublet     : Bool      = false
    public var isAdmin      : Bool      = false
    
    public init?(map: Map) {
        //
    }
    
    public mutating func mapping(map: Map) {
        userID      <- map["userUID"]
        userName    <- map["username"]
        email       <- map["email"]
        avatarURL   <- map["avatar"]
        address     <- map["address"]
        phone       <- map["phone"]
        shortName   <- map["short_name"]
        fullName    <- map["full_name"]
        isSublet    <- map["issublet"]
        isAdmin     <- map["isadmin"]
    }
}
