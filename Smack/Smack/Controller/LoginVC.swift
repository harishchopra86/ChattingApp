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

        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
    }
    @IBAction func loginBtnTapped(_ sender: Any) {
    
    
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
        
    }
    
    
    

}
