//
//  ProductShow.swift
//  GarsonAdisyon
//
//  Created by Air on 6.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class ProductShow: UIViewController {

    var screenSize = UIScreen.main.bounds
    var productGetArray = UserDefaults.standard
    var info = UITextView()
    var getedData = [String]()
    var getSetData = [MenuGetSet]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        info = UITextView(frame: CGRect(x:screenSize.width*0.2,y:screenSize.height*0.2,width:screenSize.width*0.6,height:screenSize.height*0.6))
        info.textColor = .black
        view.addSubview(info)
       
        initialize()
        
    }
    
        func initialize()
        {

            let a = productGetArray.stringArray(forKey: "urunDizi") ?? [String]()
            
            for i in a
            {
                if i != "#"
                {
                    getedData.append(i)
                }
            }
            
            for i in getedData
            {
                
              let seperateData = i.components(separatedBy: "*")
                let array = MenuGetSet(productName: seperateData[0],productPrice: seperateData[1],productNo: seperateData[2],productInfo: seperateData[3],productCategory: seperateData[4])
              getSetData.append(array)
            }
            
            for i in getSetData
            {
               info.text = i.productCategoryGet()
            }
            
        }

}
