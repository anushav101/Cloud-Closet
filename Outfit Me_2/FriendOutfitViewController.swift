//
//  FriendOutfitViewController.swift
//  Cloud Closet

import UIKit
import Parse

class FriendOutfitViewController: UIViewController, UITableViewDataSource  {
    
    var userInformation: PFUser?
    var storedObjects: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        print("FRIEND OUTFIT VIEW CONTROLLER")
        print(userInformation)
        self.tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        storedObjects = []
        self.edgesForExtendedLayout = .None
        let query = PFQuery(className: "Outfits")
        query.whereKey("createdFor", equalTo: self.userInformation!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.storedObjects = objects!
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            
            
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("FriendViewController") // again change to your view
        self.navigationController?.pushViewController(vc as! FriendViewController, animated: true)
        
    }
    
    
    @IBAction func addOutfit(sender: AnyObject) {
        
        //        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("FriendOutfitBuilderViewController") // again change to your view
        //        self.navigationController?.pushViewController(vc as! FriendOutfitBuilderViewController, animated: true)
        //
        performSegueWithIdentifier("toFOB", sender: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier == "toFOB") {
            
            let destinationVC = segue.destinationViewController as! FriendOutfitBuilderViewController
            destinationVC.userInformation = userInformation
            
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.storedObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: FriendOutfitTableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendOutfitCategory", forIndexPath: indexPath) as! FriendOutfitTableViewCell
        
        
        
        //        let cell: FriendOutfitTableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendOutfitTableViewCell", forIndexPath: indexPath) as! FriendOutfitTableViewCell
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("FriendOutfitCategory", forIndexPath: indexPath)
        
        
        
        
        
        let object = storedObjects[indexPath.row]
        if (object["images"] != nil){
            cell.collectionImages = object["images"] as! [PFFile]
        }
        cell.numberLabel.text = "Outfit # \(storedObjects.count - indexPath.row )"

        cell.collectionView.reloadData()
        
        return cell
    }
    
}








