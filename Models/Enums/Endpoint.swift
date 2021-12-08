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
