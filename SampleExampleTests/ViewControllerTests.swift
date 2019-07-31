//
//  ViewControllerTests.swift
//  TelstraSampleTests
//
//  Created by imgadmin on 30/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import XCTest



class ViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest: UITableViewController!
    
    override func setUp() {
        super.setUp()
        var rootWindow: UIWindow!
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        viewControllerUnderTest = rootWindow.rootViewController as? UITableViewController
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    func testTableViewHastitle()
    {
       // let actualTitle = viewControllerUnderTest.tableView.title
        let expectedTitle = "About Canada"
        //XCTAssertEqual(actualTitle, expectedTitle)
        
    }
    func testTableViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) 
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "cellId"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableCellHasCorrectLabelText() {
//        let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProductCell
//        XCTAssertEqual(cell0?.productNameLabel.text, "Beavers")
//
//        let cell1 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? ProductCell
//        XCTAssertEqual(cell1?.productNameLabel.text, "Flag")
//
//        let cell2 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? ProductCell
//        XCTAssertEqual(cell2?.productNameLabel.text, "Transportation")
    }
    
    func testTableCellHasDescriptionAndTitleLableValue() {
//                let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProductCell
//                XCTAssertNotEqual(cell0?.productDescriptionLabel.text, "No Value")
                 // XCTAssertEqual(cell0?.productNameLabel.text, "No Value")
//
//                let cell1 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt:         IndexPath(row: 1, section: 0)) as? ProductCell
//                XCTAssertNotEqual(cell1?.productDescriptionLabel.text, "No Value")
                  //XCTAssertNotEqual(cell1?.productNameLabel.text, "No Value")
//
//                let cell2 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? ProductCell
//                XCTAssertNotEqual(cell2?.productDescriptionLabel.text, "No Value")
        //XCTAssertNotEqual(cell1?.productNameLabel.text, "No Value")
    }
}
