//
//  TopsDataProvider.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/15/16.


import UIKit
import Parse

class TopsDataProvider: ClothingDataProvider {
    
    
    override var category: String {
        return "Tops"
    }
    
    static let sharedInstance = TopsDataProvider()
    
    
    }


