//
//  ClothingDataProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/22/16.


import UIKit
import Parse

var objectsToDelete: [PFObject] = []


class ClothingDataProvider : NSObject{
    
    
    var storedObjects: [PFObject] = [] {
        didSet {
//            print("did set storedObjects: \(storedObjects)")
        }
    }
    
    var category: String {
        return ""
    }
    
    func getAllClothing(success: (Bool) -> Void)  {
        let query = PFQuery(className: "Product")
        query.orderByDescending("createdAt")
        query.whereKey("category", equalTo: category)
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.storedObjects = objects ?? []
            
            success(true)
            
        }

        
    }

    
    
}

extension ClothingDataProvider: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return storedObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
//        let image = images[indexPath.row]
        
        // insert loading logic here
        
        cell.setTheImageView(storedObjects[indexPath.row])
    
        if objectsToDelete.contains(storedObjects[indexPath.row]){
            cell.layer.borderWidth = 6.0
            cell.layer.borderColor = UIColor.darkGrayColor().CGColor
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
        if objectsToDelete.contains(storedObjects[indexPath.row]) && (cell!.layer.borderWidth == 6) {
            cell!.layer.borderWidth = 0
            var i = -1
            for object in objectsToDelete {
                i += 1
                if self.storedObjects[indexPath.row] == object {
                    objectsToDelete.removeAtIndex(i)
                }
            }
            
        }
        else {
        
        cell!.layer.borderWidth = 6.0
//        cell!.layer.borderColor = UIColor.grayColor().CGColor
        cell!.layer.borderColor = UIColor.darkGrayColor().CGColor
        objectsToDelete.append(self.storedObjects[indexPath.row])
//        print(objectsToDelete)
//        print("THIS IS COLLECTION VIEW INDEX!")
//        print(indexPath.row)
        }
        
    }
    
    
    
    
    

    
}











