//
//  NetworkHelpers.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 10.12.21..
//

import UIKit

struct NetworkHelpers {
    
    static func request(for endpoint: URL, method: Method) -> URLRequest {
   
           var request = URLRequest(url: endpoint)
           request.httpMethod = "\(method)"
           request.allHTTPHeaderFields = ["Content-Type": "application/json"]
           return request
    }
}
