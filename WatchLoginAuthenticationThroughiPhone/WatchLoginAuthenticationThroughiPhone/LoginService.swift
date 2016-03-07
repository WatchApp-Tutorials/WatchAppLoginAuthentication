//
//  LoginService.swift
//  PunePlumbers
//
//  Created by Yogesh Bharate on 21/09/15.
//  Copyright (c) 2015 Yogesh Bharate. All rights reserved.
//

import Foundation
import SwiftyJSON

public class LoginService : NSObject {
  public func loginDetails(username : String, password : String,  completion : (Bool)-> Void) {
    var status : Bool = false
    // Encode the enter password with base64
    let encryptedPassword : String = base64Encode(password)
    
    // create parameters
    let deviceString : String = "mobile"
    let parameters: [String: String] = ["userName" : username, "password": encryptedPassword, "device": deviceString]
    let helper = helperClass()
    
    helper.sendRequest(login, para: parameters, completion: {(json) -> Void in
      
      if json != nil {
        let un = json["userName"].string
        
        if un != nil {
          let pas = json["password"].string
          let userId = json["userId"].int
//          let imageUrl = json["photoUrl"].string
//          let password = json["password"].string
//          appDelegate?.userId = userId
//          appDelegate?.profileImageUrl = imageUrl
//          
//          prefs.setInteger(1, forKey: "isLoggedIn")
//            let plumberId = String(userId!)
//            pref.setObject(plumberId, forKey: "userId")
            pref.setInteger(userId!, forKey: "userId")
            let plumId = pref.integerForKey("userId")
            print("PlumberID : \(plumId)")
//          prefs.setObject(imageUrl, forKey: "imageUrl")
//          prefs.setObject(password, forKey: "password")
          
          if un == username {
            if pas == encryptedPassword {
              status = true
            }
          }   else {
            status = false
          }
        }
      }
      completion(status)
    })
  }
  
  // Use to encrypt the user password.
  func base64Encode(password : String)->String{
    // base64 Encode
    let plainData = password.dataUsingEncoding(NSUTF8StringEncoding)
    let base64String  = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    return base64String!
  }
  
}