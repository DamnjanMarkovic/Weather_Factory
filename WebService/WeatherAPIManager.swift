//
//  WeatherService.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 6.12.21..
//

import UIKit
import Combine


struct WeatherAPIManager {
    
    private let apiManager: APIService
    
    init(apiManager: APIService) {
        self.apiManager = apiManager
    }
    

    func getWeather(endpoint: Endpoint, cityName: String) -> AnyPublisher<WeatherModel, CustomError> {
        
        guard let url = URL(string: "\(endpoint.urlString)?appid=\(Constants.API_KEY)&units=metric&q=\(cityName)")
            else { preconditionFailure("Bad URL") }
        
        let urlRequest = NetworkHelpers.request(for: url, method: .GET)
        
        return apiManager.getData(for: urlRequest)
    }

    func getWeatherForecast(endpoint: Endpoint, cityName: String) -> AnyPublisher<ForecastModel, CustomError> {
        
        guard let url = URL(string: "\(endpoint.urlString)?appid=\(Constants.API_KEY)&units=metric&q=\(cityName)")
            else { preconditionFailure("Bad URL") }
        
        let urlRequest = NetworkHelpers.request(for: url, method: .GET)
        
        return apiManager.getData(for: urlRequest)
    }
    
}




