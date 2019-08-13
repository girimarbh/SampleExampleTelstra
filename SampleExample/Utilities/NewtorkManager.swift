//
//  NewtorkManager.swift
//  SampleExample
//
//  Created by imgadmin on 26/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

public class NewtorkManager: NSObject {
    
    static public let networkmanager = NewtorkManager()
    
    public override init() {

    }
    
    func retrieveAPIData(userCompletionHandler : @escaping (ProductList? , NSError?) -> Void) {
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
                print(error!)
                
                DispatchQueue.main.async{
                    userCompletionHandler(nil , error as NSError?)
                }
                
                return
            }
            
            guard let json = data else {
                print("No data")
                return
            }
            
            guard json.count != 0 else {
                print("Zero bytes of data")
                return
            }
            print(String(decoding: json, as: UTF8.self))
            if let dict = self.convertToDictionary(text: String(decoding: json, as: UTF8.self)){
                ObjectMapper.objectmapper.map(dict: dict)
                DispatchQueue.main.async{
                    userCompletionHandler(ObjectMapper.objectmapper.productList , nil)
                }
            }
        }
        task.resume()
    }
    
   private func convertToDictionary(text: String) -> [String: Any]? {
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

