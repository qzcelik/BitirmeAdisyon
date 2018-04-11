//
//  EmptyTable.swift
//  GarsonAdisyon
//
//  Created by Air on 28.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class EmptyTable: UIViewController {

    var screenSize = UIScreen.main.bounds
    var i1 = UIImageView()
    var i2 = UIImageView()
    var i3 = UIImageView()
    var i4 = UIImageView()
    var i5 = UIImageView()
    var i6 = UIImageView()
    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        uiElement()
    }
 
    func uiElement()
    {
        
        i1 = UIImageView(frame: CGRect(x:screenSize.width*0.1,y:screenSize.height*0.1,width:screenSize.width*0.3,height:screenSize.height*0.1))
        i1.backgroundColor = .red
    
        i2 = UIImageView(frame: CGRect(x:screenSize.width*0.45,y:screenSize.height*0.1,width:screenSize.width*0.3,height:screenSize.height*0.1))
        i2.backgroundColor = .red
        
        i3 = UIImageView(frame: CGRect(x:screenSize.width*0.1,y:screenSize.height*0.3,width:screenSize.width*0.3,height:screenSize.height*0.1))
        i3.backgroundColor = .red
        
        i4 = UIImageView(frame: CGRect(x:screenSize.width*0.45,y:screenSize.height*0.3,width:screenSize.width*0.3,height:screenSize.height*0.1))
        i4.backgroundColor = .red
        
        i5 = UIImageView(frame: CGRect(x:screenSize.width*0.1,y:screenSize.height*0.5,width:screenSize.width*0.3,height:screenSize.height*0.1))
        i5.backgroundColor = .red
        
        i6 = UIImageView(frame: CGRect(x:screenSize.width*0.45,y:screenSize.height*0.5,width:screenSize.width*0.3,height:screenSize.height*0.1))
        i6.backgroundColor = .red
    
        backButton = UIButton(frame:CGRect(x:screenSize.width*0.05,y:screenSize.height*0.05,width:screenSize.width*0.1,height:screenSize.height*0.05))
        backButton.setTitle("Geri", for: .normal)
        backButton.backgroundColor = .blue
        backButton.addTarget(self, action:#selector(backScreen), for: .touchUpInside)
       
        
        view.addSubview(backButton)
        view.addSubview(i1)
        view.addSubview(i2)
        view.addSubview(i3)
        view.addSubview(i4)
        view.addSubview(i5)
        view.addSubview(i6)
    }
    
    @objc func backScreen()
    {
        dismiss(animated: true, completion: nil)
    }
    
}
