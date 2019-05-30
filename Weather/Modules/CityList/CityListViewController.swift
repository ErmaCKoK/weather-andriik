//
//  CityListViewController.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController, CityListViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: CityListPresenterProtocol?
    
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.viewDidLoad()
        
        self.collectionView.contentInset.left = 10
        self.collectionView.contentInset.right = 10
    }
    
    // MARK: - View Protocol
    
    func showCityList(_ cities: [City]) {
        self.cities = cities
        self.collectionView.reloadData()
    }
    
    func updateCity(_ city: City) {
        guard let index = self.cities.firstIndex(of: city) else {
            return
        }
        
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }

}

extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "city", for: indexPath) as! WeatherInCityCollectionViewCell
        self.presenter?.weatherInCityConfig(by: self.cities[indexPath.item], view: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentWidth = collectionView.bounds.width - 21
        let countFit = Int(contentWidth / 180)
        let count = max(countFit, 2)
        let width = contentWidth / CGFloat(count)
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.didSelect(city: self.cities[indexPath.item], for: self)
    }
    
}
