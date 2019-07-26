//
//  SampleViewModel.swift
//  SampleExample
//
//  Created by imgadmin on 26/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

protocol NotificationProtocal {
    func updateContentOnView()
}

class SampleViewModel: NSObject {
    
    var delegate : NotificationProtocal?
    var datalist = [Product]()
    override init() {
    }
    
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
            // var  strTitle = dict["title"] as? String
            guard let jsonArray = json["rows"] as? [[String: Any]] else {
                return
            }
            //print("Total Products:\(jsonArray)")
            for json in jsonArray
            {
                self.datalist.append(Product(productName: json["title"] as? String ?? "", productImage: json["imageHref"] as? String ?? "" , productDesc: json["description"] as? String ?? ""))
            }
            self.delegate?.updateContentOnView()
        })
    }
}
