//
//  TopsOutfitProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/29/16.

import UIKit
import Parse

class TopsOutfitProvider: OutfitBuilderDataProvider {
    
    override var category: String {
        return "Tops"
    }
    
  static let sharedInstance = TopsOutfitProvider()
    
    
    
}
