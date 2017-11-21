//
//  AuthService.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-17.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
   static let sharedInstance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }}
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }}
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }}
    
    
    func registerUser(withEmail email:String, andpassword password:String, completion:@escaping CompletionHandler) {
        let lowecaseEmail = email.lowercased()
        let body:[String:Any] = [
            "email":lowecaseEmail,
            "password":password
        ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (responseString) in
            if responseString.result.error == nil {
                completion(true)
            }
            else {
                completion(false)
                debugPrint(responseString.result.error as Any)
            }
        }
    }
        
        func loginUser(withEmail email:String, andpassword password:String, completion:@escaping CompletionHandler) {
            let lowecaseEmail = email.lowercased()
           
            let body:[String:Any] = [
                "email":lowecaseEmail,
                "password":password
            ]
            Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON(completionHandler: { (responseJSON) in
                if responseJSON.result.error == nil {
                   
                    guard let data = responseJSON.data else {return}
                    let json = try! JSON(data:data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    
                  /*  if let json = responseJSON.result.value as? [String:Any] {
                        if let email = json["user"] as? String {
                            self.userEmail = email
                        }
                        if let token = json["token"] as? String {
                            self.authToken = token
                        }
                    } */
                    self.isLoggedIn = true
                    completion(true)
                }
                else {
                    completion(false)
                    debugPrint(responseJSON.result.error as Any)
                }
            })
    }
        
    func createUser(name:String, email:String, avatarName:String, avatarColor:String, completion:@escaping CompletionHandler) {
        let lowecaseEmail = email.lowercased()
        
        let body:[String:Any] = [
            "name":name,
            "email":lowecaseEmail,
            "avatarName":avatarName,
            "avatarColor":avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON(completionHandler: { (responseJSON) in
         
            if responseJSON.result.error == nil {
                guard let data = responseJSON.data else {return}
                self.setUserInfo(data: data)
                completion(true)
            }
            else {
                completion(false)
                debugPrint(responseJSON.result.error as Any)
            }
        })
    }
    
    func findUserByEmail(completion:@escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON(completionHandler: { (responseJSON) in
            
            if responseJSON.result.error == nil {
                guard let data = responseJSON.data else {return}
                self.setUserInfo(data: data)
                completion(true)
            }
            else {
                completion(false)
                debugPrint(responseJSON.result.error as Any)
            }
        })
    }

    func setUserInfo(data:Data) {
        let json = try! JSON(data:data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        UserDataService.sharedInstance.setUserData(id: id, avatarColor: color, avatarName: avatarName, email: email, name: name)
        /*  if let json = responseJSON.result.value as? [String:Any] {
         if let email = json["user"] as? String {
         self.userEmail = email
         }
         if let token = json["token"] as? String {
         self.authToken = token
         }
         } */
    }
    
    
    
}
