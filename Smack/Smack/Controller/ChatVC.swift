//
//  ChatVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-16.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
         NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(notif:)), name: NOTIF_CHANNEL_SELECTED, object: nil)

        if AuthService.sharedInstance.isLoggedIn {
            AuthService.sharedInstance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    
                    }
            })
        }
    }

    @objc func channelSelected(notif:Notification) {
        updateWithChannel()
    }

    func updateWithChannel() {
        let channelName = MessageService.sharedInstance.selectedChannel?.channelTitle ?? ""
        titleLbl.text = "#\(channelName)"
        getMessages()
    }
    
    @objc func userDataDidChange(notif:Notification) {
        setUpUserInfo()
    }
    
    func setUpUserInfo() {
        if AuthService.sharedInstance.isLoggedIn {
            onLoginGetChannelsAndMessages()
        }
        else {
            titleLbl.text = "Please log in"
        }
    }

    func onLoginGetChannelsAndMessages() {
        MessageService.sharedInstance.findAllChannels(completion: { (success) in
            if success {
                if MessageService.sharedInstance.channels.count > 0 {
                    MessageService.sharedInstance.selectedChannel = MessageService.sharedInstance.channels[0]
                    self.updateWithChannel()
                }
                else {
                    self.titleLbl.text = "No channels yet"
                }
            }
        })
    }
    
    func getMessages() {
        guard let channelID = MessageService.sharedInstance.selectedChannel?.id else {return}
        MessageService.sharedInstance.findAllMessagesForChannel(channelId: channelID) { (success) in
            
        }
    }
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        self.revealViewController().revealToggle(sender)
    }
   

}
