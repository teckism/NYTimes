//
//  MediaModel.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 02/02/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit

class MediaModel: NSObject {
    var type : String?
    var subtype : String?
    var metaData : [MediaMetaDataModel]?
    
    init(fromDictionary : Dictionary<String, Any>) {
        super.init()
        
        type = fromDictionary["type"] as? String
        subtype = fromDictionary["subtype"] as? String
        metaData = (fromDictionary["media-metadata"] as? [Dictionary<String, Any>] ?? []).map{MediaMetaDataModel(fromDictionary: $0)}
        
    }
}
