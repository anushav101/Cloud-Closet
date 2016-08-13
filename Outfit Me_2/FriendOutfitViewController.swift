//
//  FriendOutfitViewController.swift
//  Cloud Closet

import UIKit
import Parse

class FriendOutfitViewController: UIViewController {
    
    var userInformation: String?
    var storedObjects: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FRIEND OUTFIT VIEW CONTROLLER")
        print(userInformation)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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

}
