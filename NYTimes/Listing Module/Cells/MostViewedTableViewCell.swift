//
//  MostViewedTableViewCell.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 01/02/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit
import SDWebImage


class MostViewedTableViewCell: UITableViewCell {
     @IBOutlet weak var imageViewForMainImage: UIImageView!
     @IBOutlet weak var labelForTitle: UILabel!
     @IBOutlet weak var labelForBy: UILabel!
     @IBOutlet weak var labelForPublishedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func loadCell(news : NewsModel){
        
        self.labelForTitle.text = news.title ?? ""
        self.labelForBy.text = news.byline ?? ""
        self.labelForPublishedDate.text = news.publishedDate ?? ""
         
        
        if let images = news.media?.filter({$0.type == "image"}), images.count > 0 ,  let filteredMetaData = images.first!.metaData?.filter({$0.format == "Standard Thumbnail"}), filteredMetaData.count > 0{
            imageViewForMainImage.sd_setImage(with: URL(string: filteredMetaData.first!.url ?? ""), placeholderImage: UIImage(named: "icon"));
         }
        else{
            self.imageViewForMainImage.image = UIImage(named: "icon");
        }
        
        
    }
}
