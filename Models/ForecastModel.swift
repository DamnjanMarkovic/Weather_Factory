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

struct CityJSON: Decodable {
    var name: String

}



struct ResponseData: Decodable {
    var person: [Person]
}
struct Person : Decodable {
    var name: String
    var age: String
    var employed: String
}


