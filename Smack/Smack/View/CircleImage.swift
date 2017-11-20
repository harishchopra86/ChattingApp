//
//  CircleImage.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-19.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
   
    func setUpView() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}

