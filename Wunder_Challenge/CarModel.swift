//
//  CarModel.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import Foundation
import ObjectMapper

class CarModel: Mappable {
    
    //MARK:- Properties
    private(set) var placemarks: [Placemark]?
    
    //MARK:- Init
    required init?(map: Map) {
    }
    
    /* mapping from API */
    func mapping(map: Map) {
        placemarks <- map["placemarks"]
    
    }
    
}

class Placemark: Mappable {
    
    //MARK:- Properties
    private(set) var address: String?
    private(set) var coordinates: [Double]?
    private(set) var engineType: String?
    private(set) var exterior: String?
    private(set) var fuel: Int?
    private(set) var interior: String?
    private(set) var name: String?
    private(set) var vin: String?
    
    //MARK:- Init
    required init?(map: Map) {
    }
    
    /* mapping from API */
    func mapping(map: Map) {
        address <- map["address"]
        coordinates <- map["coordinates"]
        engineType <- map["engineType"]
        exterior <- map["exterior"]
        fuel <- map["fuel"]
        interior <- map["interior"]
        name <- map["name"]
        vin <- map["vin"]
    }
    
}
