//
//  CitiesAPIManager.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 8.12.21..
//

import UIKit
import Combine

struct CitiesAPIManager {
    
    private let apiManager: APIService
    
    init(apiManager: APIService) {
        self.apiManager = apiManager
    }
    

    func getCityNamesFromJsonFile(endpoint: Endpoint) -> AnyPublisher<[CityJSON], CustomError> {
        
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
