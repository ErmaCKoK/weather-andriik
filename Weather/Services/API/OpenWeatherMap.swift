//
//  WeatherRequest.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

extension APIRequest {
    
    static var openWeatherMap: APIRequest {
        let request = APIRequest(url: "https://api.openweathermap.org/data/2.5/")
        request.parametrs["APPID"] = "98d04b65d5f9381e26339bbc21514252"
        return request
    }
    
    static var wather: APIRequest {
        return APIRequest.openWeatherMap.path("weather")
    }
    
}
