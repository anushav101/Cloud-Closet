//
//  FriendOutfitTableViewCell.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/12/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

class FriendOutfitTableViewCell: UITableViewCell {

   
    
    var collectionImages: [PFFile] = []
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}

//extension FriendOutfitTableViewCell: UICollectionViewDataSource {
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "FriendOutfitPicture", forIndexPath: indexPath)
////        let image = collectionImages[indexPath.row]
////        cell.setTheImageView(image)
//        return cell
//    }
//}


extension FriendOutfitTableViewCell: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionImages.count
    }
    
    
    
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "FriendOutfitPicture", forIndexPath: indexPath) as! FriendOutfitCollectionViewCell
            let image = collectionImages[indexPath.row]
            cell.setTheImageView(image)
            return cell
        }
}

    
    
    





