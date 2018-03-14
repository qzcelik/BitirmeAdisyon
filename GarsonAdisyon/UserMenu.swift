//
//  UserMenu.swift
//  GarsonAdisyon
//
//  Created by Air on 6.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit
import Alamofire
class UserMenu: UIViewController {

    var userName = UserDefaults.standard
    var setProductArray = UserDefaults.standard
    var kulId = String()
    var countCharacter  = Int()
    var screenSize = UIScreen.main.bounds
    var dinnerButton = UIButton()
    var drinkButton = UIButton()
    var dessertButton = UIButton()
    var fastfoodButton = UIButton()
    var soupButton = UIButton()
    var backButton = UIButton()
    var productArray = [MenuGetSet]()
    var counterProduct = Int()
    var sendetData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        uiElement()
        getMenuData()
    }
    
    func uiElement()
    {
        dinnerButton = UIButton(frame:CGRect (x: screenSize.width*0.1,y: screenSize.height*0.2,width: screenSize.width*0.3,height: screenSize.height*0.1))
        dinnerButton.setTitle("Yemekler", for: .normal)
        dinnerButton.backgroundColor = .red
        dinnerButton.addTarget(self, action: #selector(dinnerFunc), for: .touchUpInside)
        
        drinkButton = UIButton(frame:CGRect (x: screenSize.width*0.6,y: screenSize.height*0.2,width: screenSize.width*0.3,height: screenSize.height*0.1))
        drinkButton.setTitle("İçecek", for: .normal)
        drinkButton.backgroundColor = .red
        
        dessertButton = UIButton(frame:CGRect (x: screenSize.width*0.1,y: screenSize.height*0.4,width: screenSize.width*0.3,height: screenSize.height*0.1))
        dessertButton.setTitle("Tatlı", for: .normal)
        dessertButton.backgroundColor = .red
        
        fastfoodButton = UIButton(frame:CGRect (x: screenSize.width*0.6,y: screenSize.height*0.4,width: screenSize.width*0.3,height: screenSize.height*0.1))
        fastfoodButton.setTitle("Fast Food", for: .normal)
        fastfoodButton.backgroundColor = .red

        
        soupButton = UIButton(frame:CGRect (x: screenSize.width*0.35,y: screenSize.height*0.6,width: screenSize.width*0.3,height: screenSize.height*0.1))
        soupButton.setTitle("Çorbalar", for: .normal)
        soupButton.backgroundColor = .red
        
        backButton = UIButton(frame:CGRect (x: screenSize.width*0.05,y: screenSize.height*0.05,width: screenSize.width*0.1,height: screenSize.height*0.05))
        backButton.setTitle("Geri", for: .normal)
        backButton.backgroundColor = .blue
        backButton.addTarget(self, action: #selector(backScreen), for: .touchUpInside)
        
        view.addSubview(dinnerButton)
        view.addSubview(drinkButton)
        view.addSubview(dessertButton)
        view.addSubview(fastfoodButton)
        view.addSubview(soupButton)
        view.addSubview(backButton)
    }
    
    
    func getMenuData()
    {
        for i in (userName.string(forKey: "kullaniciId")?.characters)!
        {
            countCharacter += 1
            kulId  += String(i)
            if(countCharacter == 2)
            {
                break
            }
        }
        
        var parametre : [String:Any] = ["kulAd":kulId]
        
        Alamofire.request("http://ibrahimozcelik.net/bitirme/MenuGetir.php", method: .post, parameters: parametre, encoding: URLEncoding.httpBody).responseJSON{
            response in
            
            if let json = response.result.value as? [String:Any],
            let getJson = json["urunListe"] as? [[String:String]]
            {
                for parseJson in getJson
                {
                    let array = MenuGetSet(productName: parseJson["adi"]!,productPrice: parseJson["fiyati"]!,productNo: parseJson["nosu"]!, productInfo: parseJson["bilgisi"]!, productCategory: parseJson["kategori"]!)
                    self.productArray.append(array)
                    
                }
            }
            
        }
    }
    
    
    func filtering(dataArray:String)
    {
        for i in productArray
        {
            if i.productCategory != dataArray
            {
                productArray.remove(at: counterProduct)
                counterProduct = 0
            }
            counterProduct += 1
        }
        for i in productArray
        {
            sendetData.append(i.productNameGet() + "*" + i.productPriceGet() + "*" + i.productNoGet() + "*" + i.productInfoGet() + "*" + i.productCategoryGet())
            sendetData.append("#")
        }
        //setProductArray.set(productArray.description, forKey: "urunDizi")
        setProductArray.set(sendetData, forKey: "urunDizi")
       // var show = ProductShow()
        //self.present(show,animated: true,completion: nil )
   	    var s = MenuList()
        self.present(s,animated: true,completion: nil)
    }
    
    
    @objc func dinnerFunc()
    {
        filtering(dataArray: "anaYemek")
        
    }
    
    @objc func drinkfunc()
    {
        filtering(dataArray: "icecek")
    }
    
    @objc func dessertFunc()
    {
        filtering(dataArray: "tatli")
    }
    
    @objc func soupFunc()
    {
        filtering(dataArray: "corba")
    }
    
    @objc func fastFoodFunc()
    {
        filtering(dataArray: "fastfood")
    }
    
    @objc func backScreen()
    {
        dismiss(animated: true, completion: nil)
    }
 
    

}
