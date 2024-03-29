//
//  ProductCell.swift
//  Sample_TableView
//
//  Created by imgadmin on 25/07/19.
//  Copyright © 2019 Wipro. All rights reserved.

import UIKit



class ProductCell : UITableViewCell {
    
    public let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let productImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        updateUII()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Function to update cell
    func updateContentOnCell(product:Product?) {
        //updateUI()
        guard let productDetails = product else {
            //print("No Content")
            return
        }
        
        if let tittle = productDetails.productName{
            productNameLabel.text = tittle
        }
        
        
        if let img = productDetails.productImage, img.count > 2{
            DownloadManager.downloadmanager.downloadImage(imageUrl: img, completion: { image in
                DispatchQueue.main.async{ [weak self] in
                    guard let weakSelf = self else { return }
                    if let image = image {
                        weakSelf.productImage.image = image
                        //use the return value
                    } else {
                        weakSelf.productImage.image = UIImage(named: "placeholder")
                    }
                }
            })
        }else{
            self.productImage.image = UIImage(named: "placeholder")

        }
        
        if let desc = productDetails.productDesc{
            print("\(desc)")
//            if desc.count < 30{
//                productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 0, height: 0, enableInsets: false)
//
//                productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: frame.size.width - 90, height: 0, enableInsets: false)
//            }
            productDescriptionLabel.text = desc
        }
        
    }
    
    func updateUI() {
        
        
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
       
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 60, height: 60, enableInsets: false)
        
    }
    
    func updateUII(){
        
    productImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 90, height: 80, enableInsets: false)

       
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
        productDescriptionLabel.anchor(top: productImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    
    }
}








