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
    
    func getWeather(endpoint: Endpoint, cityName: String) -> AnyPublisher<WeatherModel, Error> {

        guard let url = URL(string: "\(endpoint.urlString)&q=\(cityName)")
            else { preconditionFailure("Bad URL") }
        
        let urlRequest = request(for: url, method: .GET)
        
        return apiManager.getData(for: urlRequest)
    }
    
    func getWeatherForecast(endpoint: Endpoint, cityName: String) -> AnyPublisher<ForecastModel, Error> {
        
        guard let url = URL(string: "\(endpoint.urlString)&q=\(cityName)")
            else { preconditionFailure("Bad URL") }
        
        let urlRequest = request(for: url, method: .GET)
        
        return apiManager.getData(for: urlRequest)
    }
    
    func getCityNamesFromJsonFile(endpoint: Endpoint) -> AnyPublisher<[CityJSON], Error> {        
        
        let url = Bundle.main.url(forResource: "\(endpoint.urlString)", withExtension: "json")
        
        let urlRequest = request(for: url!, method: .GET)
        
        return apiManager.getData(for: urlRequest)
        
    }
        
    
    func request(for endpoint: URL, method: Method) -> URLRequest {
   
           var request = URLRequest(url: endpoint)
           request.httpMethod = "\(method)"
           request.allHTTPHeaderFields = ["Content-Type": "application/json"]
           return request
    }
    

}

enum Endpoint {
    case weather
    case forecast
    case jsonLocalFileName
    
    var urlString: String {
        
        switch self {
            
            case .weather:
                return Constants.WEATHER_URL_BASE_STRING
            case .forecast:
                return Constants.WEATHER_FORECAST_URL_BASE_STRING
            
            case .jsonLocalFileName:
                return Constants.JSON_LOCAL_FILE_NAME
        }
    }
}

enum Method: String {
        case GET
    
}

