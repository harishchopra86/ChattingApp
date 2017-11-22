//
//  ChannelCell.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-22.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(channel:Channel) {
        let title = channel.channelTitle ?? ""
        channelNameLbl.text = "#\(title)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
    }
        else {
            self.layer.backgroundColor = UIColor.clear.cgColor

        }
    }

}
