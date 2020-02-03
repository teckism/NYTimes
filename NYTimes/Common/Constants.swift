//
//  Constants.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 28/01/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit


public struct Constants {
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    struct Alerts {
           static let kUnableToReachServer = "Unable to reach server"
           static let TRY_AGAIN = "Try Again"
           static let ERROR_KEY = "Error"
           static let OK = "Ok"
       }
      
    
    struct ApiKeys {
           static let kApiKey = "0lWzEwsZGThPRnHBsiA98a5BTRbbgNWv"
 
    }
      
    
    struct WebServices {
        static let kMostViewed = "mostpopular/v2/viewed/1.json"
        static let kLogin = ""
    }
    
    //Can be used for base urls from various sources
    struct BaseUrls {
        static let kAPIBaseUrl = "https://api.nytimes.com/svc/";
        static let kImageBaseUrl = "";
    }
    
    
    
    struct CellIdentifiers {
          static let kMostViewedTableViewCellIdentifier = "mostViewedCell"
         
        
      }
}
