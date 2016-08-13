//
//  FOBTableViewCell.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/13/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

class FOBTableViewCell: UITableViewCell {
    
    var collectionObjects: [PFObject] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension FOBTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionObjects.count
       
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "FOBuilderCell", forIndexPath: indexPath) as! FOBCollectionViewCell
        let object = collectionObjects[indexPath.row]
        let image = object
        cell.setTheImageView(image)
        
        if objectsToFriend.contains(object){
            cell.layer.borderWidth = 6.0
            cell.layer.borderColor = UIColor.cyanColor().CGColor
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
        if objectsToFriend.contains(collectionObjects[indexPath.row]) && (cell!.layer.borderWidth == 6) {
            cell!.layer.borderWidth = 0
            var i = -1
            for object in objectsToFriend {
                i += 1
                if self.collectionObjects[indexPath.row] == object {
                    objectsToFriend.removeAtIndex(i)
                    print("OBJECTSTOFRIEND")
                    print(objectsToFriend)
                }
            }
            
        }
        else {
            
            cell!.layer.borderWidth = 6.0
            //        cell!.layer.borderColor = UIColor.grayColor().CGColor
            cell!.layer.borderColor = UIColor.cyanColor().CGColor
            objectsToFriend.append(self.collectionObjects[indexPath.row])
            print("OBJECTSTOFRIEND")
            print(objectsToFriend)
            //            print(objectsToOutfit)
            //            print("THIS IS COLLECTION VIEW INDEX!")
            //            print(indexPath.row)
        }
        
    }
    
}



