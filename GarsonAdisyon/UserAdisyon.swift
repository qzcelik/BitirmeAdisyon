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
    var totalPriceText = UILabel()
    var freeTableCount = UILabel()
    var freeTableCount2 = UILabel()
    var filteringArray = [String]()
    var masaIdArray = [String] ()
    var bgImage = UIImageView()
    var data = [AdisyonGetSet]()
    var cash : Int = 0
    var screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = UITableView(frame:CGRect(x:0,y:screenSize.height*0.33,width:screenSize.width,height:screenSize.height*0.5),style:UITableViewStyle.plain )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "table")
        tableView.backgroundView = UIImageView(image:UIImage(named: "bg13"))
        
        bgImage = UIImageView(frame: CGRect(x:0,y:0,width:screenSize.width,height:screenSize.height))
        bgImage.image = #imageLiteral(resourceName: "bg12")
        
        freeTableCount = UILabel(frame:CGRect(x:screenSize.width*0.05,y:screenSize.height*0.15,width:screenSize.width*0.8,height:screenSize.height*0.15))
        freeTableCount.textColor = .black
        freeTableCount.font = UIFont.boldSystemFont(ofSize: CGFloat(Float(20)))
        
        freeTableCount2 = UILabel(frame:CGRect(x:screenSize.width*0.05,y:screenSize.height*0.18,width:screenSize.width*0.8,height:screenSize.height*0.15))
        freeTableCount2.textColor = .black
        freeTableCount2.font = UIFont.boldSystemFont(ofSize: CGFloat(Float(20)))
        
        searchBox = UITextField(frame:CGRect(x:screenSize.width*0.65,y:screenSize.height*0.2,width:screenSize.width*0.32,height:screenSize.height*0.06))
        searchBox.placeholder = "Masa No"
        searchBox.textColor = .black
        searchBox.background = #imageLiteral(resourceName: "txtBg")
        searchBox.leftView = UIView(frame:CGRect(x:0,y:0,width:10,height:searchBox.frame.height))
        searchBox.leftViewMode = .always
        searchBox.leftView = UIView(frame: CGRect(x:0,y:0,width:10,height:searchBox.frame.height))
        
        backButton = UIButton(frame:CGRect(x:screenSize.width*0.05,y:screenSize.height*0.09,width:screenSize.width*0.1,height:screenSize.height*0.07))
        backButton.setImage(#imageLiteral(resourceName: "geriButon"), for: .normal)
        backButton.addTarget(self, action: #selector(backScreen), for: .touchUpInside)
        
        searchButton = UIButton(frame: CGRect(x:screenSize.width*0.65,y:screenSize.height*0.25,width:screenSize.width*0.3,height:screenSize.height*0.05))
        searchButton.setTitle("Ara", for: .normal)
        searchButton.addTarget(self, action: #selector(veriYaz), for:.touchUpInside)
        
        totalPriceText = UILabel(frame: CGRect(x:screenSize.width*0.2,y:screenSize.height*0.85,width:screenSize.width*0.8,height:screenSize.height*0.05))
        totalPriceText.font = UIFont.boldSystemFont(ofSize: CGFloat(Float(25)))
        
        
        getCashButton = UIButton(frame: CGRect(x:screenSize.width*0.3,y:screenSize.height*0.9,width:screenSize.width*0.4,height:screenSize.height*0.05))
        getCashButton.setTitle("Hesap Kes", for: .normal)
        getCashButton.addTarget(self, action: #selector(takeAccount), for: .touchUpInside)
        
        view.addSubview(bgImage)
        view.addSubview(tableView)
        view.addSubview(searchBox)
        view.addSubview(freeTableCount)
        view.addSubview(freeTableCount2)
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
                                        self.masaIdArray.append(jsonNesne["masaId"] as! String)
                                        self.masaIdArray.sort()
                                        
                                  }
                                    
                                    var i = 0
                                    var buffer = 0
                                    var tableIds = " "
                                    
                                    while i <= 6
                                    {
                                    
                                        for mId in self.masaIdArray
                                    {
                                            if Int(mId) == i
                                            {
                                               buffer += 1
                                               //i = buffer
                                               tableIds += String(i) + ","
                                               break
                                            }
                                     }
                                        i += 1
                                    }
                                    
                                    self.freeTableCount.text = "Dolu Masalar : " + tableIds
                                    self.freeTableCount2.text =  "Boş Kapasite : " + String((6-buffer) * 4) + " Kişi"
                                    
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white:1,alpha:0.3)
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        let deleteUrl = "http://ibrahimozcelik.net/bitirme/siparisIptal.php"
        var splitArray = filteringArray[indexPath.row].components(separatedBy: " ")
        var param : [String:Any] = ["kulId":kulId.string(forKey: "kullaniciId")!+searchBox.text!,"urunAd":splitArray[0]]
        if editingStyle == .delete
        {
            
            var alert = UIAlertController(title:"Sipariş İptal",message:"Sipariş İptal Edilsin mi?",preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"Sil", style:UIAlertActionStyle.default,handler:{action in
                Alamofire.request(deleteUrl,method: .post,parameters: param,encoding:URLEncoding.httpBody).responseJSON{response in}
                self.filteringArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }))
            alert.addAction(UIAlertAction(title:"İptal",style:UIAlertActionStyle.default,handler:nil))
            self.present(alert,animated: true,completion: nil)
            
            
            
            
            
        }
    }
    

   

}
