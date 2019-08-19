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
        
        if let json = self.convertToDictionary(text: String(decoding: json, as: UTF8.self)){
//            guard let json = dict else {
//                print("No data")
//                return
//            }
            guard let tittle = json["title"] as? String else {
                return
            }
            let expectedTitle = "About Canada"
            XCTAssertEqual(tittle, expectedTitle)
            

            
            guard let jsonArray = json["rows"] as? [[String: Any]] else {
                return
            }
            
            let  json = jsonArray[0]
            let expectedjsonTitle = "Beavers"
            let actualjsontittle = json["title"] as? String
            XCTAssertEqual(expectedjsonTitle, actualjsontittle)
            
            
            let expectedDescription = "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony"
            let actualDescription = json["description"] as? String
            XCTAssertEqual(expectedDescription, actualDescription)
                
                
            
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
    
    func testParsing(){
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
            
            if let json = self.convertToDictionary(text: String(decoding: json, as: UTF8.self)){
                //            guard let json = dict else {
                //                print("No data")
                //                return
                //            }
                guard let tittle = json["title"] as? String else {
                    return
                }
                let expectedTitle = "About Canada"
                XCTAssertEqual(tittle, expectedTitle)
                
                
                
                guard let jsonArray = json["rows"] as? [[String: Any]] else {
                    return
                }
                
                let  json = jsonArray[0]
                let expectedjsonTitle = "Beavers"
                let actualjsontittle = json["title"] as? String
                XCTAssertEqual(expectedjsonTitle, actualjsontittle)
                
                
                let expectedDescription = "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony"
                let actualDescription = json["description"] as? String
                XCTAssertEqual(expectedDescription, actualDescription)
                
                
                
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
        
    
    
     func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
   

 
}
