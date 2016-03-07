//
//  PendingJobService.swift
//  WatchLoginAuthenticationThroughiPhone
//
//  Created by Yogesh Bharate on 24/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import WatchKit
import SwiftyJSON

class PendingJobService: NSObject {
  func getData(custId: Int, completion:(json: JSON, error: NSError?) -> Void) {
    
    // create parameters
    let parameters: [String: String] = ["plumberId" : "\(custId)"]
    
    let helper = helperClass()
    helper.sendRequest(getJobList, para: parameters, completion: {(json) -> Void in
      print("PendingJob : \n  \(json)")
      completion(json:json, error: nil)
    })
  }
}
