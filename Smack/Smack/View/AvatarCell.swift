//
//  AvatarCell.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-19.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit
enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImgVw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell(indexPath:IndexPath, type:AvatarType) {
        if type == AvatarType.dark
        {
            avatarImgVw.image = UIImage(named: "dark\(indexPath.row)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else {
            avatarImgVw.image = UIImage(named: "light\(indexPath.row)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
