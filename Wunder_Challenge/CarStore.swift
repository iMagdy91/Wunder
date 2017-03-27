//
//  CarStore.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import Foundation
import ObjectMapper

class CarStore: BaseStore {
    
    /* get all cars list*/
    class func getCarsList(successBlock: @escaping ViewModelClosure,failure failureBlock:@escaping ErrorClosure) {
        
        NetworkManager.performRequestWithPath(path: Network.carsPath, requestMethod: .get, parameters: nil, headers: nil, success: { (response) in
            /* Parsing and initializing view model*/
            let cars: CarModel? = Mapper<CarModel>().map(JSONObject: response)
            var carArray = [CarViewModel]()
            
            if let carModel = cars?.placemarks {
                for car in carModel {
                    if car.coordinates?.count == 3 {
                        let carViewModel = CarViewModel.init(name: car.name, fuel: car.fuel, vin: car.vin, address: car.address, longitude: car.coordinates?.first, latitude: car.coordinates?[1])
                        carArray.append(carViewModel)
                        
                    }
                }
                successBlock(carArray)
            }
            
            
        }) { (error) in
            failureBlock(error)
        }
    }
    
}
