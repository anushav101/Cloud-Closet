//
//  OutfitBuilderViewController.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/28/16.


import UIKit
import Parse

class OutfitBuilderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var categoryOutfitProvider = [TopsOutfitProvider.sharedInstance, BottomsOutfitProvider.sharedInstance, OuterwearOutfitProvider.sharedInstance, DressesOutfitProvider.sharedInstance, AccessoriesOutfitProvider.sharedInstance, ShoesOutfitProvider.sharedInstance]

    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var modalView: UIView!
    
    @IBAction func okayButtonPressed(sender: AnyObject) {
        
        self.modalView.hidden = true
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.modalView.hidden = true
        modalView.backgroundColor = UIColor.whiteColor()
        modalView.layer.cornerRadius = 15
        okayButton.layer.cornerRadius = 20
        modalView.layer.borderWidth = 6
        modalView.layer.borderColor = UIColor(colorLiteralRed: 43/255, green: 161/255, blue: 160/255, alpha: 0.75).CGColor
        okayButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        okayButton.backgroundColor = UIColor(colorLiteralRed: 43/255, green: 161/255, blue: 160/255, alpha: 0.75)
        
        
        let query = PFQuery(className: "Product")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if objects?.count == 0 {
                self.modalView.hidden = false
            }
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        TopsOutfitProvider.sharedInstance.getAllClothing { (success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        
        BottomsOutfitProvider.sharedInstance.getAllClothing { (success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        
        OuterwearOutfitProvider.sharedInstance.getAllClothing { (success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        
        DressesOutfitProvider.sharedInstance.getAllClothing { (success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        
        AccessoriesOutfitProvider.sharedInstance.getAllClothing { (success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        
        ShoesOutfitProvider.sharedInstance.getAllClothing { (success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // D/Users/anushavenkatesan/Desktop/XCode Projects/Outfit Me_2/Outfit Me_2/OutfitBuilderTableViewCell.swiftispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func back(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OutfitViewController") // again change to your view
        self.navigationController?.pushViewController(vc as! OutfitViewController, animated: true)
        
        
    }
}

extension OutfitBuilderViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: OutfitBuilderTableViewCell = tableView.dequeueReusableCellWithIdentifier("OutfitCategories", forIndexPath: indexPath) as! OutfitBuilderTableViewCell
       
        cell.collectionView.dataSource = self.categoryOutfitProvider[indexPath.row]
        cell.collectionView.delegate = self.categoryOutfitProvider[indexPath.row]
        return cell
        
        
    }
   
    
  
    @IBAction func createOutfit(sender: AnyObject) {
        
        if(objectsToOutfit.count == 0){
            return
        }
        
        
        let testObject = PFObject(className: "Outfits")
        testObject.ACL?.publicWriteAccess = true
        testObject["user"] = PFUser.currentUser()
        testObject["createdFor"] = PFUser.currentUser()
        for outfits in objectsToOutfit {
            let outfitImage = outfits["imageFile"]
            testObject.addObject(outfitImage, forKey: "images")
            
            
        }
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Object has been saved.")
                let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OutfitViewController") // again change to your view
                self.navigationController?.pushViewController(vc as! OutfitViewController, animated: true)
//                self.showViewController(vc as! OutfitViewController, sender: vc) // change again

                //add in function that will clear highlights
                
                objectsToOutfit = []
                self.tableView.reloadData()
                
                //segue to outfits
            }
            else {
                print(error)
            }
        }
        
    }

}

