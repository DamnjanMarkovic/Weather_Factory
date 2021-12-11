//
//  WeatherForecastModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation

protocol WeatherProtocol {
    
}


struct ForecastModel: WeatherProtocol, Codable {
    var list: [WeatherByTime]
}

struct WeatherByTime: Codable {

    var main: Main
    var weather: [Weather]
    var dt: TimeInterval
    
}

struct Main: Codable {
    var temp: Double
    var humidity: Int
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
}









