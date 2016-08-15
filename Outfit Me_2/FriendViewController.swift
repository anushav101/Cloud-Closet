    //
    //  FriendViewController.swift
    //  Cloud Closet
    //
    //  Created by Anusha Venkatesan on 8/12/16.
    //  Copyright © 2016 MakeSchool. All rights reserved.
    //
    
    import UIKit
    import Parse
    
    class FriendViewController: UIViewController {
        
        @IBOutlet weak var modalView: UIView!
        @IBOutlet weak var okayButton: UIButton!
        var storedObjects: [PFObject] = []
        //    var userInformation: PFObject?
//        var userInformation: String?
        var userInformation: PFUser?
     
        
        @IBOutlet weak var tableView: UITableView!
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
            
            
        }
        
        @IBAction func okayButtonPressed(sender: AnyObject) {
            self.modalView.hidden = true
        }
        
        override func viewWillAppear(animated: Bool) {
            let query : PFQuery = PFUser.query()!
            query.orderByAscending("username")
            //        query.orderByDescending("date")
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                
                self.storedObjects = objects ?? []
                print("STORED OBJECTS COUNT: \(self.storedObjects.count)")
                
                self.tableView.reloadData()
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    
    extension FriendViewController: UITableViewDataSource {
        
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return self.storedObjects.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell: FriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as!FriendTableViewCell
            
            let user = self.storedObjects[indexPath.row]
            
            cell.label.text = user["username"] as? String
            
            
            
            
            return cell
        }
    }
    
    extension FriendViewController: UITableViewDelegate {
        
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
            
            //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let user = self.storedObjects[indexPath.row]
            let currentuser = PFUser.currentUser()
            if(user["username"] as? String == currentuser?.username){
                print("CURRENT USER")
                self.tabBarController!.selectedIndex = 2;
            }
            else {
                
                if(user["public"] as? String == "true"){
                    
                    print("USER PUBLIC")
//                    userInformation = user.objectId
                    userInformation = user as! PFUser
                    performSegueWithIdentifier("toOF", sender: nil)
                    
                }
                else {
                    print("USER PRIVATE")
                    self.modalView.hidden = false
                }
            }
            
            
            
            
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            
            if(segue.identifier == "toOF") {
                
                let destinationVC = segue.destinationViewController as! FriendOutfitViewController
                destinationVC.userInformation = userInformation
                
            }
        }
        
    }
    
    
    
    
    
