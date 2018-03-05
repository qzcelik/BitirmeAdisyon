//
//  ViewController.swift
//  GarsonAdisyon
//
//  Created by Air on 10.01.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
  
    var kulId  = UserDefaults.standard
    var screenSize = UIScreen.main.bounds
    var girisButon = UIButton()
    var kulAd = UITextField()
    var kulSifre = UITextField()
    var arkaPlan = UIImageView()
    var girisTextArka = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
        arkaPlan  = UIImageView(frame:CGRect(x:0,y:0,width:screenSize.width,height:screenSize.height))
        arkaPlan.image = #imageLiteral(resourceName: "bg")
        
        view.addSubview(arkaPlan)
        uiDesign()
        
        
    }
    
    func uiDesign()
    {

        girisTextArka = UIImageView(frame:CGRect(x:screenSize.width*0.15,y:screenSize.height*0.5,width:screenSize.width*0.7,height:screenSize.height*0.25))
        
         kulAd = UITextField(frame:CGRect(x:screenSize.width*0.2,y:screenSize.height*0.55,width:screenSize.width*0.6,height:screenSize.height*0.06))
         kulAd.background = #imageLiteral(resourceName: "text")
         
         kulSifre = UITextField(frame:CGRect(x:screenSize.width*0.2,y:screenSize.height*0.62,width:screenSize.width*0.6,height:screenSize.height*0.06))
         kulSifre.background = #imageLiteral(resourceName: "text")
        
        girisButon = UIButton(frame:CGRect(x:screenSize.width*0.4,y:screenSize.height*0.65,width:screenSize.width*0.2,height:screenSize.height*0.1))
        girisButon.setTitle("Giriş", for: .normal)
        girisButon.setTitleColor(.black, for: .normal)
        girisButon.addTarget(self, action:#selector(login) , for: .touchUpInside)
        
        
        view.addSubview(kulAd)
        view.addSubview(kulSifre)
        view.addSubview(girisTextArka)
        view.addSubview(girisButon)
    }
    
    @objc func login()
    {
        if (kulAd.text?.count)! < 1 || (kulSifre.text?.count)! < 1
        {
            print("Alanlar Boş Geçilemez")
        }
        else
        {
            loginUser(kulAd: kulAd.text!,kulSifre: kulSifre.text!)
        }
    }
    
    func loginUser (kulAd:String,kulSifre:String)
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
                                let profil = UserProfil()
                                print("Giriş Başarılı")
                                self.kulId.set(nesne["kulId"], forKey: "kullaniciId")
                                girisOldumu = 1
                                self.present(profil,animated:true,completion:nil)
                                break
                            }
                            else
                            {
                                girisOldumu = 0
                            }
                        }
                        if girisOldumu == 0
                        {
                            print("Giriş Başarısız")
                        }
                    }
                }
            }
        }
        
    }
    

}

