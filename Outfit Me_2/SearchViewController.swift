//
//  SearchViewController.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var addButton: UIButton!
   
    @IBOutlet weak var collectionView: UICollectionView!
    var clothingArray: [String] = []
    var objectsToCloset: [String] = []
    
    
    
    @IBOutlet weak var modalView: UIView!
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
//        GoogleCustomSearch("black+shirt")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addButton.hidden = true
        self.modalView.hidden = true
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: UIButton) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") // again change to your view
        self.showViewController(vc as! ViewController, sender: vc) // change again
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func search(sender: AnyObject) {
        let str = searchBar.text!
      
        let aString: String = str
        let newString = aString.stringByReplacingOccurrencesOfString(" ", withString: "+")
        print("NEW STRING:")
        print(newString)
        
        GoogleCustomSearch(newString)
        
        objectsToCloset = []
        self.addButton.hidden = true
        
        
        
        
//        let checkstr = "Z\(str)Z"
//        print("STR VALUE")
//        print("Z\(str)Z")
//        print("SEARCH BUTTON PRESSED!")
//        if (checkstr != "ZZ"||checkstr != "Z Z"||checkstr != "Z  Z"||checkstr != "Z   Z"){
//            print("SEARCH BAR TEXT!")
//            print(str)
//            
//        }
//        else {
//            print("NOTHING TO BE PRINTED")
//        }
        
        
    }
    
    func GoogleCustomSearch(query: String) {
        let bundleID = "com.makeschool.Outfit"
        
        let q = query
        let key = "AIzaSyAjNmmSpUwAjWPq-SLWVnqLvwdEf5zHnmo"
        let cx = "017126530825900472415:6gcgyqv_ffg"
        
        
        
//        let urlString = "https://www.googleapis.com/customsearch/v1?q=\(q)&key=\(key)&cx=\(cx)&searchType=image"
        
        let urlString = "https://www.googleapis.com/customsearch/v1?q=\(q)&key=\(key)&cx=\(cx)&searchType=image"
     
        
        clothingArray = []
        
        Alamofire.request(.GET,
            urlString,
            parameters: nil,
            encoding: .JSON,
            headers: ["X-Ios-Bundle-Identifier" : bundleID])
            .responseJSON { (response) in
                print("PRINTING OUT RESPONSE:   \(response)")
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        for x in 0..<json["items"].count {
                            
                            self.clothingArray.append(json["items"][x]["image"]["thumbnailLink"].stringValue)
                            
                           
                            
                        }
                        self.collectionView.reloadData()
                        print(self.clothingArray)
                        
                        
                    }
                    
                case.Failure(let error):
                    print("PRINTING OUT ERROR: \(error)")
                    
                    print("PRINTING OUT RESPONSE:   \(response)")
                }
        }
    }
    
    
    func saveURL(category: String, dataProvider: ClothingDataProvider) {
        
        for object in objectsToCloset {
            
            if let url = NSURL(string: object) {
                if let data = NSData(contentsOfURL: url) {
                    let image = UIImage(data: data)
                    
                    let imageData = UIImageJPEGRepresentation(image!, 0.8)!
                    do {
                        let imageFile = try PFFile(name: "image.jpg", data: imageData, contentType: "image/jpeg")
                        
                        let testObject = PFObject(className: "Product")
                        
                        // TODO: Make this dynamic (with respect to cell row)
                        let dataProvider = dataProvider
                        testObject["category"] = category
                        testObject["imageFile"] = imageFile
                        testObject["user"] = PFUser.currentUser()
                        
                        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                            if success {
                                print("Object has been saved.")
                                dataProvider.getAllClothing({ (success: Bool) in
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        if (object == self.objectsToCloset[self.objectsToCloset.count - 1]){
                                            
                                            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") // again change to your view
                                            self.showViewController(vc as! ViewController, sender: vc) // change again
                                            
                                        }
                                        
                                    })
                                })
                                
                                
                            }
                            else {
                                print(error)
                            }
                        }
                        
                    } catch {
                        print("there was an error with image upload")
                    }
                    
                    
                }
            }
            
        }
        
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.modalView.hidden = true
    }
    
    @IBAction func sendTops(sender: AnyObject) {
        
        saveURL("Tops", dataProvider: TopsDataProvider.sharedInstance)
        
    }
    
    @IBAction func sendBottoms(sender: AnyObject) {
        
        saveURL("Bottoms", dataProvider: BottomsDataProvider.sharedInstance)
        
    }
    
    
    
    @IBAction func sendOuterwear(sender: AnyObject) {
        
        saveURL("Outerwear", dataProvider: OuterwearDataProvider.sharedInstance)
    }
    
    
    @IBAction func sendDresses(sender: AnyObject) {
        
        saveURL("Dresses", dataProvider: DressesDataProvider.sharedInstance)
    }
    
    
    @IBAction func sendAccessories(sender: AnyObject) {
        
        saveURL("Accessories", dataProvider: AccessoriesDataProvider.sharedInstance)
        
    }
    
    @IBAction func sendShoes(sender: AnyObject) {
        
        saveURL("Shoes", dataProvider: ShoesDataProvider.sharedInstance)
        
    }

    @IBAction func addToCloset(sender: AnyObject) {
        
        
        self.modalView.hidden = false
        
//        saveURL("Tops", dataProvider: TopsDataProvider.sharedInstance)
        

        
    }
}





extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clothingArray.count
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "SearchCell", forIndexPath: indexPath) as! SearchCollectionViewCell
        if let url = NSURL(string: clothingArray[indexPath.row]) {
            if let data = NSData(contentsOfURL: url) {
                cell.imageView.image = UIImage(data: data)
            }        
        }
        
        
        if objectsToCloset.contains(clothingArray[indexPath.row]){
            cell.layer.borderWidth = 6.0
            cell.layer.borderColor = UIColor.darkGrayColor().CGColor
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        if objectsToCloset.contains(clothingArray[indexPath.row]) && (cell!.layer.borderWidth == 6) {
            cell!.layer.borderWidth = 0
            var i = -1
            for object in objectsToCloset {
                i += 1
                if self.clothingArray[indexPath.row] == object {
                    objectsToCloset.removeAtIndex(i)
                    print("\(indexPath.row) REMOVED")
                    print(objectsToCloset)
                }
                if(objectsToCloset.count == 0) {
                    self.addButton.hidden = true
                }
            }
            
        }
        else {
            
            cell!.layer.borderWidth = 6.0
            cell!.layer.borderColor = UIColor.grayColor().CGColor
            
            objectsToCloset.append(self.clothingArray[indexPath.row])
                self.addButton.hidden = false
            print("\(indexPath.row) ADDED")
            print(objectsToCloset)
        
        }
    
    }
}

    











