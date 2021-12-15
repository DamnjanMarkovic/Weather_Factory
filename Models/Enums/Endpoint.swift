//
//  Endpoint.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 8.12.21..
//

import Foundation

enum Endpoint {
    
    case weather
    case forecast
    case jsonLocalFileName
    
    var urlString: String {
        switch self {
            case .weather:
                return Constants.URLs.WEATHER_BASE
            case .forecast:
                return Constants.URLs.FORECAST_BASE
            case .jsonLocalFileName:
                return Constants.URLs.CITIES_FILE_NAME
        }
    }
}

enum Method: String {
    case GET    
}
