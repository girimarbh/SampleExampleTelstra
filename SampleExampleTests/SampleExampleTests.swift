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
        vc = rootWindow.rootViewController as? UITableViewController
     // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
       
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // check view is loaded
    func testThatViewLoads()
    {
        XCTAssertNotNil(vc?.view, "View not initiated properly");
    }
    // check for tabelview is subview
    func testParentViewHasTableViewSubview() {
        var rootWindow: UIWindow!
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        vc = rootWindow.rootViewController as? UITableViewController
        let subviews = vc?.view.subviews
       // XCTAssertTrue((subviews )!.contains(UITableView()), "View does not have a table subview")
    }
    
    func testTitleForTable()
    {
        //XCTAssertNil(vc?.view.tableview.title, "title should not nil")
        //XCTAssertEqual(vc?.view.tableview.title, "About Canada", "Title not Matches")
       
    }
    
      // check whether conforms for UITableViewDataSource
    func testThatViewConformsToUITableViewDataSource() {
       // XCTAssertTrue(self.vc.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    
    func testThatTableViewHasDataSource() {
        
        XCTAssertNotNil(vc is UITableViewDataSource, "Table datasource cannot be nil")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
       XCTAssertTrue(self.vc.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(vc is UITableViewDelegate, "Table delegate cannot be nil")
    }
    
    // Test for Network API
    func testNetworkAPI() {
    let baseURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var request: URLRequest = URLRequest(url: URL(string: baseURL)!)
    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "GET"
 // Request the data
    let session: URLSession = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        
        
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                XCTAssertEqual(statusCode, 200, "status code was  200") // check for status code 200 success
                return;
            }
            else{
                 XCTFail()
            }
        }
        
        
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
            XCTFail()
            print("Zero bytes of data")
            return
        }
        
        }
        task.resume()
 
    }
    
    
    
    

}
