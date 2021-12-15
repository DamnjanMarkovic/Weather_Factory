//
//  CustomError.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 9.12.21..
//

import Foundation

public enum CustomError: Error {
    
    case urlError(error: URLError)
    case parsingError
    case other(error: Error)
}

