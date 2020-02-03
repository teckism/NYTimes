//
//  APIManager.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 28/01/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit
//Use of enum to allow only specific apis to be accessed by other classes
enum APIAvailable {
    case MostViewed
}

public class APIManager: NSObject {
    static let sharedInstance = APIManager();
      
    private override init() {}
    
    func httpPOSTCall(apiFor:APIAvailable,params : NSDictionary,  success:@escaping (_ serverResponse: Any) ->(), failure:@escaping (_ error: NSError) ->())
    {
        
       var strUrl = Constants.BaseUrls.kAPIBaseUrl +
               getAPIForEnum(availableAPI: apiFor) + "?";
               let queryParams =  (params as! Dictionary<String, Any>).queryParameters
               if queryParams != "" {
                   strUrl += "&";
               }
                strUrl += "api-key=" + Constants.ApiKeys.kApiKey;
               
               
              
        
        let url = URL(string: strUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.httpShouldHandleCookies = true
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        
        do {
            let payload = try JSONSerialization.data(withJSONObject: params)
            request.httpBody = payload
            
            request.encodeParameters(parameters: params as! [String : String])
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if ((error) == nil)
                {
                    do {
                        let responseData =   try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        if let responseInDictionary = responseData as? NSDictionary {
                            
                            if(responseInDictionary.value(forKey: "status") as? String == "OK" ){
                                success(responseData)
                                
                            }
                            else {
                                let message = responseInDictionary.value(forKey: "message") ?? Constants.Alerts.kUnableToReachServer
                                let userInfo: [AnyHashable : Any] =
                                    [
                                        
                                        NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: message as! String, comment: "") ,
                                        
                                        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                                ]
                                let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                                failure(err);
                            }
                        }
                        else{
                            success(responseData)
                            
                        }
                        
                        
                    } catch _ {
                            
                            let userInfo: [AnyHashable : Any] =
                                [
                                    
                                    NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: "") ,
                                    
                                    NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                            ]
                            let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                            
                            failure(err);
                        }
                        
                    }
                    else{
                        let userInfo: [AnyHashable : Any] =
                            [
                                
                                NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: "") ,
                                
                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                        ]
                        let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                        
                        failure(err);
                    }
            }.resume()
            
        }
        catch{
            failure(error as NSError);
            print(error.localizedDescription)
        }
    }
    
    
    func httpGETCall(apiFor:APIAvailable,params : NSDictionary,  success:@escaping (_ serverResponse: Any) ->(), failure:@escaping (_ error: NSError) ->())
    {
        var strUrl = Constants.BaseUrls.kAPIBaseUrl +
        getAPIForEnum(availableAPI: apiFor) + "?";
        let queryParams =  (params as! Dictionary<String, Any>).queryParameters
        if queryParams != "" {
            strUrl += "&";
        }
         strUrl += "api-key=" + Constants.ApiKeys.kApiKey;
        
        
        do {
            let url = URL(string: strUrl)
                var request = URLRequest(url: url!)
                request.httpMethod = "GET"
                request.httpShouldHandleCookies = true
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if ((error) == nil)
                {
                    do {
                        let responseData =   try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        if let responseInDictionary = responseData as? NSDictionary {
                            
                            if(responseInDictionary.value(forKey: "status") as? String == "OK" ){
                                success(responseData)
                                
                            }
                            else {
                                let message = responseInDictionary.value(forKey: "message") ?? Constants.Alerts.kUnableToReachServer
                                let userInfo: [AnyHashable : Any] =
                                    [
                                        
                                        NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: message as! String, comment: "") ,
                                        
                                        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                                ]
                                let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                                failure(err);
                            }
                        }
                        else{
                            success(responseData)
                            
                        }
                        
                        
                    } catch let _ {
                        
                        let userInfo: [AnyHashable : Any] =
                            [
                                
                                NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: "") ,
                                
                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                        ]
                        let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                        
                        failure(err);
                    }
                    
                }
                else{
                    let userInfo: [AnyHashable : Any] =
                        [
                            
                            NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: "") ,
                            
                            NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                    ]
                    let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                    
                    failure(err);
                }
                
            }.resume()
            
        }
        catch{
            failure(error as NSError);
            
            let userInfo: [AnyHashable : Any] =
                [
                    
                    NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: error.localizedDescription) ,
                    
                    NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
            ]
            let err = NSError(domain: "NYHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
            
            failure(err);
        }
    }
}



private func getAPIForEnum(availableAPI : APIAvailable)->String {
    
    
    switch availableAPI {
    case .MostViewed:
        return Constants.WebServices.kMostViewed
   
    }
}
