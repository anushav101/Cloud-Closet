//
//  FriendOutfitViewController.swift
//  Cloud Closet
//
//  Created by Anusha Venkatesan on 8/12/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

class FriendOutfitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("FriendViewController") // again change to your view
        self.navigationController?.pushViewController(vc as! FriendViewController, animated: true)
        
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
