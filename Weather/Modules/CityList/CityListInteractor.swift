//
//  CityListInteractor.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation
import CoreLocation

class CityListInteractor: NSObject, CityListInteractorProtocol {
    
    weak var presenter: CityListPresenterProtocol?

    var currentCity = CurrentCity()
    var cities = [City]()
    var locationManager = CLLocationManager()
    
    init(presenter: CityListPresenterProtocol?) {
        self.presenter = presenter
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = 1609.344 // 1 mile
    }
    
    func getCities() {
        
        self.startUpdatingLocation()
        
        if self.cities.count > 0 {
            self.presenter?.cityListDidFetch(cities)
            return
        }
        
        cities.append(self.currentCity)
        cities.append(City(name: "London", code: "uk") )
        cities.append(City(name: "Tokyo", code: "jp") )
        
        self.presenter?.cityListDidFetch(cities)
    }
    
}

// MARK: - CLLocationManager Delegate & Helper

extension CityListInteractor: CLLocationManagerDelegate {
    
    func  startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .restricted, status == .denied {
            return
        }
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func updateCurrentCity() {
        let location = self.locationManager.location
        
        self.currentCity.latitude = location?.coordinate.latitude
        self.currentCity.longitude = location?.coordinate.longitude
        
        guard let clLocation = location else {  return }
        
        CLGeocoder().reverseGeocodeLocation(clLocation, completionHandler: { (placemarks, error) in
            let placemark = placemarks?.last
            self.currentCity.name = placemark?.locality ?? "Current Location"
            self.currentCity.code = placemark?.isoCountryCode ?? ""
            
            self.presenter?.cityDidUpdate(self.currentCity)
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.updateCurrentCity()
        self.locationManager.stopUpdatingLocation()
    }
    
}

