//
//  FriendOutfitBuilderViewController.swift
//  Cloud Closet


import UIKit
import Parse

class FriendOutfitBuilderViewController: UIViewController {
    
    var userInformation: String?
    
    var topsArray: [PFObject] = []
    var bottomsArray: [PFObject] = []
    var outerwearArray: [PFObject] = []
    var dressesArray: [PFObject] = []
    var accessoriesArray: [PFObject] = []
    var shoesArray: [PFObject] = []
    
    

    @IBOutlet weak var tableView: UITableView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FRIEND OUTFIT BUILDER VIEW CONTROLLER")
        print(userInformation)
        self.tableView.dataSource = self

       
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        let query = PFQuery(className: "Product")
//        query.whereKey("category", equalTo: "Tops")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            for object in objects! {

            
                if (object["user"].objectId == self.userInformation!) {
                    if(object["category"] as! String == "Tops"){
                        self.topsArray.append(object)
                    }
                    if(object["category"] as! String == "Bottoms"){
                        self.bottomsArray.append(object)
                    }
                    if(object["category"] as! String == "Outerwear"){
                        self.outerwearArray.append(object)
                    }
                    if(object["category"] as! String == "Dresses"){
                        self.dressesArray.append(object)
                    }
                    if(object["category"] as! String == "Accessories"){
                        self.accessoriesArray.append(object)
                    }
                    if(object["category"] as! String == "Shoes"){
                        self.shoesArray.append(object)
                    }
              
                }
                
            }
            print("PRINTING OUT TOPS!")
            print(self.topsArray)
            self.tableView.reloadData()
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


   
    @IBAction func backButton(sender: AnyObject) {
        
        performSegueWithIdentifier("toFriendsOutfit", sender: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier == "toFriendsOutfit") {
            
            let destinationVC = segue.destinationViewController as! FriendOutfitViewController
            destinationVC.userInformation = userInformation
            
        }
    }

}

extension FriendOutfitBuilderViewController: UITableViewDataSource {
    
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 6
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: FOBTableViewCell = tableView.dequeueReusableCellWithIdentifier("FOBCategory", forIndexPath: indexPath) as! FOBTableViewCell
        
        if (indexPath.row == 0){
            cell.collectionObjects = self.topsArray
        }
        if (indexPath.row == 1){
            cell.collectionObjects = self.bottomsArray
        }
        if (indexPath.row == 2){
            cell.collectionObjects = self.outerwearArray
        }
        if (indexPath.row == 3){
            cell.collectionObjects = self.dressesArray
        }
        if (indexPath.row == 4){
            cell.collectionObjects = self.accessoriesArray
        }
        if (indexPath.row == 5){
            cell.collectionObjects = self.shoesArray
        }
        
        
        cell.collectionView.reloadData()
        return cell
    }
    

    
    
}








