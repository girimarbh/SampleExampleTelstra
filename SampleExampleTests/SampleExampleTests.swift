//
//  SampleExampleTests.swift
//  SampleExampleTests
//
//  Created by imgadmin on 30/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import XCTest



class SampleExampleTests: XCTestCase {

    var vc : UIViewController!
    override func setUp() {
        
        var rootWindow: UIWindow!
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
         vc = rootWindow.rootViewController
        
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testThatViewLoads()
    {
        
        XCTAssertNotNil(vc?.view, "View not initiated properly");
    }
    func testParentViewHasTableViewSubview() {
        
        let subviews = vc?.view.subviews
        XCTAssertTrue((subviews as! NSArray).contains(UITableView()), "View does not have a table subview")
    }
    
    func testThatTableViewLoads()
    {
       
    }
    func testNetwork() {
        

     let baseURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var request: URLRequest = URLRequest(url: URL(string: baseURL)!)
    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "GET"
 // Request the data
    let session: URLSession = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
 // print(data!.count)
 // Did we get an error?
    guard error == nil else {
   XCTAssertNil(error)
    print(error!)
        return
        }
        
        guard let json = data else {
            XCTFail()
            return
        }
        
        guard json.count != 0 else {
            XCTAssertNil(json)
            print("Zero bytes of data")
            return
        }
        
        }
        task.resume()
 
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(vc is UITableViewDataSource, "View does not conform to UITableView datasource protocol")
    }
    
    func testThatTableViewHasDataSource() {

        XCTAssertNotNil(vc.tableView.dataSource, "Table datasource cannot be nil")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue(vc is UITableViewDelegate, "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(vc is UITableViewDelegate, "Table delegate cannot be nil")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
