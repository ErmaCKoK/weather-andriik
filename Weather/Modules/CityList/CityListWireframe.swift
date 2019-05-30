//
//  CityListWireframe.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

// MARK: - Init and Config Module

extension CityListWireframe {
    
    static func module() -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityListViewController") as! CityListViewController
        
        let presenter = CityListPresenter()
        
        view.presenter = presenter
        
        presenter.interactor = CityListInteractor(presenter: presenter)
        presenter.wireframe = CityListWireframe(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
}

// MARK: - Route

class CityListWireframe: CityListWireframeProtocol {
    
    weak var presenter: CityListPresenterProtocol?
    
    init(presenter: CityListPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func showWeatherDetails(for city: City, in viewController: UIViewController) {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherInCityViewController") as! WeatherInCityViewController
        WeatherInCityWireframe.module(view, in: city)
        viewController.present(view, animated: true, completion: nil)
    }
}
