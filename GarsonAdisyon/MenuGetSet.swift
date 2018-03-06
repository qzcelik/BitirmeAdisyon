//
//  MenuGetSet.swift
//  GarsonAdisyon
//
//  Created by Air on 6.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class MenuGetSet{

    var productName : String
    var productPrice : String
    var productNo : String
    var productInfo : String
    var productCategory : String
    
    init (productName: String,productPrice: String, productNo: String,productInfo: String, productCategory: String)
    {
        self.productNo = productNo
        self.productInfo = productInfo
        self.productName = productName
        self.productPrice = productPrice
        self.productCategory = productCategory
    }
    
    func productNoGet() -> String
    {
        return productNo
    }
    
    func productNameGet() -> String
    {
        return productName
    }
    
    func productPriceGet() -> String
    {
        return productPrice
    }
    
    func productInfoGet() -> String
    {
        return productInfo
    }
   
    func productCategoryGet() -> String{
        return productCategory
    }

}
