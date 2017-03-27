//
//  CarViewModel.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import Foundation

class CarViewModel: BaseViewModel {
    
    //MARK:- Properties
    private(set) var name: String?
    private(set) var fuel: Int?
    private(set) var vin: String?
    private(set) var address: String?
    private(set) var longitude: Double?
    private(set) var latitude: Double?
    
    //MARK:- Init
    required init(name: String?, fuel: Int?, vin:String?, address: String?, longitude: Double?, latitude: Double?) {
        self.name = name
        self.fuel = fuel
        self.vin = vin
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
    }
    
}
