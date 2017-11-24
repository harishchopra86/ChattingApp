//
//  SocketService.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-22.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let sharedInstance = SocketService()

    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(false), .compress])

    func establishConnection() {
       manager.defaultSocket.connect()
    }
    
    func closeConnection() {
        manager.defaultSocket.disconnect()
    }
    
    func addChannel(channelName:String, channelDescription:String, completion: @escaping CompletionHandler) {
       manager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        manager.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }

            let newChannel = Channel(id: channelId, channelDescription: channelDescription, channelTitle: channelName)
            MessageService.sharedInstance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody:String, userId:String, channelId:String, completion:@escaping CompletionHandler) {
        let user = UserDataService.sharedInstance
        manager.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatmessage(completion: @escaping (_ newMessage:Message)-> Void) {
        manager.defaultSocket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timestamp = dataArray[7] as? String else { return }
            let newMessage = Message(message: msgBody, username: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timestamp)
            completion(newMessage)
        }
    }
    
    func getTypingUsers(completion: @escaping (_ typingUsers:[String:String])-> Void) {
        manager.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String:String] else {return}
            completion(typingUsers)            
        }
    }
    
    
}
