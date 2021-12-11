//
//  CollectionCellViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation
import UIKit

struct CellData {
    
    var weatherModelId: Int = 1
    var temperature: String = ""
    var time: String = ""
    var dayInTheWeek: String = ""
    var image: UIImage?
    
    
    init(weatherByDay: WeatherByTime, timeZoneDifference: TimeInterval){

        self.weatherModelId = weatherByDay.weather.first!.id
        self.temperature = String(format: "%.0f°", weatherByDay.main.temp)
        self.time = "\(TimeConverter.getTimeFromMS(time: Int(weatherByDay.dt-timeZoneDifference)))"
        self.dayInTheWeek = TimeConverter.getDayNameFromMS(time: Int(weatherByDay.dt-timeZoneDifference))
        self.image = UIImage(named: weatherByDay.weather.first?.icon ?? "unknown")

    }


    
}
