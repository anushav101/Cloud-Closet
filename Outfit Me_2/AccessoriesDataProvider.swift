//
//  AccessoriesDataProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/29/16.


import UIKit
import Parse

class AccessoriesOutfitProvider: OutfitBuilderDataProvider {
    
    override var category: String {
        return "Accessories"
    }
    
    static let sharedInstance = AccessoriesOutfitProvider()
    
    
    
}
