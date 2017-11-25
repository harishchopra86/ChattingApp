//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Harish Chopra on 2017-11-19.
//  Copyright © 2017 Harish Chopra. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Outlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var avatarCollectionVw: UICollectionView!
    
    //Variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(indexPath: indexPath, type: avatarType)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns:CGFloat = 3
        if UIScreen.main.bounds.width > 300 {
            numberOfColumns = 4
        }
        let spaceBetweenCells: CGFloat = 10
        let padding:CGFloat = 40
        let cellDimension = ((collectionView.bounds.width-padding) - (numberOfColumns-1) * spaceBetweenCells) / numberOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.sharedInstance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }
        else {
            UserDataService.sharedInstance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        }
        else {
            avatarType = .light
        }
        avatarCollectionVw.reloadData()
    }
}
