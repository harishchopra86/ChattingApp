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
    
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }

    @IBAction func chooseAvataarTapped(_ sender: Any) {
        
    }

    @IBAction func createAccountBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }

        AuthService.sharedInstance.registerUser(withEmail: email, andpassword: password) { (success) in
            if success {
                AuthService.sharedInstance.loginUser(withEmail: email, andpassword: password, completion: { (success) in
                    print("logged in", AuthService.sharedInstance.authToken)

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















