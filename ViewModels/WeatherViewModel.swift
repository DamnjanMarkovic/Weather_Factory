//
//  WeatherCurrentViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

    
final class WeatherViewModel {
    
    
    private let apiManager = APIManager()
    private var weatherApiManager: WeatherAPIManager!
    private var citiesApiManager: CitiesAPIManager!
    var cityNames = [String]()
    
    private var cancellables = Set<AnyCancellable>()
    
    //Observable properties
    let viewData: CustomListener<ViewData?> = CustomListener(ViewData())
    let error = CustomListener("")
    let showSpinner = CustomListener(TurnSpinner.OFF)
    
    
    init() {
        
        showSpinner.value = TurnSpinner.ON
        weatherApiManager = WeatherAPIManager(apiManager: apiManager)
        citiesApiManager = CitiesAPIManager(apiManager: apiManager)
        
        getCityNames()

        guard let cityName = UserDefaults.standard.string(forKey: "CityName") else { return }
        getTempForCity(cityName: cityName)
    }
    


    func getCityNames() {
        
        citiesApiManager.getCityNamesFromJsonFile(endpoint: .jsonLocalFileName)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                     switch completion {
                     case .failure(let error):
                         guard self != nil else { return } 
                         self?.error.value = error.localizedDescription
                     case .finished: break
                     }
                 }, receiveValue: { [weak self] (cityNames) in
                     self!.cityNames = cityNames.map({ (city: CityJSON) -> String in
                         city.name.uppercased()
                 })
            })
            .store(in: &cancellables)
    }
    

    func getTempForCity(cityName: String) {
        
        //check if cityName special characters
        
        let cityNameTrimmed = cityName.replacingOccurrences(of: " ", with: "")
        
        if !containsSpecialCharacters(string: cityNameTrimmed)
        {
            Publishers.Zip(weatherApiManager.getWeather(endpoint: .weather, cityName: cityNameTrimmed),
                           weatherApiManager.getWeatherForecast(endpoint: .forecast, cityName: cityNameTrimmed))
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .mapError { error -> CustomError in
                    return error
                        }
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(_):
                        guard self != nil else { return }
                        self?.error.value = "No Data Available"
                    case .finished: break
                    }
                }, receiveValue: { [weak self] weatherModelArrived, forecastModelArrived in

                    let timeZoneDifference = weatherModelArrived.timezone
                        
                    var cells = [CellData]()
                    
                    forecastModelArrived.list.enumerated().forEach( { (index, element) in
                        let forecastCellViewModel = CellData(weatherByDay: element, timeZoneDifference: timeZoneDifference)
                        cells.append(forecastCellViewModel)
                    })
                    self?.viewData.value?.cellsData = cells
                    self?.viewData.value?.cityName = weatherModelArrived.name
                    self?.viewData.value?.weatherDescription = weatherModelArrived.weather.first!.description
                    self?.viewData.value?.temperature = String(format: "%.0f°", weatherModelArrived.main.temp)
                    self?.viewData.value?.humidity = Double((weatherModelArrived.main.humidity))/100
                    
                    UserDefaults.standard.set(cityName, forKey: "CityName")
                    self?.showSpinner.value = TurnSpinner.OFF
                })
                .store(in: &cancellables)
        }
        else {
            self.error.value = "No such city"
        }
    }
    
    func containsSpecialCharacters(string: String) -> Bool {
          
          do {
              let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
              if let _ = regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) {
                  return true
              } else {
                  return false
              }
          } catch {
              return true
          }
    }
        
    func autoCompleteText( in textField: UITextField, using string: String, suggestionsArray: [String]) -> Bool {
            if !string.isEmpty,
                let selectedTextRange = textField.selectedTextRange,
                selectedTextRange.end == textField.endOfDocument,
                let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
                let text = textField.text( in : prefixRange) {
                let prefix = text + string
                let matches = suggestionsArray.filter {
                    $0.hasPrefix(prefix)
                }
                if (matches.count > 0) {
                    textField.text = matches[0]
                    if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                        textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                        return true
                    }
                }
            }
        return false
    }
    
}
