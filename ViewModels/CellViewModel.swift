//
//  CollectionCellViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation
import UIKit

struct CellViewModel {
    
    var weatherModelId: Int
    var temperature: String
    var time: String
    var dayInTheWeek: String
    
    init(weatherByDay: WeatherByDays, timeZoneDifference: TimeInterval){
        self.weatherModelId = weatherByDay.weather.first!.id
        self.temperature = String(format: "%.0f°", weatherByDay.main.temp)
        self.time = "\(TimeConverter.getTimeFromMS(time: Int(weatherByDay.dt-timeZoneDifference)))"
        self.dayInTheWeek = TimeConverter.getDayNameFromMS(time: Int(weatherByDay.dt-timeZoneDifference))
        
    
    }

    
        var image: UIImage {
            switch weatherModelId {
            case 200...232:
                return UIImage(systemName: "cloud.bolt")!
            case 300...321:
                return UIImage(systemName: "cloud.drizzle")!
            case 500...531:
                return UIImage(systemName: "cloud.rain")!
            case 600...622:
                return UIImage(systemName: "cloud.snow")!
            case 701...781:
                return UIImage(systemName: "cloud.fog")!
            case 800:
                return UIImage(systemName: "sun.max")!
            case 801...804:
                return UIImage(systemName: "cloud")!
            default:
                return UIImage(systemName: "cloud")!
            }
        }

    
}
