//
//  CityListProtocols.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

// MARK: - Presenter

protocol CityListPresenterProtocol: class {
    
    // View
    func viewDidLoad()
    func weatherInCityConfig(by city: City, view: WeatherInCityViewProtocol)
    func didSelect(city: City, for view: UIViewController)
    
    // Interactor
    func cityListDidFetch(_ cities: [City])
    func cityDidUpdate(_ city: City)
}

// MARK: - View

protocol CityListViewProtocol: class {
    
    func showCityList(_ cities: [City])
    func updateCity(_ city: City)
}

// MARK: - Wireframe

protocol CityListWireframeProtocol: class {
    static func module() -> UIViewController
    
    func showWeatherDetails(for city: City, in viewController: UIViewController)
}

// MARK: - Interactor

protocol CityListInteractorProtocol: class {
    
    func getCities()
}
