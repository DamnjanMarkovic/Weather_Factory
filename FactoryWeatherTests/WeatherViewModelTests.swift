//
//  FactoryWeatherTests.swift
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
        XCTAssertFalse(result, "Special character check is wrong.")
    }
    
    func testIfSpecialCharactersExist() {
        let guess = "@|][testcharacters"
        let result = sutWeatherViewModel.containsSpecialCharacters(string: guess)
        XCTAssertTrue(result, "Special characters check is wrong.")
    }
    
    func testAutoCompleteTextFalse() {
        
        let guessTextField = UITextField()
        let guessString = "a"
        let guessStringArray: [String] = ["laptop", "phone", "car", "mouse"]
        
        let result = sutWeatherViewModel.autoCompleteText(in: guessTextField, using: guessString, suggestionsArray: guessStringArray)
        
        XCTAssertFalse(result, "Auto Complete wrong.")
    }
    
    func testAutoCompleteTextTrue() {
        
        let guessTextField = UITextField()
        let guessString = "laptop"
        let guessStringArray: [String] = ["laptop", "phone", "car", "mouse"]
        
        let result = sutWeatherViewModel.autoCompleteText(in: guessTextField, using: guessString, suggestionsArray: guessStringArray)
        
        XCTAssertTrue(result, "Auto Complete wrong.")
    }

}
