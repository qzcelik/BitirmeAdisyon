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
    var bgImage = UIImageView()
    var productArray = [MenuGetSet]()
    var productArrayBuffer = [MenuGetSet]()
    var counterProduct = Int()
    var sendetData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bgImage = UIImageView(frame: CGRect(x:0,y:0,width:screenSize.width,height:screenSize.height))
        bgImage.image = #imageLiteral(resourceName: "bg4.fw")
        sendetData.removeAll()
        productArray.removeAll()
        productArrayBuffer.removeAll()
        view.addSubview(bgImage)
        uiElement()
        getMenuData()
    }
    
    func uiElement()
    {
        dinnerButton = UIButton(frame:CGRect (x: screenSize.width*0.1,y: screenSize.height*0.23,width: screenSize.width*0.3,height: screenSize.height*0.17))
        dinnerButton.setImage(#imageLiteral(resourceName: "anaYemek"), for: .normal)
        dinnerButton.addTarget(self, action: #selector(dinnerFunc), for: .touchUpInside)
        
        drinkButton = UIButton(frame:CGRect (x: screenSize.width*0.6,y: screenSize.height*0.23,width: screenSize.width*0.3,height: screenSize.height*0.17))
        drinkButton.setImage(#imageLiteral(resourceName: "icecek"), for: .normal)
        drinkButton.addTarget(self, action: #selector(drinkfunc), for: .touchUpInside)
        
        dessertButton = UIButton(frame:CGRect (x: screenSize.width*0.1,y: screenSize.height*0.45,width: screenSize.width*0.3,height: screenSize.height*0.17))
        dessertButton.setImage(#imageLiteral(resourceName: "tatli"), for: .normal)
        dessertButton.addTarget(self, action: #selector(dessertFunc), for: .touchUpInside)
        
        fastfoodButton = UIButton(frame:CGRect (x: screenSize.width*0.6,y: screenSize.height*0.45,width: screenSize.width*0.3,height: screenSize.height*0.17))
        fastfoodButton.setImage(#imageLiteral(resourceName: "fastfood"), for: .normal)
        fastfoodButton.addTarget(self, action: #selector(fastFoodFunc), for: .touchUpInside)
        
        soupButton = UIButton(frame:CGRect (x: screenSize.width*0.35,y: screenSize.height*0.65,width: screenSize.width*0.3,height: screenSize.height*0.17))
        soupButton.setImage(#imageLiteral(resourceName: "corba"), for: .normal)
        soupButton.addTarget(self, action: #selector(soupFunc), for: .touchUpInside)
        
        backButton = UIButton(frame:CGRect (x: screenSize.width*0.05,y: screenSize.height*0.08,width: screenSize.width*0.1,height: screenSize.height*0.07))
        backButton.setImage(#imageLiteral(resourceName: "geriButon"), for: .normal)
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
        
        sendetData.removeAll()
        productArrayBuffer.removeAll()
        
        for i in productArray
        {
            if i.productCategory == dataArray
            {
                productArrayBuffer.append(i)
            }
        }
        
        for i in productArrayBuffer
        {
            sendetData.append(i.productNameGet() + "*" + i.productPriceGet() + "*" + i.productNoGet() + "*" + i.productInfoGet() + "*" + i.productCategoryGet())
        }
        
        setProductArray.set(sendetData, forKey: "urunDizi")
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
