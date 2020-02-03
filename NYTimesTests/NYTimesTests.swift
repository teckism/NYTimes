//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Pankaj Teckchandani on 25/01/20.
//  Copyright © 2020 NYTimes. All rights reserved.
//

import XCTest
import SDWebImage
@testable import NYTimes


class NYTimesTests: XCTestCase {
    
    
    var listingViewController : MostViewedListingViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
        
        self.listingViewController = storyboard.instantiateViewController(identifier: "mostViewedListingVC")
        let dataCtlr = MockMostViewedListingDataController();
        self.listingViewController.dataCtlr = dataCtlr
        
        self.listingViewController?.loadView()
        self.listingViewController?.viewDidLoad()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testListingTableView() {
        
        // Datasource Test Cases
        
        XCTAssertTrue((self.listingViewController?.conforms(to: UITableViewDataSource.self))!,"View does not conform to UITableView datasource protocol");
        XCTAssertNotNil(self.listingViewController?.tableViewForMostViewListing.dataSource, "Table datasource cannot be nil")
        
        
        //Delegate Test Cases
        XCTAssertTrue((self.listingViewController?.conforms(to: UITableViewDelegate.self))!,"View does not conform to UITableView datasource protocol");
        XCTAssertNotNil(self.listingViewController?.tableViewForMostViewListing.delegate, "Table delegate cannot be nil")
        
        
        
        
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.listingViewController?.tableView(self.listingViewController.tableViewForMostViewListing, cellForRowAt: indexPath)
        
        let expectedReuseIdentifier = Constants.CellIdentifiers.kMostViewedTableViewCellIdentifier
        
        XCTAssertTrue(cell?.reuseIdentifier == expectedReuseIdentifier, "Table does not create reuseable cells")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}



class MockMostViewedListingDataController: MostViewedListingDataController {
    override func getMostViewed(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
    {
        
        //Getting Mocked Objects from a local Json File
        do {
            
            if let file = Bundle.main.url(forResource: "testdata", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                
                let arrayOfResultsFromMockServer = (json as? Dictionary<String, Any> ?? Dictionary<String, Any>())["results"] as? [Dictionary<String, Any>] ?? []
                
                self.arrayOfMostViewedNews = arrayOfResultsFromMockServer.map{NewsModel(fromDictionary: $0)}
                
                onSuccess();
                
            }
        } catch {
            print(error.localizedDescription)
            onFailure(error.localizedDescription);
        }
    }
}
