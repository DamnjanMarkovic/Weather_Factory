//
//  APIManager.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 6.12.21..
//

import UIKit
import Combine


 class APIManager : APIService {
     
     func getData<T>(for urlRequest: URLRequest) -> AnyPublisher<T, CustomError> where T : Decodable {
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
             .map(\.data)
             .decode(type: T.self, decoder: JSONDecoder())
             .mapError({ error in
                 switch error {
                   case is Swift.DecodingError:
                        return .parsingError
                   case let urlError as URLError:
                        return .urlError(error: urlError)
                   default:
                        return .other(error: error)
               }
             })
             .eraseToAnyPublisher()
     }
}
     
