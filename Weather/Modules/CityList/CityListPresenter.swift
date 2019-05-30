//
//  CityListPresenter.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class CityListPresenter: CityListPresenterProtocol {
    
    var wireframe: CityListWireframe!
    var interactor: CityListInteractorProtocol!
    weak var view: CityListViewProtocol!
    
    // MARK: - View
        
    func viewDidLoad() {
        self.interactor.getCities()
    }
    
    func weatherInCityConfig(by city: City, view: WeatherInCityViewProtocol) {
        WeatherInCityWireframe.module(view, in: city)
    }
    
    func didSelect(city: City, for view: UIViewController) {
        self.wireframe?.showWeatherDetails(for: city, in: view)
    }
    
    // MARK: - Interactor

    func cityListDidFetch(_ cities: [City]) {
        self.view.showCityList(cities)
    }
    
    func cityDidUpdate(_ city: City) {
        self.view.updateCity(city)
    }
}
