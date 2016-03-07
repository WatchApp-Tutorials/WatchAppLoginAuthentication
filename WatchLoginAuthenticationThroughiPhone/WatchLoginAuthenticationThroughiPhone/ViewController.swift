//
//  ViewController.swift
//  WatchLoginAuthenticationThroughiPhone
//
//  Created by Yogesh Bharate on 24/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

  // IBOutets
  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var password: UITextField!
  
  // Variables
   var plumberId : Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func signIn(sender: AnyObject) {
    let username : String = self.username.text!
    let pass : String = self.password.text!
    
    if !username.isEmpty && !pass.isEmpty {
      checkLogin(username, password: pass, savePassword: true)
    }
  }
  
  func checkLogin(username: String, password: String, savePassword:Bool) {
    let loginService = LoginService()
    loginService.loginDetails(username, password: password, completion : { (status) -> Void in
      
      if status == true {
        if savePassword {
          dispatch_async(dispatch_get_main_queue(), {
          let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("MainVC") as! MainViewController
          self.navigationController?.pushViewController(viewController, animated: false)
          })
        }
        
      } else {
        // Show the AlertView
        let alertController = UIAlertController(title:"Warning", message:"Username or Password is invalid !!!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    })
    
  }

}

