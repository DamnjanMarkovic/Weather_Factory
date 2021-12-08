//
//  WeatherView.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

extension WeatherView: WeatherDelegate {

    
    func updateWeather(weatherViewModel: WeatherViewModel) {
        DispatchQueue.main.async {

            self.weatherVCModel = weatherViewModel
        }
    }
    func toggleSpinner() {
        if spinnerShowing {
            hideSpinner()
        }
        else {
            showSpinner()
        }
    }
}


class WeatherView: UIViewController {

    @IBOutlet var stackViewWeatherCells: UIStackView!
    
    @IBOutlet var lblWeatherDescription: UILabel!
    @IBOutlet var stackViewWeatherDays: UIStackView!

    @IBOutlet var lblWeatherDaysTitle: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var lblCityName: UILabel!
    @IBOutlet var lblTemp: UILabel!    

    private var spinnerShowing: Bool = false
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var uiViewSpinner: UIView! {
      didSet {
          uiViewSpinner.layer.cornerRadius = 6
      }
    }
    
    
    
    private var dataSourceWeather:WeatherDataSource<CellViewModel>?
    private var dataSourceDailyWeather:WeatherDataSource<CellViewModel>?
    @IBOutlet weak var collectionViewWeather: UICollectionView!
    @IBOutlet weak var collectionViewForecast: UICollectionView!
    
    
    
    private(set) var weatherVCModel : WeatherViewModel! {
        didSet {
            lblCityName.text = weatherVCModel.cityName
            lblTemp.text = "\(weatherVCModel.temperature)"
            lblWeatherDescription.text = weatherVCModel.weatherDescription
            self.renderTableViewdataSource(self.weatherVCModel)
            searchTextField.autocapitalizationType = .allCharacters
        }
    }
    
//    var loggedInUserEmailid:String?
//        private var error: Error? {
//            willSet(error) {
//                DispatchQueue.main.async {
//                    AlertManager.shareinstance.showAlert(on: self, alertmessageTitle: "Error occured", alertmessageContent: error?.localizedDescription ?? "")
//                }
//            }
//        }
    
    func renderTableViewdataSource(_ weatherVCModel: WeatherViewModel){
        dataSourceWeather = WeatherDataSource.displayWeatherCell(for: weatherVCModel.dailyWeatherCellViewModel, withCellidentifier: CellWeather.identifier, collectionView: collectionViewWeather)
        collectionViewWeather.dataSource = dataSourceWeather
        collectionViewWeather.delegate = self
        collectionViewWeather.reloadData()
        
        dataSourceDailyWeather = WeatherDataSource.displayForecastCell(for: weatherVCModel.weatherCellViewModels, withCellidentifier: CellForecast.identifier, collectionView: collectionViewForecast)
        collectionViewForecast.dataSource = dataSourceDailyWeather
        collectionViewForecast.delegate = self
        collectionViewForecast.reloadData()
        
        
    }
    
    
    
    
    var viewModel = WeatherController()
    
    private var subscriber: AnyCancellable?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        viewModel.delegate = self

        hideSpinner()
 
    }
    
    

    
//    private func observeViewModel() {
//            subscriber = viewModel.usersSubject.sink(receiveCompletion: { (resultCompletion) in
//                switch resultCompletion {
//                case .failure(let error):
//                    print(error.localizedDescription)
//                default: break
//                }
//            }) { (result) in
//                DispatchQueue.main.async {
//                    print(result)
//                    self.collectionView.reloadData()
//                }
//            }
//        }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        uiViewSpinner.isHidden = false
        spinnerShowing = true
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        uiViewSpinner.isHidden = true
        spinnerShowing = false
    }

}


extension WeatherView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewForecast {
            return CGSize(width: 90, height: 110)
            }
        else {
            return CGSize(width: 50, height: 100)
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherView: UITextFieldDelegate {

    @IBAction func btnSearchCity(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
//        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return ((searchTextField.text?.isEmpty) != nil)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {

            viewModel.getTempForCity(cityName: city)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !viewModel.autoCompleteText( in : textField, using: string, suggestionsArray: viewModel.cityNames)
    }

}





