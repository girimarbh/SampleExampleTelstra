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
    func updateError()
    
    
}

class ProductViewModel: NSObject {
    
    var delegate : NotificationProtocal?
    var datalist = [Product]()
    var headerTittle:String?

    override init() {
    }
    // Function to Fetch Data 
    func fetchData() {
        NewtorkManager.networkmanager.retrieveAPIData(userCompletionHandler: { [weak self] productList , error in
            guard let weakSelf = self else {
                return
            }
            guard error == nil else {
                print(error!)
                self?.delegate?.updateError()
                return
            }
            guard let list = productList else {
                print("No data")
                return
            }
            
            guard let tittle = list.productTittle else {
                return
            }
            
            weakSelf.headerTittle = tittle
            weakSelf.datalist = list.productlist
            weakSelf.delegate?.updateContentOnView()
        })
    }
}
