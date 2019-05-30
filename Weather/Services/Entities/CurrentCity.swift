//
//  CurrentCity.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/29/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class CurrentCity: City {
    
    var longitude: Double?
    var latitude: Double?
    
    init() {
        super.init(name: "Current Location", code: "")
    }
    
    override var query: [String : Any]? {
        
        guard
            let longitude = self.longitude,
            let latitude = self.latitude
        else {
            return nil
        }
        
        return ["lat": latitude, "lon": longitude]
    }
}
