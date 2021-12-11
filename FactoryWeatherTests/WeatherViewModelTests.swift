//
//  WeatherViewModelTests.swift
//  FactoryWeatherTests
//
//  Created by Damnjan Markovic on 3.12.21..
//

import XCTest
@testable import FactoryWeather

var sutWeatherViewModel: WeatherViewModel!
class WeatherViewModelTests: XCTestCase {

    override func setUpWithError() throws {
      try super.setUpWithError()
      sutWeatherViewModel = WeatherViewModel()
    }

    override func tearDownWithError() throws {
      sutWeatherViewModel = nil
      try super.tearDownWithError()
    }
    
    func testIfSpecialCharactersNotExist() {
        let guess = "testcharacters"
        let result = sutWeatherViewModel.containsSpecialCharacters(string: guess)
        XCTAssertFalse(result)
    }
    
    func testIfSpecialCharactersExist() {
        let guess = "@|][testcharacters"
        let result = sutWeatherViewModel.containsSpecialCharacters(string: guess)
        XCTAssertTrue(result)
    }
    
    func testAutoCompleteTextFalse() {
        
        let guessTextField = UITextField()
        let guessString = "a"
        let guessStringArray: [String] = ["laptop", "phone", "car", "mouse"]
        
        let result = sutWeatherViewModel.autoCompleteText(in: guessTextField, using: guessString, suggestionsArray: guessStringArray)
        
        XCTAssertFalse(result)
    }
    
    func testAutoCompleteTextTrue() {
        
        let guessTextField = UITextField()
        let guessString = "laptop"
        let guessStringArray: [String] = ["laptop", "phone", "car", "mouse"]
        
        let result = sutWeatherViewModel.autoCompleteText(in: guessTextField, using: guessString, suggestionsArray: guessStringArray)
        
        XCTAssertTrue(result)
    }

}
