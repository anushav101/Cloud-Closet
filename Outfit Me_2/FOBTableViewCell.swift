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

extension FOBTableViewCell: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionObjects.count
       
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "FOBuilderCell", forIndexPath: indexPath) as! FOBCollectionViewCell
        let object = collectionObjects[indexPath.row]
        let image = object
        cell.setTheImageView(image)
        return cell
    }
}



