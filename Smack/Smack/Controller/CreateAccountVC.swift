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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.sharedInstance.avatarName != "" {
            avatarImgVw.image = UIImage(named:UserDataService.sharedInstance.avatarName)
            avatarName = UserDataService.sharedInstance.avatarName
            
            if avatarName.contains("light") && bgColor == nil {
                avatarImgVw.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func chooseAvataarTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }

    @IBAction func createAccountBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        spinner.startAnimating()
        AuthService.sharedInstance.registerUser(withEmail: email, andpassword: password) { (success) in
            if success {
                AuthService.sharedInstance.loginUser(withEmail: email, andpassword: password, completion: { (success) in
                    if success {
                        AuthService.sharedInstance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object:nil)
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
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2) {
            self.avatarImgVw.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    func setUpView() {
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        
        
        let tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.viewTapped))
        view.addGestureRecognizer(tapGestureReco)
    }
    
   @objc func viewTapped() {
        self.view.endEditing(true)
    }
}

