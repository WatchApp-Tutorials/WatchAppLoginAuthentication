//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Yogesh Bharate on 24/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import WatchKit
import Foundation
import SwiftyJSON
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

  // IBOutlets
  @IBOutlet var pendingJobs: WKInterfaceTable!
  
  @IBOutlet var pendingJobListGroup: WKInterfaceGroup!
  @IBOutlet var loginGroup: WKInterfaceGroup!
  
  // Variables
  var jsonData:JSON = nil // json data fetch from API
  let myDelegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
  var plumberId : Int = 0
  var session : WCSession!
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
      
      
  }

    override func willActivate() {
        // This method is called when watch view controller is  about to be visible to user
        super.willActivate()
      
      
      if WCSession.isSupported() {
        session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
      }
      checkForiPhoneLogin()
  }
      
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
  
  @IBAction func RetryAgain() {
    sendMessageToiPhone()
  }
  
  
  func sendMessageToiPhone() {
    let sendMessage = ["sendPlumberId" : true]
      
//      if session.reachable {
        session.sendMessage(sendMessage, replyHandler:{(response)-> Void in
          self.plumberId = response["userId"] as! Int
          print("plumberID Watch : \(self.plumberId)")
          pref.setInteger(self.plumberId, forKey: "userId")
          if self.plumberId > 0 {
            self.sendPostRequestForAssignWork(self.plumberId)
          }
          }, errorHandler: {(error)-> Void in
            print("Error WATCH: \(error)")
        })
//      } else {
//        print("WATCH::Session is not reachable.")
//      }
  }
  
  // MARK: Assign Work Module
  func sendPostRequestForAssignWork(plumId: Int) {
    //if let custId = 25 {
    loginGroup.setHidden(true)
    pendingJobListGroup.setHidden(false)
    let pendingJobsService = PendingJobService()
    var allCustomers = [JSON]()
    
    pendingJobsService.getData(plumId , completion : { (json, error) -> Void in
      self.jsonData = json
      if error != nil {
        print("error")
      }
      else {
        allCustomers = self.getPendingJobsList(json)
        self.jsonData = JSON(allCustomers)
        guard self.jsonData.count != 0 else {
          let alertAction = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler: { ()->Void in
            print("Default")
            self.popToRootController()
          })
          
          self.presentAlertControllerWithTitle("Hooray !!!", message: "No Pending Jobs !!!", preferredStyle: WKAlertControllerStyle.Alert, actions: [alertAction])
          return
        }
        self.setUpTable(allCustomers)
      }
    })
  }
  
  func getPendingJobsList(data: JSON)->[JSON] {
    
    var pendingJobList = [JSON]()
    for (var i = 0; i < data.count; i++ ) {
      let status = data[i]
      if status["status"] == "active" {
        pendingJobList.append(status)
      }
    }
    return pendingJobList
  }
  
  // MARK: Table Methods
  func setUpTable(assignJobs: [JSON]) {
    
    self.pendingJobs.setNumberOfRows(assignJobs.count, withRowType: "PendingJobList")
    
    for index in 0..<self.pendingJobs.numberOfRows {
      if let controller = self.pendingJobs.rowControllerAtIndex(index) as? PendingJobList {
        let user = self.jsonData[index]
        controller.customerName.setText(user["customerName"].string)
      }
    }
  }

  func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
    let logout = message["logout"] as! Int
    let plumId = message["plumberId"] as! Int
    if logout == 1 {
      plumberId = plumId
      pref.removeObjectForKey("userId")
      checkForiPhoneLogin()
    }
  }
  
  func checkForiPhoneLogin() {
    plumberId = pref.integerForKey("userId")
    // Check for available plumberId.
    if plumberId == 0 {
      loginGroup.setHidden(false)
      pendingJobListGroup.setHidden(true)
    } else {
      loginGroup.setHidden(true)
      pendingJobListGroup.setHidden(false)
      sendPostRequestForAssignWork(plumberId)
    }
  }
  
  func sessionWatchStateDidChange(var session: WCSession) {
    if (WCSession.isSupported()) {
      session = WCSession.defaultSession()
      session.delegate = self
      session.activateSession()
    }
  }
  
}
