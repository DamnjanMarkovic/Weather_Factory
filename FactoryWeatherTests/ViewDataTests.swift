//
//  CellDataTests.swift
//  FactoryWeatherTests
//
//  Created by Damnjan Markovic on 11.12.21..
//

import XCTest
@testable import FactoryWeather

var sutCellData: ViewData!
class ViewDataTests: XCTestCase {

    override func setUpWithError() throws {
      try super.setUpWithError()

        sutCellData = ViewData()
        
    }

    override func tearDownWithError() throws {
        sutCellData = nil
        try super.tearDownWithError()
    }
    
    func testIfViewDataCorrect() {
        
        let main = Main(temp: 10, humidity: 67)
        let weather01: [Weather] = [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")]
        let weather02: [Weather] = [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")]
        let weather03: [Weather] = [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")]
        let weather04: [Weather] = [Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02d")]
        let weather05: [Weather] = [Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02n")]

        let weatherByTime: [WeatherByTime] = [WeatherByTime(main: main, weather: weather01, dt: 1639224000),
                                              WeatherByTime(main: main, weather: weather02, dt: 1639234800),
                                              WeatherByTime(main: main, weather: weather03, dt: 1639245600),
                                              WeatherByTime(main: main, weather: weather04, dt: 1639256400),
                                              WeatherByTime(main: main, weather: weather05, dt: 1639267200)
        ]

        let weatherModel = WeatherModel(name: "Miami", timezone: -18000)
            
        var cells = [CellData]()
        
        weatherByTime.enumerated().forEach( { (index, element) in
            let forecastCellViewModel = CellData(weatherByDay: weatherByTime[0], timeZoneDifference: -18000)
            cells.append(forecastCellViewModel)
        })
        
        sutCellData.cellsData = cells
        sutCellData.cityName = weatherModel.name
        sutCellData.weatherDescription = "scattered clouds"
        sutCellData.temperature = String(format: "%.0f°", main.temp)
        sutCellData.humidity = Double(main.humidity)/100

        XCTAssertNotNil(sutCellData, "Model setting error")
    }



}
