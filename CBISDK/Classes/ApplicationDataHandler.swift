//
//  ApplicationDataHandler.swift
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
import Alamofire
import ObjectMapper

/**
 Clas ussing Alamofire 4.7, ObjectMapper to manage RESTFull Request APIs
 */
public class ApplicationDataHandler: NSObject {
    
    public var userSessionDataSource : UserSessionDataSource?
    
    public override init() {
        super.init()
    }
    
    // varicable engine is way to get details services
    // var engine:CBIEngine!
    
    //Base URL are main server to connect our Platform
    var userServiceBaseURL : String = "206.189.90.11:8000/user-service/"
    
    /**
     Make Request URL from endpoint
     
     - author: Lucas Luu
     - version: 1.0.0
     - important: endpoint String can not be empty
     - parameter endpoint: The endpoint string
     - returns: a full string of URL request, not include parameter or body
     */

    private func getUserServiceURL(endpoint:String) -> String {
        
        let returnStr = self.userServiceBaseURL.appending(endpoint)
        return returnStr
        
    }
    
    //MARK: FLOW USER AUTHORIZED
    
    /**
     Sign up request with minimum required
     
     - author: Lucas Luu:
     - version: Version of APIs : 0.0.1
     - parameter username:      Required: The user name has using to login.
     - parameter password:      Required: The password has checked strength
     - parameter email:         Required: The email has register with system, We using this to verify user.
     - parameter completion:    Required: The user with data, if fail to request it will be return nill
     */
    public func signUp(username:    String,
                       password:    String,
                       platformName:String,
                       email:       String,
                       completion: @escaping (_ user: UserSessionDataSource) -> ()) -> Void {
        let parameters: Parameters = ["username": username,
                                      "password": password,
                                      "platform_name": "iOS",
                                      "email": email]
        
        let requestURL = self.getUserServiceURL(endpoint: "user/signup")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let dataDict = jsonDict.object(forKey: "data") as! NSDictionary? else {return}
                                self.userSessionDataSource = Mapper<UserSessionDataSource>().map(JSON: dataDict as! [String : Any])!
                                completion(self.userSessionDataSource!)
                                
                            case .failure(_):
                                print(response.result.error as Any)
                                break
                            }
        }
    }
    
    /**
     Sign up request with full profile
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:      Required: Mobile/FE platform self-defined username format, without special characters
     - parameter password:      Required: Mobile/FE platform self-defined password format
     - parameter email:         Required: The email has register with system, We using this to verify user.
     - parameter fullName:      Optional
     - parameter shortName:     Optional
     - parameter address:       Optional
     - parameter birthday:      Optional: datetime format : YYYY-MM-DD
     - parameter phone:         Optional
     - parameter gender:        Optional: Int : FEMALE = 0 MALE = 1
     - parameter socialId:      Optional: Use in case of sign up social like facebook, google
     - parameter decs:          Optional
     - parameter completion:    The user with data, if fail to request it will be return nill
     */
    public func signUp(username:    String,
                       password:    String,
                       email:       String,
                       fullName:    String,
                       shortName:   String,
                       address:     String,
                       birthday:    String,
                       phone:       String,
                       avatar:      String,
                       gender:      Bool,
                       socialId:    Int,
                       regionId:    Int,
                       decs:        String,
                       completion: @escaping (_ user: UserSessionDataSource) -> ()) -> Void {
        let parameters: Parameters = ["username": username,
                                      "password": password,
                                      "email": email,
                                      "full_name":fullName,
                                      "short_name":shortName,
                                      "birth_day":birthday,
                                      "phone":phone,
                                      "avatar": avatar,
                                      "address":address,
                                      "gender":Int(truncating: NSNumber(value: gender)),
                                      "social_id":socialId,
                                      "region_id":regionId,
                                      "decs":decs,
                                      "platform_name": "iOS"]
        
        let requestURL = self.getUserServiceURL(endpoint: "user/signup")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let dataDict = jsonDict.object(forKey: "data") as! NSDictionary? else {return}
                                self.userSessionDataSource = Mapper<UserSessionDataSource>().map(JSON: dataDict as! [String : Any])!
                                completion(self.userSessionDataSource!)
                                
                            case .failure(_):
                                print(response.result.error as Any)
                                break
                            }
        }
    }
    
    /**
     Sign in  request
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:   Required: The user name has using to login.
     - parameter password:   Required: The password has checked strength
     - parameter completion: Required: The user with data, if fail to request it will be return nill
     */
    public func signIn(username:String,
                       password:String,
                       completion: @escaping (_ user: UserSessionDataSource) -> ()) {
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        let parameters = ["username": username,
                          "password": password,
                          "platform_name": "iOS",
                          "device_id": deviceID]
        
        let requestURL = self.getUserServiceURL(endpoint: "user/login")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let dataDict = jsonDict.object(forKey: "data") as! NSDictionary? else {return}
                                self.userSessionDataSource = Mapper<UserSessionDataSource>().map(JSON: dataDict as! [String : Any])!
                                completion(self.userSessionDataSource!)
                                break
                                
                            case .failure(_):
                                print(response.result.error as Any)
                                break
                            }
        }
    }
    #warning("END_FEATURE_READY")
    /*
    
    //MARK: FLOW TO EDIT PROFILE USER
    
    /**
     Update User Profile, required logged user
     
     - author: Lucas Luu
     - version: 1.0.0
     
     - parameter username:      Required: Mobile/FE platform self-defined username format, without special characters
     - parameter password:      Required: Mobile/FE platform self-defined password format
     - parameter email:         Required: The email has register with system, We using this to verify user.
     - parameter fullName:      Optional
     - parameter address:       Optional
     - parameter shortName:     Optional
     - parameter birthday:      Optional: datetime format : YYYY-MM-DD
     - parameter phone:         Optional
     - parameter gender:        Optional: Int : FEMALE = 0 MALE = 1
    */
    public func updateUserProfile(username:     String,
                                  password:     String,
                                  email:        String,
                                  fullName:     String,
                                  address:      String,
                                  shortName:    String,
                                  birthday:     String,
                                  phone:        String,
                                  gender:       Int,
                                  completion: @escaping (_ user: UserSessionDataSource) -> ()) {
        guard let tokenKey = userSessionDataSource?.tokenKey else {return}
        let headers = ["Authorization" : String(format: "Bearer %@", tokenKey)]
        
        let parameters = ["username": username,
                          "password": password,
                          "email":email,
                          "full_name":fullName,
                          "address":address,
                          "short_name":shortName,
                          "birth_day":birthday,
                          "phone":phone,
                          "gender":Int(truncating: NSNumber(value: gender)),
                          "platform_name": "iOS"] as [String : Any]
        
        let requestURL = self.getRequestURL(endpoint: "auth/updateuserprofiles")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let dataDict = jsonDict.object(forKey: "data") as! NSDictionary? else {return}
                                self.userSessionDataSource = Mapper<UserSessionDataSource>().map(JSON: dataDict as! [String : Any])!
                                completion(self.userSessionDataSource!)
                                break
                                
                            case .failure(_):
                                print(response.result.error as Any)
                                break
                            }
        }
        
    }
    
    /**
     Get user profiles
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:   Required: The user name has using to login.
     - parameter password:   Required: The password has checked strength
     - parameter completion: Required: The user with data, if fail to request it will be return nill
     */
    public func getUserProfile(username:String,
                               password:String,
                               completion: @escaping (_ user: UserSessionDataSource) -> ()) {
        
        guard let tokenKey = userSessionDataSource?.tokenKey else {return}
        let headers = ["Authorization" : String(format: "Bearer %@", tokenKey)]
        
        let parameters = ["username": username,
                          "password": password,
                          "platform_name": "iOS"]
        
        let requestURL = self.getRequestURL(endpoint: "auth/getuserprofiles")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let dataDict = jsonDict.object(forKey: "data") as! NSDictionary? else {return}
                                self.userSessionDataSource = Mapper<UserSessionDataSource>().map(JSON: dataDict as! [String : Any])!
                                completion(self.userSessionDataSource!)
                                break
                                
                            case .failure(_):
                                print(response.result.error as Any)
                                break
                            }
        }
    }
    
    //MARK: FLOW WORKING WITH PASSWORD
    
    /**
     Update user's password
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:      Required: The user name has using to login.
     - parameter email:         Required: The email that verify user
     - parameter password:      Required: The password has checked strength
     - parameter newPassword:   Required: The new password.
     */
    public func changePassword(username:String,
                               email: String,
                               password:String,
                               newPassword:String,
                               completion: @escaping (_ isSuccess: Bool, _ message: String) -> ()) {
        
        guard let tokenKey = userSessionDataSource?.tokenKey else {return}
        let headers = ["Authorization" : String(format: "Bearer %@", tokenKey)]
        
        let parameters = ["username": username,
                          "email":email,
                          "password_old": password,
                          "password_new": newPassword,
                          "platform_name": "iOS"]
        
        let requestURL = self.getRequestURL(endpoint: "auth/changepasswordview")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let message = jsonDict.object(forKey: "msg") as! String? else {return}
                                completion(true,message)
                                break
                                
                            case .failure(_):
                                completion(false,"")
                                break
                            }
        }
    }
    
    /**
     Get OTP code
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:      Required: The user name has using to login.
     - parameter email:         Required: The email that verify user
     */
    public func   {
        
        let parameters = ["username": username,
                          "email":email,
                          "platform_name": "iOS",
                          "method":"email"]
        
        let requestURL = self.getRequestURL(endpoint: "auth/sendOTPview")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let message = jsonDict.object(forKey: "msg") as! String? else {return}
                                completion(true,message)
                                break
                                
                            case .failure(_):
                                completion(false,"")
                                break
                            }
        }
    }
    
    /**
     Confirm OTP code and update new password
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:      Required: The user name has using to login.
     - parameter email:         Required: The email that verify user
     - parameter otpCode:       Required: The OTP code from email / phone
     - parameter newPassword:   Required: New password
     */
    public func changePasswordWithOTP(username: String,
                                      email:    String,
                                      otpCode:  String,
                                      newPassword: String,
                                      completion: @escaping (_ isSuccess: Bool, _ message: String) -> ()) {
        
        let parameters = ["username": username,
                          "email":email,
                          "otp":otpCode,
                          "password_new":newPassword,
                          "platform_name": "iOS",
                          "method":"email"]
        
        let requestURL = self.getRequestURL(endpoint: "auth/forgotpasswordview")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let message = jsonDict.object(forKey: "msg") as! String? else {return}
                                completion(true,message)
                                break
                                
                            case .failure(_):
                                completion(false,"")
                                break
                            }
        }
    }
    
    /**
     Confirm OTP code and update email
     
     - author: Lucas Luu:
     - version: 1.0.0
     - parameter username:      Required: The user name has using to login.
     - parameter email:         Required: The email that verify user
     - parameter otpCode:       Required: The OTP code from email / phone
     - parameter newPassword:   Required: New password
     */
    public func changeEmailWithOTP(username:    String,
                                      email:    String,
                                      newEmail: String,
                                      otpCode:  String,
                                      newPassword: String,
                                      completion: @escaping (_ isSuccess: Bool, _ message: String) -> ()) {
        
        let parameters = ["username": username,
                          "email":email,
                          "otp":otpCode,
                          "password_new":newPassword,
                          "platform_name": "iOS",
                          "method":"email"]
        
        let requestURL = self.getRequestURL(endpoint: "auth/changeemailview")
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                                
                            case .success(_):
                                guard let jsonDict = response.result.value as! NSDictionary? else { return}
                                guard let message = jsonDict.object(forKey: "msg") as! String? else {return}
                                completion(true,message)
                                break
                                
                            case .failure(_):
                                completion(false,"")
                                break
                            }
        }
    }
 */
    #warning("END_FEATURE_READY")
}
