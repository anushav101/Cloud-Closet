//
//  LoginViewController.swift
//  Outfit Me_2
//
//  Created by Anusha Venkatesan on 8/5/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import Parse

var signedUp = false

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var counter = 1
    var timer = NSTimer()
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    
    func doAnimation() {
        if counter == 1 {
            counter = 2
        }
        else {
            counter = 1
        }
        imageView.image = UIImage(named: "frame\(counter).png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.\
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(LoginViewController.doAnimation), userInfo: nil, repeats: true)
        
        self.logInButton.layer.borderWidth = 2
        self.logInButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        self.signUpButton.layer.borderWidth = 2
        self.signUpButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        
        self.usernameField.autocorrectionType = .No
        self.passwordField.autocorrectionType = .No
        self.firstnameField.autocorrectionType = .No
        self.lastnameField.autocorrectionType = .No
        
        self.firstnameField.hidden = true
        self.lastnameField.hidden = true
        self.usernameField.hidden = true
        self.passwordField.hidden = true
        self.confirmButton.hidden = true
        self.confirmPasswordField.hidden = true
        
        confirmButton.titleLabel?.text! = "Sign Up"
        
        
        logInButton.layer.contents = 25
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        firstnameField.attributedPlaceholder = NSAttributedString(string:" firstname",
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        lastnameField.attributedPlaceholder = NSAttributedString(string:" email",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        usernameField.attributedPlaceholder = NSAttributedString(string:" username",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        passwordField.attributedPlaceholder = NSAttributedString(string:" password",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        passwordField.attributedPlaceholder = NSAttributedString(string:" password",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        
        confirmPasswordField.attributedPlaceholder = NSAttributedString(string:" confirm password",
                                                                        attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        logInButton.layer.cornerRadius = 15;
        signUpButton.layer.cornerRadius = 15;
        confirmButton.layer.borderWidth = 2;
        confirmButton.layer.borderColor = UIColor.whiteColor().CGColor
        confirmButton.layer.cornerRadius = 15;
        firstnameField.layer.cornerRadius = 16
        lastnameField.layer.cornerRadius = 16
        usernameField.layer.cornerRadius = 16
        passwordField.layer.cornerRadius = 16
        confirmButton.layer.cornerRadius = 15
        confirmPasswordField.layer.cornerRadius = 15
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func logInPressed(sender: UIButton) {
        
        
        
        self.firstnameField.hidden = true
        self.lastnameField.hidden = true
        self.confirmPasswordField.hidden = true
        self.usernameField.hidden = false
        self.passwordField.hidden = false
        self.confirmButton.hidden = false
        self.logInButton.layer.zPosition = 5
        self.signUpButton.layer.zPosition = 0
        self.logInButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.signUpButton.backgroundColor = UIColor.clearColor()
        self.signUpButton.layer.borderWidth = 0
        
        self.logInButton.setTitle("Log In", forState: UIControlState.Normal)
        self.logInButton.setTitle("Log In", forState: UIControlState.Highlighted)
        self.confirmButton.setTitle("Log In", forState: UIControlState.Normal)
        self.confirmButton.setTitle("Log In", forState: UIControlState.Highlighted)
        
        
    }
    
    
    @IBAction func signUpPressed(sender: UIButton) {
        
        self.usernameField.hidden = false
        self.passwordField.hidden = false
        self.firstnameField.hidden = false
        self.lastnameField.hidden = false
        self.confirmButton.hidden = false
        self.confirmPasswordField.hidden = false
        self.logInButton.layer.zPosition = 0
        self.signUpButton.layer.zPosition = 5
        self.signUpButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.logInButton.layer.borderWidth = 0
        self.logInButton.backgroundColor = UIColor.clearColor()
        
        
        self.signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
        self.signUpButton.setTitle("Sign Up", forState: UIControlState.Highlighted)
        self.confirmButton.setTitle("Sign Up", forState: UIControlState.Normal)
        self.confirmButton.setTitle("Sign Up", forState: UIControlState.Highlighted)
        
        
        
        
        
    }
    
    func checkSpaces(str: String) -> Bool{
        
        var arr = Array(arrayLiteral: str)
        
        if arr[0] == " "{
            return false
        }
        if arr[arr.count - 1] == " "{
            return false
        }
        return true
        
    }
    
    //GARLIC BREAD - PAVANI MALLI
    @IBAction func confirmPressed(sender: UIButton) {
        
        if firstnameField.hidden == true {
            
            if usernameField.text != "" && passwordField.text != "" {
                
                
                
                PFUser.logInWithUsernameInBackground(usernameField.text!.stringByTrimmingCharactersInSet(
                    NSCharacterSet.whitespaceAndNewlineCharacterSet()
                    ), password:passwordField.text!.stringByTrimmingCharactersInSet(
                        NSCharacterSet.whitespaceAndNewlineCharacterSet()
                )) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // Do stuff after successful login.
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") // again change to your view
                        self.showViewController(vc as! UITabBarController, sender: vc) // change again
                        
                    } else {
                        // The login failed. Check error to see why.
                        let alert = UIAlertController(title: "Oops", message: "Something went wrong, try different information.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Sorry", message: "You need to fill out every field.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
            
            
        else {
            
            //put it here
            signedUp = true
            
            if usernameField.text!.isEmptyOrWhitespace()  || passwordField.text!.isEmptyOrWhitespace() || firstnameField.text!.isEmptyOrWhitespace() || lastnameField.text!.isEmptyOrWhitespace() || confirmPasswordField.text!.isEmptyOrWhitespace(){
                
                let alert = UIAlertController(title: "Sorry", message: "Please fill in all of the information", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
            if ( passwordField.text!.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
                )
                != confirmPasswordField.text!.stringByTrimmingCharactersInSet(
                    NSCharacterSet.whitespaceAndNewlineCharacterSet()
                )
                ) {
                let alert = UIAlertController(title: "", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
            
            
            let user = PFUser()
            
            user.username = usernameField.text!.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
            )
            user.password = passwordField.text!.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
            )
            user["firstName"] = firstnameField.text!.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
            )
            user["email"] = lastnameField.text!.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
            )
            user["public"] = "true"
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    _ = error.userInfo["error"] as? NSString
                    
                    print("UGH")
                    let alert = UIAlertController(title: "", message: "Unverified Email", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") // again change to your view
                    self.showViewController(vc as! UITabBarController, sender: vc) // change again
                    print("YES")
                }
            }
            
        }
     
    }
    
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        if(self.isEmpty) {
            return true
        }
        
        return (self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "")
        
        
        
    }
}


