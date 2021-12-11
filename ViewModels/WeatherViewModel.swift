//
//  WeatherViewModel.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

//WeatherViewModel will make code decoupled, easier to understand, more reusable and easier to test.
//Also, two additional ViewModel are being used - ViewData and CellData.
    
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

        let cityName = UserDefaults.standard.string(forKey: "CityName") ?? "Belgrade"
        getTempForCity(cityName: cityName)
    }
    
    //In order to provide auto-suggestion, all cities are set in the JSON file. At the instantiating of the app,
    //a list of CityNames is established. When weather is requested, auto-suggestion reads from the list.
    //Combine is used to fetch data from locally saved json.
    
    func getCityNames() {
        
        citiesApiManager.getCityNamesFromJsonFile(endpoint: .jsonLocalFileName)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                     switch completion {
                     case .failure(let error):
                         guard let self = self else { return }
                         self.error.value = error.localizedDescription
                     case .finished: break
                     }
                 }, receiveValue: { [weak self] (cityNames) in
                     guard let self = self else { return }
                     self.cityNames = cityNames.map({ (city: CityModel) -> String in
                         city.name.uppercased()
                 })
            })
            .store(in: &cancellables)
    }
    
    
    //Since calling two APIs is given as an assignement, two main models are present (WeatherModel and ForecastModel).
    //It could have been done with only one model and one call considering all currently requested data could be fetched from WeatherForecast, but we do not know what will be demands if we extend the app.
    //Having two diffent models is set by using Publishers.Zip (along with Combine).

    func getTempForCity(cityName: String) {
        
        showSpinner.value = TurnSpinner.ON
        
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
                        guard let self = self else { return }
                        self.error.value = "No Data Available"
                    case .finished: break
                    }
                }, receiveValue: { [weak self] weatherModelArrived, forecastModelArrived in

                    guard let self = self else { return }
                    
                    let timeZoneDifference = weatherModelArrived.timezone
                        
                    var cells = [CellData]()
                    
                    forecastModelArrived.list.enumerated().forEach( { (index, element) in
                        var cellData = CellData()
                        cellData.setCellData(weatherByDay: element, timeZoneDifference: timeZoneDifference)
                        cells.append(cellData)
                    })
                    self.viewData.value?.cellsData = cells
                    self.viewData.value?.cityName = weatherModelArrived.name
                    self.viewData.value?.weatherDescription = forecastModelArrived.list.first?.weather.first!.description                    
                    self.viewData.value?.temperature = String(format: "%.0f°", forecastModelArrived.list.first!.main.temp)
                    self.viewData.value?.humidity = Double(((forecastModelArrived.list.first?.main.humidity)!))/100
                    
                    UserDefaults.standard.set(cityName, forKey: "CityName")
                    self.showSpinner.value = TurnSpinner.OFF
                })
                .store(in: &cancellables)
        }
        else {
            self.error.value = "No such city"
        }
    }
    
    //Check if special characters present
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
    
    //Autocomplete function
        
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
