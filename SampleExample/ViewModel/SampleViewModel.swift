//
//  SampleViewModel.swift
//  SampleExample
//
//  Created by imgadmin on 26/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

// Protocal to notify tableview content is fetched
protocol NotificationProtocal {
    func updateContentOnView()
}

class SampleViewModel: NSObject {
    
    var delegate : NotificationProtocal?
    var datalist = [Product]()
    var headerTittle:String?

    override init() {
    }
    // Function to Fetch Data 
    func fetchData() {
        NewtorkManager.networkmanager.retrieveAPIData(userCompletionHandler: { dict , error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let json = dict else {
                print("No data")
                return
            }
            guard let tittle = json["title"] as? String else {
                return
            }
            
            self.headerTittle = tittle
            
            guard let jsonArray = json["rows"] as? [[String: Any]] else {
                return
            }
            //Clear Content before updated
            self.datalist.removeAll()
            //print("Total Products:\(jsonArray)")
            for json in jsonArray
            {
                self.datalist.append(Product(productName: json["title"] as? String ?? "", productImage: json["imageHref"] as? String ?? "" , productDesc: json["description"] as? String ?? ""))
            }
            self.delegate?.updateContentOnView()
        })
    }
}
