//
//  FeedViewController.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 8/8/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

var refresher: UIRefreshControl!

class FeedViewController: UIViewController {
    
    var storedObjects: [PFObject] = []
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var gotitButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
   
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        refresher.tintColor = UIColor(colorLiteralRed: 43/255, green: 161/255, blue: 160/255, alpha: 0.75)
    }
    
    func refresh() {
        
        loader()
        refresher.endRefreshing()
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    
    func loader(){
        let query = PFQuery(className: "Outfits")
        query.whereKey("share", equalTo: "true")
        query.includeKey("user")
        query.orderByDescending("date")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.storedObjects = objects ?? []
            self.tableView.reloadData()
            
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "Outfits")
        query.whereKey("share", equalTo: "true")
        query.includeKey("user")
        query.orderByDescending("date")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error:  NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.storedObjects = objects ?? []
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


extension FeedViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedObjects.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FeedTableViewCell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedTableViewCell
        
        
//        let date = object["createdAt"]
        cell.modalView.hidden = true
        
        cell.modalView.backgroundColor = UIColor.whiteColor()
        cell.modalView.layer.cornerRadius = 15
        
        // Customize the button in the modal view
        cell.gotitButton.layer.cornerRadius = 20
        cell.gotitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cell.gotitButton.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 38/255, blue: 97/255, alpha: 0.75)
        
        // Customize the message label on the modal
        
        cell.messageLabel.textColor = UIColor.darkGrayColor()
        cell.messageLabel.text = "Are you sure you want to report this outfit?"
        
        cell.cancelButton.layer.cornerRadius = 20
        cell.cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cell.cancelButton.backgroundColor = UIColor(colorLiteralRed: 43/255, green: 161/255, blue: 160/255, alpha: 0.75)

        let object = storedObjects[indexPath.row]
        cell.outfitObject = object
        cell.nameLabel.text = object["user"].username
        cell.dateLabel.text = "goodbye"
        if (object["loveCount"] != nil){
            cell.loveCountLabel.text = "\(object["loveCount"])"
        }
        else {
            cell.loveCountLabel.text = "0"
        }
        
        
        if (object["winkCount"] != nil){
            cell.winkCountLabel.text = "\(object["winkCount"])"
        }
        else {
            cell.winkCountLabel.text = "0"
        }
        
        if (object["coolCount"] != nil){
            cell.coolCountLabel.text = "\(object["coolCount"])"
        }
        else {
            cell.coolCountLabel.text = "0"
        }
        
        
        if (object["indifferentCount"] != nil){
            cell.indifferentCountLabel.text = "\(object["indifferentCount"])"
        }
        else {
            cell.indifferentCountLabel.text = "0"
        }
        
        
        
        
        if (object["deadCount"] != nil){
            
            cell.deadCountLabel.text = "\(object["deadCount"])"
        }
        else {
            cell.deadCountLabel.text = "0"
        }
        
        let date = object.createdAt!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy"
//        dateFormatter.dateFormat = "MM.dd.yy HH:mm"
        let timeStamp = dateFormatter.stringFromDate(date)
        
        cell.dateLabel.text = timeStamp
        
        
        
        
        
        
        if (object["images"] != nil){
            cell.collectionImages = object["images"] as! [PFFile]
        }
        cell.collectionView.reloadData()
        return cell
    }
    

    
}














