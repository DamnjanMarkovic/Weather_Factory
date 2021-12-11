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
    var cityName: String = "Loading..."
    var weatherDescription: String?
    var temperature: String = ""
    var humidity: Double?
    
    init() {
    }
    
//    init(weathermodel: WeatherModel, forecastModel: ForecastModel){
//
//        self.cellsData = GetCellData(timeZoneDifference: weathermodel.timezone, weatherByDays: forecastModel.list)
//        self.cityName = weathermodel.name
//        self.weatherDescription = forecastModel.list.first?.weather.first!.description
//        self.temperature = String(format: "%.0f°", forecastModel.list.first!.main.temp)
//        self.humidity = Double(((forecastModel.list.first?.main.humidity)!))/100
//    }
//
//
//    private func GetCellData(timeZoneDifference: TimeInterval, weatherByDays: [WeatherByTime]) -> [CellData] {
//
//        var result = [CellData]()
//        weatherByDays.enumerated().forEach( { (index, element) in
//            let cellData = CellData(weatherByDay: element, timeZoneDifference: timeZoneDifference)
//            result.append(cellData)
//        })
//        return result
//    }
    
//    mutating func setViewData(weathermodel: WeatherModel, forecastModel: ForecastModel) {
//        
//        cellsData = GetCellData(timeZoneDifference: weathermodel.timezone, weatherByDays: forecastModel.list)
//        cityName = weathermodel.name
//        weatherDescription = forecastModel.list.first?.weather.first!.description
//        temperature = String(format: "%.0f°", forecastModel.list.first!.main.temp)
//        humidity = Double(((forecastModel.list.first?.main.humidity)!))/100
//        
//    }
    
}
