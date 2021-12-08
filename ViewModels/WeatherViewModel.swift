//
//  WeatherViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation


struct WeatherViewModel {
    
    var weatherCellViewModels = [CellViewModel]()
    var dailyWeatherCellViewModel = [CellViewModel]()
    var cityName: String
    var weatherDescription: String
    var temperature: String
    var humidity: Double
    
    
    
    
    init(weathermodel: WeatherModel, forecastModel: ForecastModel){
        var forecastCellViewModels = [CellViewModel]()
        var weatherCellViewModels = [CellViewModel]()
        let timeZoneDifference = weathermodel.timezone
        
        
        forecastModel.list.enumerated().forEach( { (index, element) in

            if index < 8 {
                let weatherCellViewModel = CellViewModel(weatherByDay: element, timeZoneDifference: timeZoneDifference)

                weatherCellViewModels.append(weatherCellViewModel)
            }
            
            let forecastCellViewModel = CellViewModel(weatherByDay: element, timeZoneDifference: timeZoneDifference)
            forecastCellViewModels.append(forecastCellViewModel)

        })
        
        self.weatherCellViewModels = forecastCellViewModels
        self.dailyWeatherCellViewModel = weatherCellViewModels
        self.cityName = weathermodel.name
        self.weatherDescription = weathermodel.weather.first!.description
        self.temperature = String(format: "%.0f°", weathermodel.main.temp)
        self.humidity = Double((weathermodel.main.humidity))/100
    }

}
