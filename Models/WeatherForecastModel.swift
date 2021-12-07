//
//  WeatherForecastModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation

protocol WeatherProtocol {
}

struct WeatherForecastModel: WeatherProtocol, Codable {
    var list: [WeatherByDays]
    var city: City
}

struct WeatherByDays: Codable {

    var main: Main
    var weather: [Weather]
    var dt: TimeInterval
    
}

struct City: Codable {
    var name: String
    var country: String
    var sunrise: TimeInterval
    var sunset: TimeInterval
}


