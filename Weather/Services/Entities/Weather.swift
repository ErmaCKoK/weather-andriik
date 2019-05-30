//
//  Weather.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class Condition: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    var iconUrl: String {
        return "https://openweathermap.org/img/w/\(self.icon).png"
    }
}

class Main: Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var temp_min: Double
    var temp_max: Double
    
    func fromatedTemp() -> String {
        let kelvin = Measurement(value: self.temp, unit: UnitTemperature.kelvin)
        let conversion = kelvin.converted(to: .fahrenheit)
        return String(format: "%.1f °F", conversion.value)
    }
}

class Wind: Codable {
    var speed: Double?
    var deg: Double?
}

class Clouds: Codable {
    var all: Double?
}

class Weather: Codable {
    
    var name: String?
    var conditions: [Condition]
    var main: Main
    
    var wind: Wind?
    var clouds: Clouds?

    enum CodingKeys: String, CodingKey {
        case name
        case conditions = "weather"
        case main
        case wind
        case clouds
    }
}
