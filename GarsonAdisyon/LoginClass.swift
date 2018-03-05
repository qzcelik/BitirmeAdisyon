//
//  LoginClass.swift
//  GarsonAdisyon
//
//  Created by Air on 12.01.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit
import Alamofire
class LoginClass{
    
    var girisBasari = false
    func login (kulAd:String,kulSifre:String) -> Bool
        {
        
        let queue = DispatchQueue(label: "com.test.com", qos: .background, attributes: [.concurrent])
        var girisOldumu = 2
            let parametreler : [String:Any] = ["islem":2]
            queue.async {
                Alamofire.request("http://ibrahimozcelik.net/bitirme/isletmeKayit.php",method:.post,parameters:parametreler,encoding:URLEncoding.httpBody).responseJSON{ response in
                    
                    let kontrol = response.response?.statusCode
                    if kontrol == 201
                    {
                        print("HATA")
                    }
                    else
                    {
                        if let json = response.result.value as? [String:Any],
                            let getJson = json["kullanicilar"] as? [[String:String]]
                        {
                            for nesne in getJson
                            {
                                let equalAd = (kulAd == nesne["kulAd"])
                                let equalSifre = (kulSifre == nesne["kulSifre"])
                                if equalAd == true && equalSifre == true
                                {
                                    print("Giriş Başarılı")
                                    girisOldumu = 1
                                    self.girisBasari = true
                                    break
                                }
                                else
                                {
                                    self.girisBasari = false
                                    girisOldumu = 0
                                }
                            }
                            if girisOldumu == 0
                            {
                                print("Giriş Başarısız 1")
                                self.girisBasari = false
                            }
                        }
                    }
                }
            }
         
            return self.girisBasari
    }
    
   

}
