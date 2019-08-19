//
//  DownloadManager.swift
//  TelstraSample
//
//  Created by imgadmin on 13/08/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

class DownloadManager: NSObject {
    
    static public let downloadmanager = DownloadManager()
    
    public override init() {
        
    }
    
    public func downloadImage(imageUrl:String, completion: @escaping (UIImage?)->()) {
        let url = URL(string: imageUrl)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let imgData = data else {
               // print("No data")
                return
            }
            let image = UIImage(data: imgData)
            completion(image)
        }).resume()
    }

}
