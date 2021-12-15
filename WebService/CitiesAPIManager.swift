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

    func getCityNamesFromJsonFile(endpoint: Endpoint) -> AnyPublisher<[CityModel], CustomError> {
        let url = Bundle.main.url(forResource: "\(endpoint.urlString)", withExtension: "json")
        let urlRequest = NetworkHelpers.request(for: url!, method: .GET)
        return apiManager.getData(for: urlRequest)
    }
}
