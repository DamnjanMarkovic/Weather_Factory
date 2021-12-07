//
//  WeatherModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//

import Foundation

struct WeatherModel: WeatherProtocol, Codable {
    var weather: [Weather]
    var main: Main
    var name: String
    var timezone: TimeInterval
}
struct Main: Codable {
    var temp: Double
    var humidity: Int
}

struct Weather: Codable {
    var main: String
    var description: String
}
struct User: Decodable {
    var id: Int
    var name: String
    var email: String
}


