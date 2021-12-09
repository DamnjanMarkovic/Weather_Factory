//
//  WeatherCurrentViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

protocol WeatherDelegate {
    func updateWeather(weatherViewModel: WeatherViewModel)
    func turnSpinner(_ with: TurnSpinner)
    func errorOccured(_ error: String)
}
    
final class WeatherController: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    
    private let apiManager = APIManager()
    private var weatherApiManager: WeatherAPIManager!
    private var citiesApiManager: CitiesAPIManager!
    var cityNames = [String]()
    
    var delegate: WeatherDelegate?
    
    private(set) var weatherViewModel : WeatherViewModel! {
        didSet {
            self.delegate?.updateWeather(weatherViewModel: weatherViewModel)
            
            delegate?.turnSpinner(TurnSpinner.OFF)
        }
    }
    
    private(set) var error : String! {
        didSet {
            self.delegate?.errorOccured(error)
            delegate?.turnSpinner(TurnSpinner.OFF)
        }
    }
    
   
    
    init() {
        
        delegate?.turnSpinner(TurnSpinner.ON)
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
                         self?.error = error.localizedDescription
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
        
        delegate?.turnSpinner(TurnSpinner.ON)
        
        //check if cityName is in the cityList && has special characters
        
        if cityNames.contains(cityName) && !containsSpecialCharacters(string: cityName)
        {
            Publishers.Zip(weatherApiManager.getWeather(endpoint: .weather, cityName: cityName),
                           weatherApiManager.getWeatherForecast(endpoint: .forecast, cityName: cityName))
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .mapError { error -> CustomError in
                    return error
                        }
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(_):
                        guard self != nil else { return }
                        self?.error = "No Data Available"
                    case .finished: break
                    }
                }, receiveValue: { [weak self] weatherModelArrived, forecastModelArrived in
                        self?.weatherViewModel = WeatherViewModel(weathermodel: weatherModelArrived, forecastModel: forecastModelArrived)
                    UserDefaults.standard.set(cityName, forKey: "CityName")
                })
                .store(in: &cancellables)
        }
        else {
            self.error = "That city doesn't exists"
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
