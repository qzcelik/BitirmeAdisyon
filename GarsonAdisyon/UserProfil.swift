//
//  UserProfil.swift
//  GarsonAdisyon
//
//  Created by Air on 27.02.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class UserProfil: UIViewController{

    var screnSize = UIScreen.main.bounds
    var bgImage = UIImageView()
    var butonAddition = UIButton()
    var butonMenu = UIButton()
    var butonFreeTable = UIButton()
    var butonTotalCash = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        bgImage = UIImageView(frame: CGRect(x:0,y:0,width:screnSize.width,height:screnSize.height))
        bgImage.image = #imageLiteral(resourceName: "bg88")
        view.addSubview(bgImage)
        UILocate()
    }

    func UILocate()
    {
        butonMenu = UIButton(frame:CGRect(x:screnSize.width*0.1,y:screnSize.height*0.35,width:screnSize.width*0.8,height:screnSize.height*0.19))
        butonMenu.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        butonMenu.addTarget(self, action: #selector(menuFunc), for: .touchUpInside)
        
        butonAddition = UIButton(frame:(CGRect(x:screnSize.width*0.1,y:screnSize.height*0.6,width:screnSize.width*0.8,height:screnSize.height*0.19)))
        butonAddition.setImage(#imageLiteral(resourceName: "adisyon"), for: .normal)
        butonAddition.addTarget(self, action:#selector(additionFunc), for:.touchUpInside)
        
        /*butonFreeTable = UIButton(frame:(CGRect(x:screnSize.width*0.18,y:screnSize.height*0.45,width:screnSize.width*0.3,height:screnSize.height*0.2)))
        butonFreeTable.setTitle("Boş Masa", for: .normal)
        butonFreeTable.setTitleColor(.white, for: .normal)
        butonFreeTable.backgroundColor = .red
        butonFreeTable.addTarget(self, action: #selector(freeTableFunc), for: .touchUpInside)*/
        
       /* butonTotalCash = UIButton(frame: CGRect(x:screnSize.width*0.18,y:screnSize.height*0.45,width:screnSize.width*0.65,height:screnSize.height*0.2))
        butonTotalCash.setTitle("Toplam Satış", for: .normal)
        butonTotalCash.setTitleColor(.white, for: .normal)
        butonTotalCash.backgroundColor = .red
        butonTotalCash.addTarget(self, action: #selector(totalCashFunc), for: .touchUpInside)*/
        
        view.addSubview(butonMenu)
        view.addSubview(butonAddition)
        view.addSubview(butonFreeTable)
        view.addSubview(butonTotalCash)
        
        
    }
    
   
    @objc func menuFunc(){
    
        var menu = UserMenu()
        self.present(menu,animated: true, completion: nil)
    }

    @objc func additionFunc(){
        
        var adition = UserAdisyon()
        self.present(adition,animated: true,completion: nil)
    }
    
  /*  @objc func freeTableFunc(){
        var freeTable = EmptyTable()
        self.present(freeTable,animated: true, completion: nil)
    }*/
    
    /*@objc func totalCashFunc(){
        
    }*/
    
    

    
    
    
}
