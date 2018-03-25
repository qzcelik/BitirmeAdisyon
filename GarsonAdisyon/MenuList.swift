//
//  MenuList.swift
//  GarsonAdisyon
//
//  Created by Air on 14.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class MenuList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var resultData = UserDefaults.standard
    var screenSize = UIScreen.main.bounds
    var tableView = UITableView()
    var backButton = UIButton()
    var resultDataArray = [MenuGetSet]()
    var mealNameArray = [String]()
    var mealPriceArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backButton = UIButton(frame: CGRect(x:screenSize.width*0.05,y:screenSize.height*0.05,width:screenSize.width*0.1,height:screenSize.height*0.05))
        backButton.setTitle("Geri", for: .normal)
        backButton.backgroundColor = .blue
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(geri), for: .touchUpInside)
        
        tableView = UITableView(frame: CGRect(x:screenSize.width*0.001,y:screenSize.height*0.15,width:screenSize.width*0.99,height:screenSize.height*0.99))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCellId")
        tableView.reloadData()
        
        view.addSubview(tableView)
        view.addSubview(backButton)
        
        
        var a = resultData.stringArray(forKey: "urunDizi") ?? [String]()
        for i in a
        {
           var sepereateData =  i.components(separatedBy: "*")
           mealNameArray.append(sepereateData[0])
           mealPriceArray.append(sepereateData[1])
           let buffer = MenuGetSet(productName: sepereateData[0],productPrice: sepereateData[1],productNo: sepereateData[2],productInfo: sepereateData[3],productCategory: sepereateData[4])
           resultDataArray.append(buffer)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return resultDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MenuCell(style: UITableViewCellStyle.default,reuseIdentifier:"MenuCellId")
        cell.mealName.text = mealNameArray[indexPath.row]
        cell.mealPrice.text = mealPriceArray[indexPath.row]
        cell.cafeLogo.image = #imageLiteral(resourceName: "logo")
      
        
        return cell
    }
    
    
    @objc func geri()
    {
        self.dismiss(animated: true , completion: nil)
    }
    
    
}
