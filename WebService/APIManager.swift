//
//  APIManager.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 6.12.21..
//

import UIKit
import Combine

protocol APIManagerService {
      func fetchWeather<T: Decodable>(for url: String, method: Method) -> AnyPublisher<T, Error>
}



 struct APIManager : APIManagerService {
     
     
  func fetchWeather<T>(for urlRequest: String, method: Method) -> AnyPublisher<T, Error> where T : Decodable {
     
     let urlRequest = request(for: urlRequest, method: method)
     
     return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
  }
 
 
 
 
  func request(for endpoint: String, method: Method) -> URLRequest {
         
         guard let url = URL(string: endpoint)
             else { preconditionFailure("Bad URL") }
 
         var request = URLRequest(url: url)
         request.httpMethod = "\(method)"
         request.allHTTPHeaderFields = ["Content-Type": "application/json"]
         return request
  }
    

}


