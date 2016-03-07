//
//  Constants.swift
//  WatchLoginAuthenticationThroughiPhone
//
//  Created by Yogesh Bharate on 24/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import Foundation
import UIKit

//////////////// URLS //////////////////
let url = "http://52.35.203.72:3600/api/"
//let url = "http://localhost:3600/api/"
let login = url + "login"
let getJobList = url + "sendJobList"



/////// GLOBAL VARIABLES ///////////
var pref = NSUserDefaults.standardUserDefaults()