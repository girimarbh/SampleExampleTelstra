//
//  Product.swift
//  Sample_TableView
//
//  Created by imgadmin on 25/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

// Model to map data from Json
struct Product {
    var productName : String?
    var productImage : String?
    var productDesc : String?
}

// Model to map data from Json
struct ProductList {
    var productTittle : String?
    var productlist : [Product]
    init?(with tittle:String,_ list:[Product]) {
        self.productTittle = tittle
        self.productlist = list
    }
}


