//
//  UserDataService.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-17.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import Foundation
class UserDataService {
    static let sharedInstance = UserDataService()
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor:String, avatarName:String, email:String, name:String)  {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName: String) {
      self.avatarName = avatarName
    }
    
    func returnAvatarColor(components: String) -> UIColor {
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",]")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)

        let defaultColor = UIColor.lightGray
        
        guard let rUnrapped = r else {return defaultColor}
        guard let gUnrapped = g else {return defaultColor}
        guard let bUnrapped = b else {return defaultColor}
        guard let aUnrapped = a else {return defaultColor}

        let rFloat = CGFloat(rUnrapped.doubleValue)
        let gFloat = CGFloat(gUnrapped.doubleValue)
        let bFloat = CGFloat(bUnrapped.doubleValue)
        let aFloat = CGFloat(aUnrapped.doubleValue)
        
        let newColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        return newColor
    }
    
    func logOutUser() {
        
        id = ""
        avatarColor = ""
        avatarName = ""
        name = ""
        email = ""
        AuthService.sharedInstance.isLoggedIn = false
        AuthService.sharedInstance.userEmail = ""
        AuthService.sharedInstance.authToken = ""
        
    }
}
