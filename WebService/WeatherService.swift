//
//  WeatherService.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 6.12.21..
//

import UIKit
import Combine

struct WeatherService {
    
    private let apiManager: APIManagerService
    
    init(apiManager: APIManagerService) {
        self.apiManager = apiManager
    }
    
    func getWeather(endpoint: Endpoint, cityName: String) -> AnyPublisher<WeatherModel, Error> {

        let url = "\(endpoint.urlString)&q=\(cityName)"
        
        return apiManager
            .fetchWeather(for: url, method: .GET)
    }
    
    func getWeatherForecast(endpoint: Endpoint, cityName: String) -> AnyPublisher<WeatherForecastModel, Error> {

        let url = "\(endpoint.urlString)&q=\(cityName)"
        
        return apiManager
            .fetchWeather(for: url, method: .GET)
    }

}

enum Endpoint {
    case weather
    case weatherForecast
    
    var urlString: String {
        switch self {
        case .weather:
            return Constants.WEATHER_URL_BASE_STRING
        case .weatherForecast:
            return Constants.WEATHER_FORECAST_URL_BASE_STRING
        }
    }
}

enum Method: String {
        case GET
    
}


