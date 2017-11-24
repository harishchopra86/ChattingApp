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

        guard let dateString = message.timeStamp else {return}
        let locale :Locale = Locale(identifier: "en_US_POSIX")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = DATE_FORMAT
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: dateString)
        
//        let newDateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.timeZone = TimeZone.current
        if let finaldate = date {
            let messagedate = dateFormatter.string(from: finaldate)
            timestampLbl.text = messagedate
        }
        else {
            timestampLbl.text = ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
