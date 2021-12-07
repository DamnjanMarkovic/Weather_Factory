//
//  CollectionCellViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation
import UIKit

struct WeatherCellViewModel {
    
    var temperature: String
    var time: String
    var dayInTheWeek: String
    var image: UIImage
    var imageColor: UIColor
    var isDay: Bool
    
    init() {
         temperature = ""
         time = ""
         dayInTheWeek = ""
         image = UIImage()
         imageColor = UIColor.white
         isDay = true
    }
    
    init(weatherByDay: WeatherByDays, IsDay: Bool, timeZoneDifference: TimeInterval){
        
        self.temperature = String(format: "%.0f°", weatherByDay.main.temp)
        self.time = "\(TimeConverter.getTimeFromMS(time: Int(weatherByDay.dt+timeZoneDifference)))"
        self.dayInTheWeek = TimeConverter.getDayNameFromMS(time: Int(weatherByDay.dt+timeZoneDifference))
        self.image = WeatherImageProvider.getImageFromName(name: weatherByDay.weather.first!.main, isDay: IsDay)
        self.imageColor = WeatherImageProvider.getImageColor(name: weatherByDay.weather.first!.main, isDay: IsDay)
        self.isDay = IsDay
    
    
    
    }
    
}
