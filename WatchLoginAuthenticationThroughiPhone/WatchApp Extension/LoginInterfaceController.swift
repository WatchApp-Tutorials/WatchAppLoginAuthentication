//
//  LoginInterfaceController.swift
//  WatchLoginAuthenticationThroughiPhone
//
//  Created by Yogesh Bharate on 03/03/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import WatchKit
import Foundation


class LoginInterfaceController: WKInterfaceController {

    // Variables
    var plumberId = 0
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
      plumberId = pref.integerForKey("userId")
      if plumberId > 0 {
        pushControllerWithName("MainVc", context: nil)
      }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
