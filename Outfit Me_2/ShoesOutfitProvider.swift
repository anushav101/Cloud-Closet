//
//  ShoesOutfitProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/29/16.


import UIKit
import Parse

class ShoesOutfitProvider: OutfitBuilderDataProvider {
    
    override var category: String {
        return "Shoes"
    }
    
    static let sharedInstance = ShoesOutfitProvider()
    
    
    
}
