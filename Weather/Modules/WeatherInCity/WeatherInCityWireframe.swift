//
//  WeatherInCityWireframe.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

// MARK: - Init and Config Module

extension WeatherInCityWireframe {
    
    static func module(_ view: WeatherInCityViewProtocol, in city: City) {
        
        let presenter = WeatherInCityPresenter(city: city)
        
        view.presenter = presenter
        
        presenter.interactor = WeatherInCityInteractor(presenter: presenter)
        presenter.wireframe = WeatherInCityWireframe(presenter: presenter)
        presenter.view = view
    }
    
}

// MARK: - Route

class WeatherInCityWireframe: WeatherInCityWireframeProtocol {
    
    weak var presenter: WeatherInCityPresenterProtocol?
    
    init(presenter: WeatherInCityPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func goBack(for view: UIViewController) {
        view.dismiss(animated: true, completion: nil)
    }
}
