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
    var butonAddition = UIButton()
    var butonMenu = UIButton()
    var butonFreeTable = UIButton()
    var butonTotalCash = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        UILocate()
    }

    func UILocate()
    {
        butonMenu = UIButton(frame:CGRect(x:screnSize.width*0.18,y:screnSize.height*0.2,width:screnSize.width*0.3,height:screnSize.height*0.2))
        butonMenu.setTitle("Menü", for: .normal)
        butonMenu.backgroundColor = .red
        butonMenu.setTitleColor(.white, for: .normal)
        butonMenu.addTarget(self, action: #selector(menuFunc), for: .touchUpInside)
        
        butonAddition = UIButton(frame:(CGRect(x:screnSize.width*0.52,y:screnSize.height*0.2,width:screnSize.width*0.3,height:screnSize.height*0.2)))
        butonAddition.setTitle("Adisyon", for: .normal)
        butonMenu.setTitleColor(.white, for: .normal)
        butonAddition.backgroundColor = .red
        butonAddition.addTarget(self, action:#selector(additionFunc), for:.touchUpInside)
        
        butonFreeTable = UIButton(frame:(CGRect(x:screnSize.width*0.18,y:screnSize.height*0.45,width:screnSize.width*0.3,height:screnSize.height*0.2)))
        butonFreeTable.setTitle("Boş Masa", for: .normal)
        butonFreeTable.setTitleColor(.white, for: .normal)
        butonFreeTable.backgroundColor = .red
        butonFreeTable.addTarget(self, action: #selector(freeTableFunc), for: .touchUpInside)
        
        butonTotalCash = UIButton(frame: CGRect(x:screnSize.width*0.52,y:screnSize.height*0.45,width:screnSize.width*0.3,height:screnSize.height*0.2))
        butonTotalCash.setTitle("Toplam Satış", for: .normal)
        butonTotalCash.setTitleColor(.white, for: .normal)
        butonTotalCash.backgroundColor = .red
        butonTotalCash.addTarget(self, action: #selector(totalCashFunc), for: .touchUpInside)
        
        view.addSubview(butonMenu)
        view.addSubview(butonAddition)
        view.addSubview(butonFreeTable)
        view.addSubview(butonTotalCash)
        
        
    }
    
   
    @objc func menuFunc(){
    
    }

    @objc func additionFunc(){
        
        var adition = UserAdisyon()
        self.present(adition,animated: true,completion: nil)
    }
    
    @objc func freeTableFunc(){
        
    }
    
    @objc func totalCashFunc(){
        
    }
    
    

    
    
    
}
