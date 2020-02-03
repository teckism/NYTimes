//
//  MostViewedListingDataController.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 02/02/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit

class MostViewedListingDataController: NSObject {
    
    var arrayOfMostViewedNews : [NewsModel]?
    
    func getMostViewed(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
    {
        
        
        APIManager.sharedInstance.httpGETCall(apiFor: .MostViewed, params: [:], success: { (responseFromServer) in
            let arrayOfResultsFromServer = (responseFromServer as? Dictionary<String, Any> ?? Dictionary<String, Any>())["results"] as? [Dictionary<String, Any>] ?? []
            
            self.arrayOfMostViewedNews = arrayOfResultsFromServer.map{NewsModel(fromDictionary: $0)}
            onSuccess();
        }) { (error) in
            onFailure(error.userInfo[NSLocalizedDescriptionKey] as! String);
            
        }
    }
}
