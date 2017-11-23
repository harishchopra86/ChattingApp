//
//  AddChannelVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-22.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var channelNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    func setUpView() {
        descriptionField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        channelNameField.attributedPlaceholder = NSAttributedString(string: "channel", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        
        let tapGestureReco = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.viewTapped))
        view.addGestureRecognizer(tapGestureReco)
    }
    
    @objc func viewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createChannelBtntapped(_ sender: Any) {
        if AuthService.sharedInstance.isLoggedIn {
            guard let channelName = channelNameField.text, channelNameField.text != "" else{return}
            guard let channelDescription = descriptionField.text, descriptionField.text != "" else {return}
            SocketService.sharedInstance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    

}
