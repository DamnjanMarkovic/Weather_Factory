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


//class WeatherVCManager : ObservableObject {
    
class WeatherController  {
//        @Published var value = ""
        
        private var cancellables = Set<AnyCancellable>()
        

    
    var delegate: WeatherDelegate?
    
    
    var webService: WeatherService!
    private let apiManager = APIManager()
    
    private(set) var weatherViewModel : WeatherViewModel! {
        didSet {
            self.delegate?.updateWeather(weatherViewModel: weatherViewModel)
        }
    }
    
    init() {
        webService = WeatherService(apiManager: apiManager)
        
        
        if let path = Bundle.main.path(forResource: "People", ofType: "json") {
            let peoplesArray = try! JSONSerialization.jsonObject(
                    with: Data(contentsOf: URL(fileURLWithPath: path)),
                    options: JSONSerialization.ReadingOptions()
            ) as? [AnyObject]
            for people in peoplesArray! {
                print(people)
            }
        }
        
        
        
        
        
        getTempForCity(cityName: "Belgrade")
    }
        
    
    var usersSubject = PassthroughSubject<[WeatherModel], Error>()
    
    func getTempForCity(cityName: String) {
        
        
        Publishers.Zip(webService.getWeather(endpoint: .weather, cityName: cityName),
                       webService.getWeatherForecast(endpoint: .weatherForecast, cityName: cityName))
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] weatherModelArrived, weatherForecastModelArrived in
                    
                    self?.weatherViewModel = WeatherViewModel(weathermodel: weatherModelArrived, weatherForecastModel: weatherForecastModelArrived)                    
            })
            .store(in: &cancellables)
        
        
        

    }
    
}
