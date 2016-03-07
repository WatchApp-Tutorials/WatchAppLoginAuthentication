//
//  helperClass.swift
//  PunePlumbers
//
//  Created by Yogesh Bharate on 22/09/15.
//  Copyright (c) 2015 Yogesh Bharate. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public class helperClass {
  
  public func sendRequest(url : String, para : [String: AnyObject]? = nil, completion:(JSON) -> Void )
  {
    Alamofire.request(.POST, url, parameters: para, encoding: .JSON)
      .validate(statusCode: 200..<300)
      .responseJSON{ response in
        // Check for error handling
        guard response.result.error == nil else {
          print(response.result.error!.localizedDescription)
          return
        }
        
        // Check for response
        if let value: AnyObject = response.result.value {
          let data = JSON(value)
          print("Response : \(data)")
          completion(data)
        }

    }
  }
}