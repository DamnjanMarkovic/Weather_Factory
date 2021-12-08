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
    func toggleSpinner()
}


    
class WeatherController  {
        
    private var cancellables = Set<AnyCancellable>()
    var delegate: WeatherDelegate?
    
    var weatherApiManager: WeatherAPIManager!
    var citiesApiManager: CitiesAPIManager!
    private let apiManager = APIManager()
    
    private(set) var weatherViewModel : WeatherViewModel! {
        didSet {
            self.delegate?.updateWeather(weatherViewModel: weatherViewModel)
        }
    }
    
    private(set) var cityNames : [String]! {
        didSet {
            print(cityNames!)
        }
    }
    
    
    init() {
        
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
                         print(self?.cityNames as Any)
                         print((error))
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
        
        
        Publishers.Zip(weatherApiManager.getWeather(endpoint: .weather, cityName: cityName),
                       weatherApiManager.getWeatherForecast(endpoint: .forecast, cityName: cityName))
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(self?.cityNames as Any)
                    print(error)
                case .finished: break
                }
            }, receiveValue: { [weak self] weatherModelArrived, forecastModelArrived in
                    self?.weatherViewModel = WeatherViewModel(weathermodel: weatherModelArrived, forecastModel: forecastModelArrived)
                UserDefaults.standard.set(cityName, forKey: "CityName")
            })
            .store(in: &cancellables)
        
        
        

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
        
    
//    var usersSubject = PassthroughSubject<[WeatherModel], Error>()

    
}
