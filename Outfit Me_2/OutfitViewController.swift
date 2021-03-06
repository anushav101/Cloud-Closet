//
//  OutfitViewController.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 8/3/16.


import UIKit
import Parse

class OutfitViewController: UIViewController {
    
    var storedObjects : [PFObject] = []
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var okayButton: UIButton!
    
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
        
        
        publicButton.backgroundColor = UIColor.clearColor()
        publicButton.layer.cornerRadius = 5
        publicButton.layer.borderWidth = 1
        publicButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        if(PFUser.currentUser()!["public"] as? String == "true") {
            self.publicButton.setTitle("Public", forState: .Normal)
        }
        else {
            self.publicButton.setTitle("Private", forState: .Normal)
        }
        
        
        storedObjects = []
        let query = PFQuery(className: "Outfits")
        query.whereKey("createdFor", equalTo: PFUser.currentUser()!)
        query.includeKey("createdBy")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if objects!.count == 0 {
                self.modalView.hidden = false
            }
            
            self.storedObjects = objects!
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableView.reloadData()
            })
            
            
            
            
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
//        storedObjects = []
//        let query = PFQuery(className: "Outfits")
//        query.whereKey("createdFor", equalTo: PFUser.currentUser()!)
//        query.includeKey("createdBy")
//        query.orderByDescending("createdAt")
//        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            
//            if objects!.count == 0 {
//                self.modalView.hidden = false
//            }
//            
//            self.storedObjects = objects!
//            
//            dispatch_async(dispatch_get_main_queue(), {
//              
//                self.tableView.reloadData()
//            })
//            
//            
//            
//            
//        }
    }
    
    
    @IBAction func okayButtonPressed(sender: AnyObject) {
        
        self.modalView.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addOutfit(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OutfitBuilderViewController") // again change to your view
        self.navigationController?.pushViewController(vc as! OutfitBuilderViewController, animated: true)
        
    }
    
    @IBAction func changePublic(sender: AnyObject) {
        
        
        if(PFUser.currentUser()!["public"] as? String == "true") {
            
            
            let object = PFUser.currentUser()
            object!["public"] = "false"
            object!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("Object has been saved.")
                    self.publicButton.setTitle("Private", forState: .Normal)
                    
                }
                else {
                    print(error)
                }
            }
            
        }
        else {
            
            let object = PFUser.currentUser()
            object!["public"] = "true"
            object!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("Object has been saved.")
                    self.publicButton.setTitle("Public", forState: .Normal)
                    
                }
                else {
                    print(error)
                }
            }        }
        
        
        
    }
    
    
}


extension OutfitViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedObjects.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: OutfitTableViewCell = tableView.dequeueReusableCellWithIdentifier("Outfits", forIndexPath: indexPath) as! OutfitTableViewCell
        
        let object = storedObjects[indexPath.row]
        cell.checkMark.hidden = true
        if (object["share"] != nil) {
            if (object["share"] as! String == "true"){
                cell.checkMark.hidden = false
            }
        }
        if (object["images"] != nil){
            cell.collectionImages = object["images"] as! [PFFile]
        }
        cell.outfitObject.append(object)
        cell.tableIndexPath = indexPath.row
        cell.collectionView.reloadData()
        cell.outfitNumber.text = "Outfit # \(storedObjects.count - indexPath.row )"
        
        
        if(object["createdBy"] != nil){
//            let query : PFQuery = PFUser.query()!
//            let str = object["createdFor"].objectId
//            query.whereKey("objectId", equalTo: str)
//            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                
//                for item in objects! {
//                    
//                    let str1 = "created by: "
//                    let str2 = item["username"] as? String
//                    cell.byLabel.text = str1 + str2!
//
//                }
//            cell.byLabel.text = object["createdBy"].username
            let username = object["createdBy"].username!
            let str = "by: "
            cell.byLabel.text =  str + username!
        }
        else {
            cell.byLabel.text = " "
            
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            print("NOTE DELETED !!!!!!!")
            print("REMOVING AT INDEX: \(indexPath.row))")
            let query = PFQuery(className: "Outfits")
            let object = storedObjects[indexPath.row]
            storedObjects.removeAtIndex(indexPath.row)
            //            self.tableView.reloadData()
            query.whereKey("objectId", equalTo: object.objectId!)
            
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                for item in objects! {
                    //                    item.deleteEventually()
                    item.deleteInBackgroundWithBlock({(success: Bool, error: NSError?)-> Void in
                        if (success) {
                            
                            
                            print("SUCCESS")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.tableView.reloadData()
                            }
                            
                        }
                        else {
                            print("CANNOT DELETE")
                        }
                    })
                    
                }
                //                self.tableView.reloadData()
            }
        }
        
        
        
        
        
    }
    
    //        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
    //            
    //            self.tableView.reloadData()
    //            
    //        })
    //        
    //        
    //        
    //    }
    
}













