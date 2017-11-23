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
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])

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
    
    
    
    
    
    
}
