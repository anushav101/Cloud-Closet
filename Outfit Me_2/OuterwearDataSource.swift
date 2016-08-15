//
//  OuterwearDataSource.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/15/16.




import UIKit
import Parse

class OuterwearDataProvider: ClothingDataProvider {
    
    
    override var category: String {
        return "Outerwear"
    }
    
    static let sharedInstance = OuterwearDataProvider()
    
    
}