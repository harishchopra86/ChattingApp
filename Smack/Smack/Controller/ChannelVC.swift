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
        
    }

   
    @IBAction func addChannelButtonTapped(_ sender: Any) {}
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue) {
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
