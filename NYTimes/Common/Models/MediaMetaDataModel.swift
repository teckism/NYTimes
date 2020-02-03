//
//  MediaMetaDataModel.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 02/02/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit

class MediaMetaDataModel: NSObject {
    
    var url : String?
    var format : String?
    
    init(fromDictionary : Dictionary<String, Any>) {
        super.init()
        
        url = fromDictionary["url"] as? String
        format = fromDictionary["format"] as? String
    }
}
