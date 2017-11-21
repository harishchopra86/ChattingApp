//
//  ProfileVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-20.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImgVw: CircleImage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        profileImgVw.image = UIImage(named: UserDataService.sharedInstance.avatarName)
        profileImgVw.backgroundColor = UserDataService.sharedInstance.returnAvatarColor(components: UserDataService.sharedInstance.avatarColor)
        usernameLbl.text = UserDataService.sharedInstance.name
        emailLbl.text = UserDataService.sharedInstance.email
        
        let tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.viewTapped))
        view.addGestureRecognizer(tapGestureReco)
    }
    
    @objc func viewTapped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func CloseBtntapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtntapped(_ sender: Any) {
        UserDataService.sharedInstance.logOutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }

}
