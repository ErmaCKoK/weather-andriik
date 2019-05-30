//
//  WeatherInCityPresenter.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class WeatherInCityPresenter: WeatherInCityPresenterProtocol {
    
    var wireframe: WeatherInCityWireframe!
    var interactor: WeatherInCityInteractorProtocol!
    
    weak var view: WeatherInCityViewProtocol! {
        didSet {
            if view.isViewLoad() {
                self.viewDidLoad()
            }
        }
    }
    
    var city: City
    
    init(city: City) {
        self.city = city
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func willEnterForegroundNotification() {
        self.interactor.refreshWeather()
    }
    
    // MARK: - View
    
    func viewDidLoad() {
        self.interactor.getWeather()
        self.view.displayLoading()
        self.view.show(city: self.city)
    }
    
    func closeButtonPressed() {
        if let vc = view as? UIViewController {
            self.wireframe.goBack(for: vc)
        }
    }
    
    // MARK: - Interactor
    
    func weatherDidFetch(_ weather: Weather) {
        self.view.show(weather: weather)
    }
    
    func weatherDidFetch(with error: Error) {
        self.view.show(error: error)
    }
}
