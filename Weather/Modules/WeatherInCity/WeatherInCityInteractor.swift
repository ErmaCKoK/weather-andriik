//
//  WeatherInCityInteractor.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class WeatherInCityInteractor: WeatherInCityInteractorProtocol {
    
    weak var presenter: WeatherInCityPresenterProtocol?
    
    init(presenter: WeatherInCityPresenterProtocol?) {
        self.presenter = presenter
    }

    var weather: Weather?
    
    func refreshWeather() {
        self.fetchWeather()
    }
    
    func getWeather() {
        if let weather = self.presenter?.city.weather {
            DispatchQueue.main.async {
                self.weather = weather
                self.presenter?.weatherDidFetch(weather)
            }
            return
        }
        
        self.fetchWeather()
    }
    
    func fetchWeather() {
        guard
            let city = self.presenter?.city,
            let query = city.query
        else {
            return
        }
        
        let request = APIRequest.wather.query(query)
        request.get(Weather.self) { (weather, error) in
            DispatchQueue.main.async {
                guard
                    let weather = weather
                else {
                    if let error = error {
                        self.presenter?.weatherDidFetch(with: error)
                    }
                    return
                }
                
                city.weather = weather
                self.weather = weather
                self.presenter?.weatherDidFetch(weather)
            }
        }
    }
}
