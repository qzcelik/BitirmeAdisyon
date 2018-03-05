//
//  AdisyonGetSet.swift
//  GarsonAdisyon
//
//  Created by Air on 27.02.2018.
//  Copyright © 2018 Air. All rights reserved.
//

import UIKit

class AdisyonGetSet  {
    
    var masaId : String
    var urunFiyat : String
    var urunKategori : String
    var urunAd : String
    var urunAdet : String
    
    init(masaId:String,urunFiyat:String,urunKategori:String,urunAd:String,urunAdet:String)
    {
        self.masaId = masaId
        self.urunFiyat = urunFiyat
        self.urunKategori = urunKategori
        self.urunAd = urunAd
        self.urunAdet = urunAdet
    }
    
    func masaIdGet() -> String
    {
        return masaId
    }
    
    func urunFiyarGet() -> String
    {
        return urunFiyat
    }
    
    func urunKategoriGet() -> String
    {
        return urunKategori
    }
    
    func urunAdGet() -> String
    {
        return urunAd
    }
    
    func urunAdetGet() -> String
    {
        return urunAdet
    }
    
    
    
}
