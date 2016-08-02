//
//  OutfitBuilderViewController.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/28/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

class OutfitBuilderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var categoryOutfitProvider = [TopsOutfitProvider.sharedInstance, BottomsOutfitProvider.sharedInstance, OuterwearOutfitProvider.sharedInstance, DressesOutfitProvider.sharedInstance, AccessoriesOutfitProvider.sharedInstance, ShoesOutfitProvider.sharedInstance]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}

extension OutfitBuilderViewController: UITableViewDataSource{
    
    
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
    

}

