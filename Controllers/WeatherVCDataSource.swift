//
//  WeatherVCDataSource.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 7.12.21..
//

import Foundation
import UIKit


extension WeatherVCDataSource where Model == WeatherCellViewModel{

    static func displayDataWeatherCell(for weather:[WeatherCellViewModel],
                            withCellidentifier reuseIdentifier: String, collectionView: UICollectionView)
                            -> WeatherVCDataSource {
        
        return WeatherVCDataSource(models: weather, reuseIdentifier: reuseIdentifier, collectionView: collectionView, cellConfigurator: { (weather, cell ) in
        let weatherCell: WeatherCell = cell as! WeatherCell
                                    weatherCell.configure(with: weather)
        })
    }
    static func displayDataDailyWeatherCell(for weather:[WeatherCellViewModel],
                            withCellidentifier reuseIdentifier: String, collectionView: UICollectionView)
                            -> WeatherVCDataSource {
        
        return WeatherVCDataSource(models: weather, reuseIdentifier: reuseIdentifier, collectionView: collectionView, cellConfigurator: { (weather, cell ) in
        let weatherCell: DailyWeatherCell = cell as! DailyWeatherCell
            weatherCell.configure(with: weather)
        })
    }
}



class WeatherVCDataSource<Model>: NSObject, UICollectionViewDataSource {
    
    typealias CellConfigurator = (Model, UICollectionViewCell) -> Void

    var models: [Model]

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model], reuseIdentifier: String, collectionView: UICollectionView,
                 cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = models[indexPath.row]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier, for: indexPath)
                

        cellConfigurator(model, cell)

        return cell
        
    }
}