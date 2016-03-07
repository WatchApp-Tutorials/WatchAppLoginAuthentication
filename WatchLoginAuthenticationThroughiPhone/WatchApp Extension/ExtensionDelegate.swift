//
//  ExtensionDelegate.swift
//  WatchApp Extension
//
//  Created by Yogesh Bharate on 24/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate{
  
//    variables
    //var session : WCSession!
    var plumberId : String?
//  var session: WCSession? {
//    didSet {
//      if let session = session {
//        session.delegate = self
//        session.activateSession()
//      }
//    }
//  }
    func applicationDidFinishLaunching() {
        // Perform any final initializati on of your application.
      
      
//      if plumberId <= 0 {
//        pushControllerWithName("LoginView", context:nil)
//        return
//      } else {
//        pushControllerWithName("MainView", context: nil)
//      }
      
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
  
//func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
//       print("In AppDelegate ::",message["plumberId"])
//        if let reference = message["plumberId"] as? String {
//            print(reference)
//            let dict = ["isMsgReceived": "True"]
//            replyHandler(dict)
//        }
//  }

}
