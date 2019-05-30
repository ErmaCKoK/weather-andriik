//
//  City.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class City: NSObject {
    
    var name: String
    var code: String
    
    var weather: Weather?
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
    
    var query: [String: Any]? {
        return ["q": "\(self.name),\(self.code)"]
    }
    
}
