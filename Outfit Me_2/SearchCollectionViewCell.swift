//
//  SearchCollectionViewCell.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/11/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        self.layer.borderWidth = 0
    }
    
    
}
