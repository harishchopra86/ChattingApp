//
//  AuthService.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-17.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
   static let sharedInstance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(true, forKey: LOGGED_IN_KEY)
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
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "email":lowecaseEmail,
            "password":password
        ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (responseString) in
            if responseString.result.error == nil {
                completion(true)
            }
            else {
                completion(false)
                debugPrint(responseString.result.error as Any)
            }
        }
        
    }
    
    
    
    
    
    
}
