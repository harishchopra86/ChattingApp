//
//  MessageService.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-21.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService  {
    static let sharedInstance = MessageService()

    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(id: id, channelDescription: description, channelTitle: name)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId:String, completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_GET_MESSAGES)/\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelID = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let id = item["_id"].stringValue
                        let timestamp = item["timeStamp"].stringValue
                        let message = Message(message: messageBody, username: userName, channelId: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timestamp)
                        self.messages.append(message)
                    }
                    print(self.messages)
//                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }

    }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
        
    func clearMessages() {
        messages.removeAll()
    }
    
    
    
}







