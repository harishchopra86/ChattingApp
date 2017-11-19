//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-17.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var avatarImgVw: UIImageView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }

    @IBAction func chooseAvataarTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }

    @IBAction func createAccountBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }

        AuthService.sharedInstance.registerUser(withEmail: email, andpassword: password) { (success) in
            if success {
                AuthService.sharedInstance.loginUser(withEmail: email, andpassword: password, completion: { (success) in
                    if success {
                        AuthService.sharedInstance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                print("logged in", UserDataService.sharedInstance.name)
                            }
                            else {
                                
                            }
                        })
                    }
                    else {
                        
                    }
                })
            }
            else {
                print("failure")
            }
        }
    }
    
    @IBAction func generateBackgrountColorBtnTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}















