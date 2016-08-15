//
//  BottomsOutfitProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/29/16.


import UIKit
import Parse

class BottomsOutfitProvider: OutfitBuilderDataProvider {
    
    override var category: String {
        return "Bottoms"
    }
    
    static let sharedInstance = BottomsOutfitProvider()
    
    
    
}
