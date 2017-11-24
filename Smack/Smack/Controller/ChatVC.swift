//
//  ChatVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-16.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chatTblVw: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var typingUserLbl: UILabel!
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        let tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(ChatVC.viewTapped))
        view.addGestureRecognizer(tapGestureReco)

        chatTblVw.estimatedRowHeight = 80
        chatTblVw.rowHeight = UITableViewAutomaticDimension
        sendBtn.isHidden = true
        
         NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(notif:)), name: NOTIF_CHANNEL_SELECTED, object: nil)

        SocketService.sharedInstance.getChatmessage { (newMessage) in
            if newMessage.channelId == MessageService.sharedInstance.selectedChannel?.id && AuthService.sharedInstance.isLoggedIn {
                MessageService.sharedInstance.messages.append(newMessage)
                self.chatTblVw.reloadData()
                if MessageService.sharedInstance.messages.count > 0 {
                    let endIndex = IndexPath(item: MessageService.sharedInstance.messages.count - 1, section: 0)
                    self.chatTblVw.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.sharedInstance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.sharedInstance.selectedChannel?.id else {return}
            var names = ""
            var numberOfTypers = 0
            
            for(typinguser, channel) in typingUsers {
                if typinguser != UserDataService.sharedInstance.name && channel == channelId {
                    
                    if names == "" {
                        names = typinguser
                    }
                    else {
                        names = "\(names),\(typinguser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.sharedInstance.isLoggedIn {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names) \(verb) typing a message"
            }
            else {
                self.typingUserLbl.text = ""
            }
        }
        
        if AuthService.sharedInstance.isLoggedIn {
            APP_DELEGATE.showLoadingView()
            AuthService.sharedInstance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
                else {
                    APP_DELEGATE.hideloadingView()
                }
            })
        }
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
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
            chatTblVw.reloadData()
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
            APP_DELEGATE.hideloadingView()
            if success {
                self.chatTblVw.reloadData()
            }
        }
    }
    @IBAction func messageFieldEditing(_ sender: Any) {
        guard let channelId = MessageService.sharedInstance.selectedChannel?.id else {return}
        if messageField.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.sharedInstance.manager.defaultSocket.emit("stopType", UserDataService.sharedInstance.name, channelId)
        }
        else {
            if isTyping == false {
                sendBtn.isHidden = false
                SocketService.sharedInstance.manager.defaultSocket.emit("startType", UserDataService.sharedInstance.name, channelId)
            }
            isTyping = true
        }
    }
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        self.revealViewController().revealToggle(sender)
    }
   
    @IBAction func sendMsgBtnTapped(_ sender: Any) {
        if AuthService.sharedInstance.isLoggedIn {
            guard let channelId = MessageService.sharedInstance.selectedChannel?.id else {return}
            guard let message = messageField.text, messageField.text != "" else {return}
            
            SocketService.sharedInstance.addMessage(messageBody: message, userId: UserDataService.sharedInstance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageField.resignFirstResponder()
                    self.messageField.text = ""
                    SocketService.sharedInstance.manager.defaultSocket.emit("stopType", UserDataService.sharedInstance.name, channelId)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return MessageService.sharedInstance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell
        {
            cell.configureCell(message: MessageService.sharedInstance.messages[indexPath.row])
            return cell
        }
        return MessageCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
