//
//  TimeConverterTests.swift
//  FactoryWeatherTests
//
//  Created by Damnjan Markovic on 11.12.21..
//

import XCTest
@testable import FactoryWeather

var sutTimeConverter: TimeConverter!
class TimeConverterTests: XCTestCase {

    override func setUpWithError() throws {
      try super.setUpWithError()

        sutTimeConverter = TimeConverter()
        
    }

    override func tearDownWithError() throws {
        sutTimeConverter = nil
        try super.tearDownWithError()
    }
    

    func testgetTimeFromMS() {
        
        let guessMS = 1639245600
        //Full date: 2021-12-11 18:00:00
        //Should return "19"
        let result = TimeConverter.getTimeFromMS(time: guessMS)
        
        XCTAssertEqual(result, "19")
    }
    
    func testgetDayNameFromMS() {
        
        let guessMS = 1639245600
        //Full date: 2021-12-11 18:00:00
        //Should return "Sat"
        let result = TimeConverter.getDayNameFromMS(time: guessMS)
        
        XCTAssertEqual(result, "Sat")
    }


}
