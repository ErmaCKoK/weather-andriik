//
//  WeatherInCityViewController.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/29/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class WeatherInCityViewController: UIViewController, WeatherInCityViewProtocol {
    
    
    @IBOutlet weak var stackDetailView: UIStackView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter: WeatherInCityPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.viewDidLoad()
    }
    
    func reloadView() {
        self.stackDetailView.isHidden = self.indicator.isAnimating
        self.temperatureLabel.isHidden = self.indicator.isAnimating
        self.iconImageView.isHidden = self.indicator.isAnimating
    }
    
    @IBAction func handleCloseButton() {
        self.presenter?.closeButtonPressed()
    }
    
    // MARK: - View Protocol
    
    func isViewLoad() -> Bool {
        return self.isViewLoaded
    }
    
    func displayLoading() {
        self.indicator.startAnimating()
        self.reloadView()
    }
    
    func hideLoading() {
        self.indicator.stopAnimating()
        self.reloadView()
    }
    
    func show(city: City) {
        self.cityNameLabel.text = city.name
    }
    
    func show(weather: Weather) {
        self.temperatureLabel.text = weather.main.fromatedTemp()
        self.iconImageView.setImage(with: weather.conditions.first?.iconUrl)
        
        if let cloud = weather.clouds?.all {
            self.cloudLabel.text = "\(cloud)%"
        } else {
            self.cloudLabel.text = "No cloud"
        }
        
        if let wind = weather.wind {
            var string = ""
            if let speed = wind.speed {
                string = "\(speed)m/s"
            }
            
            if let deg = wind.deg {
                let space = string.isEmpty ? "" : "\n"
                string = "\(string)\(space)\(deg)°"
            }
            self.windLabel.text = string
        } else {
            self.windLabel.text = "No wind"
        }
        
        self.hideLoading()
    }
    
    func show(error: Error) {
        self.hideLoading()
    }

}
