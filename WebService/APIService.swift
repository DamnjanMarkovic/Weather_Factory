//
//  APIService.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 10.12.21..
//

import UIKit
import Combine


protocol APIService {

    func getData<T: Decodable>(for urlRequest: URLRequest) -> AnyPublisher<T, CustomError>
}
