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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60;
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(notif:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }

    @objc func userDataDidChange(notif:Notification) {
        if AuthService.sharedInstance.isLoggedIn {
            loginBtn.setTitle(UserDataService.sharedInstance.name, for: .normal)
            profileImgVw.image = UIImage(named: UserDataService.sharedInstance.avatarName)
            profileImgVw.backgroundColor = UserDataService.sharedInstance.returnAvatarColor(components: UserDataService.sharedInstance.avatarColor)
        }
        else {
            loginBtn.setTitle("Login", for: .normal)
            profileImgVw.image = UIImage(named: "menuProfileIcon")
            profileImgVw.backgroundColor = UIColor.clear
        }
    }
   
    @IBAction func addChannelButtonTapped(_ sender: Any) {}
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue) {}

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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
