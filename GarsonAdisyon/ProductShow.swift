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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        info = UITextView(frame: CGRect(x:screenSize.width*0.2,y:screenSize.height*0.2,width:screenSize.width*0.6,height:screenSize.height*0.6))
        info.textColor = .black
        view.addSubview(info)
        
        info.text = productGetArray.object(forKey: "urunDizi") as! String
        
    }

}
