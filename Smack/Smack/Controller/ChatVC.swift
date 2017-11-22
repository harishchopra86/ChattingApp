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
        
        if AuthService.sharedInstance.isLoggedIn {
            AuthService.sharedInstance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    MessageService.sharedInstance.findAllChannels { (success) in
                        
                    }

                }
            })
        }
        
    }

    
    @IBAction func menuBtnTapped(_ sender: Any) {
        
        self.revealViewController().revealToggle(sender)
        
    }
   

}
