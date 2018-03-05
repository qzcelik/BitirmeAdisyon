//
//  TakeMoney.swift
//  GarsonAdisyon
//
//  Created by Air on 6.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit
import Alamofire

class TakeMoney{
    
    var userId : String
    init(userId: String)
    {
        self.userId = userId
    }
    
    func deleteData()
    {
        let parametre: [String:String] = ["masaNo": self.userId]
        Alamofire.request("http://ibrahimozcelik.net/bitirme/AdisyonIslemleri.php",method: .post,parameters: parametre,encoding: URLEncoding.httpBody).responseJSON{
            response in
        }
    }
}
