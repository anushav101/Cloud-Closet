//
//  DressesOutfitProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/29/16.


import UIKit
import Parse

class DressesOutfitProvider: OutfitBuilderDataProvider {
    
    override var category: String {
        return "Dresses"
    }
    
    static let sharedInstance = DressesOutfitProvider()
    
    
    
}

