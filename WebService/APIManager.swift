//
//  APIManager.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 6.12.21..
//

import UIKit
import Combine

protocol APIService {
            
    func getData<T: Decodable>(for urlRequest: URLRequest) -> AnyPublisher<T, Error>
}

 class APIManager : APIService {
     
     private var subscribers = Set<AnyCancellable>()
     
     
     func getData<T>(for urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
         
                URLSession
                    .shared
                    .dataTaskPublisher(for: urlRequest)
                    .tryMap{ $0.data }
                    .decode(type: T.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
     }
     
     
     
//     func getDataFromWeb<T>(for urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
//
//            URLSession.shared
//            .dataTaskPublisher(for: urlRequest)
//            .tryMap { element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse,
//                    httpResponse.statusCode == 200 else {
//                        throw URLError(.badServerResponse)
//                    }
//
//                return element.data
//            }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//  }
     
     
}
     
