//
//  MainViewController.swift
//  WatchLoginAuthenticationThroughiPhone
//
//  Created by Yogesh Bharate on 24/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import UIKit
import WatchConnectivity

class MainViewController: UIViewController, WCSessionDelegate {

  // Variables
    var session : WCSession!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if WCSession.isSupported() {
        session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
      }

        // Do any additional setup after loading the view.
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
  
  @IBAction func signOutButtonPress(sender: AnyObject) {
    pref.removeObjectForKey("userId")
    sendMessageToWatch()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  func sendMessageToWatch() {
    let logOut = ["logout" : 1, "plumberId" : 0]
    session.sendMessage(logOut, replyHandler: {(response)->Void in
        print("LOGOUT WATCH APP : \(response["isLogoutApp"])")
      }, errorHandler: {(error)-> Void in
        print("IPhone MainVC : \(error)")
    })
  }
  
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
    let mess = message["sendPlumberId"] as? Bool
    print(mess)
    
    if mess == true {
      let plumberId = pref.integerForKey("userId")
      
      if plumberId > 0 {
        let message = ["userId":plumberId]
        replyHandler(message)
      }
    }

  }

}
