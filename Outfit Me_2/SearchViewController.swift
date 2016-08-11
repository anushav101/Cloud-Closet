//
//  SearchViewController.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
   
    @IBOutlet weak var collectionView: UICollectionView!
    var clothingArray: [String] = []
    
    override func viewWillAppear(animated: Bool) {
//        GoogleCustomSearch("black+shirt")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

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
        GoogleCustomSearch(str)
        self.collectionView.reloadData()
        
        
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

}





extension SearchViewController: UICollectionViewDataSource {
    
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
        
        
        
        return cell
    }
    
    
    
}


    











