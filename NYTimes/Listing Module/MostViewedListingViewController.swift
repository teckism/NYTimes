//
//  MostViewedListingViewController.swift
//  NYTimes
//
//  Created by Pankaj Teckchandani on 25/01/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import UIKit

class MostViewedListingViewController: NYBaseViewController {
    @IBOutlet weak var tableViewForMostViewListing: UITableView!
    var dataCtlr : MostViewedListingDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if dataCtlr == nil {
            self.dataCtlr = MostViewedListingDataController()
        }
        self.tableViewForMostViewListing.dataSource = self;
        self.tableViewForMostViewListing.delegate = self;
        
        registerNibs()
        self.tableViewForMostViewListing.tableFooterView = UIView()
        
        
        self.dataCtlr?.getMostViewed(onSuccess: {
            
            DispatchQueue.main.async {
                self.tableViewForMostViewListing.reloadData();
            }
        }, onFailure: { (message) in
            
        })
    }
    
    func registerNibs(){
        
        let nibForMostViewedCell = UINib.init(nibName: "MostViewedTableViewCell", bundle: Bundle.main)
        self.tableViewForMostViewListing.register(nibForMostViewedCell, forCellReuseIdentifier: Constants.CellIdentifiers.kMostViewedTableViewCellIdentifier)
    }
}

extension MostViewedListingViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataCtlr?.arrayOfMostViewedNews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.kMostViewedTableViewCellIdentifier) as! MostViewedTableViewCell
        cell.selectionStyle = .none
        cell.loadCell(news : (self.dataCtlr?.arrayOfMostViewedNews![indexPath.row])!);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
