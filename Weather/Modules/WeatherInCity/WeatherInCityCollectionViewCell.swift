//
//  WeatherInCityCollectionViewCell.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class WeatherInCityCollectionViewCell: UICollectionViewCell, WeatherInCityViewProtocol {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter: WeatherInCityPresenterProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - View Protocol
    
    func isViewLoad() -> Bool {
        return true
    }
    
    func displayLoading() {
        self.indicator.startAnimating()
        self.iconImageView.isHidden = true
        self.temperatureLabel.isHidden = true
    }
    
    func hideLoading() {
        self.indicator.stopAnimating()
        self.iconImageView.isHidden = false
        self.temperatureLabel.isHidden = false
    }
    
    func show(city: City) {
        self.cityNameLabel.text = city.name
    }
    
    func show(weather: Weather) {
        self.temperatureLabel.text = weather.main.fromatedTemp()
        self.iconImageView.setImage(with: weather.conditions.first?.iconUrl)
        self.hideLoading()
    }
    
    func show(error: Error) {
        self.hideLoading()
        self.temperatureLabel.text = "N/A"
        print("error \(error)")
    }
    
}
