//
//  MenuCell.swift
//  GarsonAdisyon
//
//  Created by Air on 14.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    var screnSize = UIScreen.main.bounds
    //var sendButton = UIButton()
    var mealName = UILabel()
    var cafeLogo = UIImageView()
    var mealPrice = UILabel()
    var subView = UIView()
    var productNameImage = UIImageView()
    var productMoneyImage = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        subView = UIView(frame: CGRect(x:screnSize.width*0.01,y:screnSize.height*0.01,width:screnSize.width*0.98,height:screnSize.height*0.1))
        subView.backgroundColor = UIColor.clear
        
        productNameImage = UIImageView(frame: CGRect(x:subView.bounds.width*0.08,y:subView.bounds.height*0.1,width:20,height:20))
        productNameImage.image = #imageLiteral(resourceName: "proName")
        
        productMoneyImage = UIImageView(frame: CGRect(x:subView.bounds.width*0.08,y:subView.bounds.height*0.55,width:20,height:20))
        productMoneyImage.image = #imageLiteral(resourceName: "turkish-lira")
        
        cafeLogo = UIImageView(frame:CGRect(x:subView.bounds.width*0.7,y:subView.bounds.height*0.05,width:75,height:75))
        cafeLogo.image = #imageLiteral(resourceName: "logo")
        
        /*sendButton = UIButton(frame:CGRect(x:subView.bounds.width*0.5,y:subView.bounds.height*0.05,width:subView.bounds.width*0.4,height:subView.bounds.height*0.6))
        sendButton.setTitle("Gönder", for: .normal)
        sendButton.backgroundColor = .red*/
        
        mealName = UILabel(frame: CGRect(x:subView.bounds.width*0.15,y:subView.bounds.height*0.02,width:subView.bounds.width*0.45,height:subView.bounds.height*0.4))
        mealName.textColor = .black
        mealName.text = "yemek ad"
        
        mealPrice = UILabel(frame: CGRect(x:subView.bounds.width*0.15,y:subView.bounds.height*0.5,width:subView.bounds.width*0.45,height:subView.bounds.height*0.4))
        mealPrice.textColor = .black
        mealPrice.text = "yemek fiyat"
        
        //subView.addSubview(sendButton)
        subView.addSubview(cafeLogo)
        subView.addSubview(mealPrice)
        subView.addSubview(mealName)
        subView.addSubview(productMoneyImage)
        subView.addSubview(productNameImage)
        self.addSubview(subView)
    
    }
    
    
}
