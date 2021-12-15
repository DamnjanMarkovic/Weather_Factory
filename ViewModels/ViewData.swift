//
//  ViewData.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 10.12.21..
//

import Foundation
import UIKit

struct ViewData {
    
    var cellsData: [CellData] = []
    var cityName: String = "Loading..."
    var weatherDescription: String?
    var temperature: String?
    var humidity: Double?
    
    init() {
    }
}
