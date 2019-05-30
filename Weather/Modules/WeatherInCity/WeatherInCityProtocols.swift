//
//  WeatherInCityProtocols.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

// MARK: - Presenter

protocol WeatherInCityPresenterProtocol: class {
    
    var city: City { get }
    
    // View
    func viewDidLoad()
    func closeButtonPressed()
    
    // Interactor
    func weatherDidFetch(_ weather: Weather)
    func weatherDidFetch(with error: Error)
}

// MARK: - View

protocol WeatherInCityViewProtocol: class {
    
    var presenter: WeatherInCityPresenterProtocol? { get set }
    
    func isViewLoad() -> Bool
    
    func displayLoading()
    
    func show(city: City)
    func show(weather: Weather)
    func show(error: Error)
}

// MARK: - Wireframe

protocol WeatherInCityWireframeProtocol: class {
    static func module(_ view: WeatherInCityViewProtocol, in city: City)
    
    func goBack(for view: UIViewController)
}

// MARK: - Interactor

protocol WeatherInCityInteractorProtocol: class {
    func getWeather()
    func refreshWeather()
}
