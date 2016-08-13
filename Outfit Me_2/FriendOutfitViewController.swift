//
//  FriendOutfitViewController.swift
//  Cloud Closet

import UIKit
import Parse

class FriendOutfitViewController: UIViewController, UITableViewDataSource  {
    
    var userInformation: String?
    var storedObjects: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FRIEND OUTFIT VIEW CONTROLLER")
        print(userInformation)
        self.tableView.dataSource = self

        
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "Outfits")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            for object in objects! {
                if (object["user"].objectId  == self.userInformation!){
                    if(object["createdBy"] as! String  == "user"){
                        self.storedObjects.append(object)
                    }
                }
            }
            print(self.storedObjects)
            self.tableView.reloadData()
            
            
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
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendOutfitCategory", forIndexPath: indexPath)
        
        return cell
    }

}








