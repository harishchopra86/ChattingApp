//
//  LoginVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-17.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
    
        guard let email = usernameField.text, usernameField.text != "" else{return}
        guard let password = passwordField.text, passwordField.text != "" else {return}
        AuthService.sharedInstance.loginUser(withEmail: email, andpassword: password) { (success) in
            if success {
                AuthService.sharedInstance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object:nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                    }
                })
            }
            else {
            }
        }
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    func setUpView() {
        usernameField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        
        let tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.viewTapped))
        view.addGestureRecognizer(tapGestureReco)
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
}
