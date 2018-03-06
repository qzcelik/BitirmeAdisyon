//
//  UserAdisyon.swift
//  GarsonAdisyon
//
//  Created by Air on 5.03.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit
import Alamofire

class UserAdisyon: UIViewController , UITableViewDataSource,UITableViewDelegate {

    
    
    var kulId = UserDefaults.standard
    var url = "http://ibrahimozcelik.net/bitirme/masaKontrol.php"
    var tableView = UITableView()
    var searchBox = UITextField()
    var searchButton = UIButton()
    var backButton = UIButton()
    var getCashButton = UIButton()
    var totalPriceText = UITextView()
    var filteringArray = [String]()
    var data = [AdisyonGetSet]()
    var cash : Int = 0
    var screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = UITableView(frame:CGRect(x:screenSize.width*0.01,y:screenSize.height*0.2,width:screenSize.width*0.9,height:screenSize.height*0.5),style:UITableViewStyle.plain )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "table")
        
        searchBox = UITextField(frame:CGRect(x:screenSize.width*0.1,y:screenSize.height*0.12,width:screenSize.width*0.5,height:screenSize.height*0.05))
        searchBox.placeholder = "Masa Numarası Giriniz"
        searchBox.borderStyle = .bezel
        searchBox.textColor = .black
        
        backButton = UIButton(frame:CGRect(x:screenSize.width*0.05,y:screenSize.height*0.05,width:screenSize.width*0.1,height:screenSize.height*0.05))
        backButton.setTitle("Geri", for: .normal)
        backButton.backgroundColor = .blue
        backButton.addTarget(self, action: #selector(backScreen), for: .touchUpInside)
        
        searchButton = UIButton(frame: CGRect(x:screenSize.width*0.65,y:screenSize.height*0.12,width:screenSize.width*0.3,height:screenSize.height*0.05))
        searchButton.setTitle("Ara", for: .normal)
        searchButton.backgroundColor = .red
        searchButton.addTarget(self, action: #selector(veriYaz), for:.touchUpInside)
        
        totalPriceText = UITextView(frame: CGRect(x:screenSize.width*0.2,y:screenSize.height*0.75,width:screenSize.width*0.8,height:screenSize.height*0.05))
        totalPriceText.font = UIFont.boldSystemFont(ofSize: CGFloat(Float(25)))
        
        
        getCashButton = UIButton(frame: CGRect(x:screenSize.width*0.3,y:screenSize.height*0.85,width:screenSize.width*0.4,height:screenSize.height*0.05))
        getCashButton.setTitle("Hesap Kes", for: .normal)
        getCashButton.backgroundColor = .red
        getCashButton.addTarget(self, action: #selector(takeAccount), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(searchBox)
        view.addSubview(searchButton)
        view.addSubview(backButton)
        view.addSubview(totalPriceText)
        view.addSubview(getCashButton)
        filteringArray.append("")
        getData()
    }
    
    @objc func takeAccount()
    {
        /*let alert = UIAlertController(title:"Bilgilendirme",message: "Adisyon Alındı",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
        */
        
        let cutMoney = TakeMoney(userId: kulId.string(forKey: "kullaniciId")!+searchBox.text!)
        cutMoney.deleteData()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backScreen()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func getData()
    {
        let parametre : [String:Any] = ["urunId":kulId.string(forKey: "kullaniciId")!]
        
        Alamofire.request("http://ibrahimozcelik.net/bitirme/masaKontrol.php",
                          method:.post,parameters:parametre,encoding: URLEncoding.httpBody).responseJSON{ response in
                            
                            let kont = response.response?.statusCode
                            if kont == 201
                            {
                                print ("HATA")
                            }
                            else
                            {
                                
                                if let json = response.result.value as? [String:Any],
                                    let getJson  = json["adisyon"] as? [[String:Any]]
                                {
                                    for jsonNesne in getJson
                                    {
                                        
                                        var adisyon = AdisyonGetSet(masaId: jsonNesne["masaId"] as! String, urunFiyat: jsonNesne["urunFiyat"] as! String,urunKategori: jsonNesne["urunKategori"] as! String,urunAd: jsonNesne["urunAd"] as! String,urunAdet: jsonNesne["urunAdet"] as! String)
                                        self.data.append(adisyon)
                                    }
                                }
                                
                                self.veriYaz()
                            }
        }
        
    }
    

    @objc func veriYaz()
    {
        filteringArray.removeAll()
        cash = 0
        for i in data
        {
            if searchBox.text == i.masaIdGet()
            {
                filteringArray.append(i.urunAdGet() + " " + i.urunFiyarGet() + " TL " + "Adeti : " + i.urunAdetGet())
                cash += Int(i.urunFiyarGet())! * Int(i.urunAdetGet())!
            }
            
        }
        tableView.reloadData()
        totalPriceText.text = "Toplam Tutar  " + String(cash) + " TL"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "table",for: indexPath)
        cell.textLabel?.text = filteringArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let secilenSatir =  tableView.cellForRow(at: indexPath)
        print("Toplam Tutar : " + (secilenSatir?.textLabel?.text)!)
    }
    

    
    

   

}
