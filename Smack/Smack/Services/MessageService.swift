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
                        completion(true)
                    }
                }
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
}
