//
//  AppDelegate.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 7/14/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import SwiftyJSON
import AlamofireImage
import AlamofireNetworkActivityIndicator



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func testGoogleCustomSearch() {
        let bundleID = "com.makeschool.Outfit"
        
        let q = "galaxy+beanie"
        let key = "AIzaSyAjNmmSpUwAjWPq-SLWVnqLvwdEf5zHnmo"
        let cx = "017126530825900472415:6gcgyqv_ffg"
        
        let urlString = "https://www.googleapis.com/customsearch/v1?q=\(q)&key=\(key)&cx=\(cx)&searchType=image"
        
        Alamofire.request(.GET,
            urlString,
            parameters: nil,
            encoding: .JSON,
            headers: ["X-Ios-Bundle-Identifier" : bundleID])
            .responseJSON { (response) in
                print("PRINTING OUT RESPONSE:   \(response)")
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let clothingData = json["items"][0]["image"]["thumbnailLink"].stringValue
                        print("CLOTHING DATA:  \(clothingData)")
                    
                        
                }
                
                case.Failure(let error):
                    print("PRINTING OUT ERROR: \(error)")
                
             print("PRINTING OUT RESPONSE:   \(response)")
        }
    }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let configuration = ParseClientConfiguration {
            let APP_ID = "CloudCloset"
            let SERVER_URL = "https://cloudcloset-parse-av.herokuapp.com/parse"
            
            $0.applicationId = APP_ID
            $0.server = SERVER_URL
        }
        
        Parse.initializeWithConfiguration(configuration)
        
        let acl = PFACL()
        acl.publicReadAccess = true
        PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
        
//        testGoogleCustomSearch()
        
        //        let product = PFObject(className: "Product")
        //        product["category"] = "test 3"
        //        let image = UIImage(named: "trash")
        //
        //        let imageData = UIImagePNGRepresentation(image!)!
        //        let imageFile = try! PFFile(name: "image.jpg", data: imageData, contentType: "image/png")
        //        imageFile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
        //            if success {
        //                print("did save file")
        //            }
        //            else {
        //                print("could not save file: \(error)")
        //            }
        //        }
        //
        //        product["imageFile"] = imageFile
        //        product.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
        //            if success {
        //                print("did save product")
        //            }
        //            else {
        //                print("could not save product: \(error)")
        //            }
        //        }
        
        
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        else {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
        return true
    }
    
    

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

