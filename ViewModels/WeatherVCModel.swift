//
//  WeatherViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation


struct WeatherVCModel {
    
    var weatherCellViewModels = [WeatherCellViewModel]()
    var dailyWeatherCellViewModel = [WeatherCellViewModel]()
    var cityName: String
    var weatherDescription: String
    var temperature: String
    var humidity: Double
    
    init() {
        weatherCellViewModels = [WeatherCellViewModel]()
        dailyWeatherCellViewModel = [WeatherCellViewModel]()
        cityName = ""
        weatherDescription = ""
        temperature = ""
        humidity = 0
    }
    
    
    init(weathermodel: WeatherModel, weatherForecastModel: WeatherForecastModel){
        var IsDay = false
        var weatherCellViewModels = [WeatherCellViewModel]()
        var dailyWeatherCellViewModels = [WeatherCellViewModel]()
        var positionOfTheDay = 0
        let timeZoneDifference = weathermodel.timezone
        var dayInTheWeek = ""
        
        weatherForecastModel.list.forEach { element in
            
            
            IsDay = TimeConverter.CheckIfIsDay(positionOfTheDay: positionOfTheDay, time: element.dt+timeZoneDifference,
                                 sunrise: weatherForecastModel.city.sunrise+timeZoneDifference,
                                 sunset: weatherForecastModel.city.sunset+timeZoneDifference)
            
            
            if (dayInTheWeek != TimeConverter.getDayNameFromMS(time: Int(element.dt+timeZoneDifference))) {
                positionOfTheDay += 1
                dayInTheWeek = TimeConverter.getDayNameFromMS(time: Int(element.dt+timeZoneDifference))
            }



                
                let weatherCellViewModel = WeatherCellViewModel(weatherByDay: element, IsDay: IsDay, timeZoneDifference: timeZoneDifference
                )
                weatherCellViewModels.append(weatherCellViewModel)

            if (positionOfTheDay < 2) {
                let dailyWeatherCellViewModel = WeatherCellViewModel(weatherByDay: element, IsDay: IsDay, timeZoneDifference: timeZoneDifference)
                
                
                dailyWeatherCellViewModels.append(dailyWeatherCellViewModel)
            }

        }
        
        self.weatherCellViewModels = weatherCellViewModels
        self.dailyWeatherCellViewModel = dailyWeatherCellViewModels
        self.cityName = weathermodel.name
        self.weatherDescription = weathermodel.weather.first!.description
        self.temperature = String(format: "%.0f°", weathermodel.main.temp)
        self.humidity = Double((weathermodel.main.humidity))/100
    }

}
