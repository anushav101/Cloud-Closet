//
//  FriendOutfitCollectionViewCell.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/13/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

class FriendOutfitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    func setTheImageView(userPicture: PFFile) {
        
        userPicture.getDataInBackgroundWithBlock({
            (imageData: NSData?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
                
            else {
                let image = UIImage(data:imageData!)
                self.imageView.image = image
                
            }
            
        })
        
    }
    
    
    
}
