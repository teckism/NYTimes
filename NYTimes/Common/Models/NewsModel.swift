//
//  NewsModel.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 02/02/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    var id : Int64?
    var url : String?
    var keywords : String?
    var section : String?
    var byline : String?
    var type : String?
    var title : String?
    var publishedDate : String?
    var source : String?
    var views : Int?
    var media : [MediaModel]?
    
    
    init(fromDictionary : Dictionary<String, Any>) {
        super.init()
        
        url = fromDictionary["url"] as? String
        keywords = fromDictionary["adx_keywords"] as? String
        section = fromDictionary["section"] as? String
        byline = fromDictionary["byline"] as? String
        type = fromDictionary["type"] as? String
        title = fromDictionary["title"] as? String
        publishedDate = fromDictionary["published_date"] as? String
        source = fromDictionary["source"] as? String
        id = fromDictionary["id"] as? Int64
        views = fromDictionary["views"] as? Int
        
        media = (fromDictionary["media"] as? [Dictionary<String, Any>] ?? []).map{MediaModel(fromDictionary: $0)}
         
   }
}
