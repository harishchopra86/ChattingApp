//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-19.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var avatarCollectionVw: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell
        {
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
    }
    
}
