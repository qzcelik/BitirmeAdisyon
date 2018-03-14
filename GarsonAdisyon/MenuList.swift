//
//  MenuList.swift
//  GarsonAdisyon
//
//  Created by Air on 14.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class MenuList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var screenSize = UIScreen.main.bounds
    var tableView = UITableView()
    var backButton = UIButton()
    var array = ["iskender","pilav","çorba","karnıyarık"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backButton = UIButton(frame: CGRect(x:screenSize.width*0.05,y:screenSize.height*0.05,width:screenSize.width*0.1,height:screenSize.height*0.05))
        backButton.setTitle("Geri", for: .normal)
        backButton.backgroundColor = .blue
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(geri), for: .touchUpInside)
        
        //tableView = UITableView(frame: view.bounds, style: .grouped)
        
        tableView = UITableView(frame: CGRect(x:screenSize.width*0.001,y:screenSize.height*0.15,width:screenSize.width*0.99,height:screenSize.height*0.99))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCellId")
        
        view.addSubview(tableView)
        view.addSubview(backButton)
        
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MenuCell(style: UITableViewCellStyle.default,reuseIdentifier:"MenuCellId")
        cell.mealName.text = array[indexPath.row]
        cell.mealPrice.text = array[indexPath.row]
        cell.sendButton.addTarget(self, action: #selector(sellProduct), for: .touchUpInside)
       
        return cell
    }
    
    @objc func sellProduct()
    {
        let alert = UIAlertController(title:"Basıldı",message:"Bilgilendirme",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    @objc func geri()
    {
        self.dismiss(animated: true , completion: nil)
    }
    
    
}
