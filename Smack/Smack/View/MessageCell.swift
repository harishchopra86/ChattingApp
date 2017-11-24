//
//  MessageCell.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-23.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImageVw: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message:Message) {
        usernameLbl.text = message.username;
        messageLbl.text = message.message;
        userImageVw.image = UIImage(named: message.userAvatar)
        userImageVw.backgroundColor = UserDataService.sharedInstance.returnAvatarColor(components: message.userAvatarColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
