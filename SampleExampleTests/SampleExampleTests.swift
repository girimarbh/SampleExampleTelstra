//
//  SampleExampleTests.swift
//  SampleExampleTests
//
//  Created by imgadmin on 30/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import XCTest

class SampleExampleTests: XCTestCase {

    
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
