//
//  ChannelVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-16.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var channelsTableView: UITableView!
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60;
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded(notif:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.sharedInstance.getChannel { (success) in
            self.channelsTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }

    @objc func channelsLoaded(notif:Notification) {
        channelsTableView.reloadData()
    }

    @objc func userDataDidChange(notif:Notification) {
        setUpUserInfo()
    }
   
    func setUpUserInfo() {
        if AuthService.sharedInstance.isLoggedIn {
            loginBtn.setTitle(UserDataService.sharedInstance.name, for: .normal)
            profileImgVw.image = UIImage(named: UserDataService.sharedInstance.avatarName)
            profileImgVw.backgroundColor = UserDataService.sharedInstance.returnAvatarColor(components: UserDataService.sharedInstance.avatarColor)
        }
        else {
            loginBtn.setTitle("Login", for: .normal)
            profileImgVw.image = UIImage(named: "menuProfileIcon")
            profileImgVw.backgroundColor = UIColor.clear
            channelsTableView.reloadData()
        }
    }
    
    @IBAction func addChannelButtonTapped(_ sender: Any) {        
        let addChannelVC = AddChannelVC()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if AuthService.sharedInstance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.sharedInstance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for:indexPath) as? ChannelCell {
            cell.configureCell(channel: MessageService.sharedInstance.channels[indexPath.row])
            return cell
        }
        return ChannelCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChannel = MessageService.sharedInstance.channels[indexPath.row]
        MessageService.sharedInstance.selectedChannel = selectedChannel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
    
}
