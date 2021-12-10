//
//  ViewData.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 10.12.21..
//

import Foundation
import UIKit

struct ViewData {
    
        var cellsData: [CellData] = []
        var cityName: String?
        var weatherDescription: String?
        var temperature: String?
        var humidity: Double?
        
        init() {
        }
        
        init(weathermodel: WeatherModel, forecastModel: ForecastModel){
            
            let timeZoneDifference = weathermodel.timezone
            
            forecastModel.list.enumerated().forEach( { (index, element) in
                
                let cellData = CellData(weatherByDay: element, timeZoneDifference: timeZoneDifference)
                self.cellsData.append(cellData)

            })
            
            self.cityName = weathermodel.name
            self.weatherDescription = weathermodel.weather.first!.description
            self.temperature = String(format: "%.0f°", weathermodel.main.temp)
            self.humidity = Double((weathermodel.main.humidity))/100
        }
    
}
