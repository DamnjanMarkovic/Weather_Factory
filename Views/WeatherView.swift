//
//  WeatherView.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

extension WeatherView: WeatherDelegate {
    func errorOccured(_ error: String) {
        DispatchQueue.main.async {
            self.lblCityName.adjustsFontSizeToFitWidth = true
            self.lblCityName.text = error
            self.lblCityName.textColor = UIColor.red
        }
    }
    
    func turnSpinner(_ with: TurnSpinner) {
        switch with {
        case .ON:
            showSpinner()
        case .OFF:
            hideSpinner()
        }
    }
    func updateWeather(weatherViewModel: WeatherViewModel) {
        DispatchQueue.main.async {
            self.weatherViewModel = weatherViewModel
        }
    }

}

class WeatherView: UIViewController {


    @IBOutlet var lblWeatherDescription: UILabel!
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
    
    private(set) var weatherViewModel : WeatherViewModel! {
        didSet {
            lblCityName.text = weatherViewModel.cityName
            lblCityName.textColor = UIColor.white
            lblTemp.text = "\(weatherViewModel.temperature ?? "0°")"
            lblWeatherDescription.text = weatherViewModel.weatherDescription
            self.renderTableViewdataSource(weatherViewModel)
        }
    }
    
    var weatherController = WeatherController()
    
    private var dataSourceWeather:WeatherDataSource<CellViewModel>?
    private var dataSourceDailyWeather:WeatherDataSource<CellViewModel>?
    @IBOutlet weak var collectionViewWeather: UICollectionView!
    @IBOutlet weak var collectionViewForecast: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherController.delegate = self
        collectionViewWeather.delegate = self
        collectionViewForecast.delegate = self
    }
    

    
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
    
    
    func renderTableViewdataSource(_ weatherVCModel: WeatherViewModel){
        
        if weatherVCModel.weatherCellViewModels.count > 0 {
            
            dataSourceWeather = WeatherDataSource.displayWeatherCell(for: (Array<CellViewModel>(weatherVCModel.weatherCellViewModels.prefix(upTo:8)) as [CellViewModel]), withCellidentifier: CellWeather.identifier, collectionView: collectionViewWeather)
            collectionViewWeather.dataSource = dataSourceWeather
            
            dataSourceDailyWeather = WeatherDataSource.displayForecastCell(for: (Array<CellViewModel>(weatherVCModel.weatherCellViewModels[5..<weatherVCModel.weatherCellViewModels.count]) as [CellViewModel]),
              withCellidentifier: CellForecast.identifier, collectionView: collectionViewForecast)
            collectionViewForecast.dataSource = dataSourceDailyWeather
        }
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
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return ((searchTextField.text?.isEmpty) != nil)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {

            weatherController.getTempForCity(cityName: city)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !weatherController.autoCompleteText( in : textField, using: string, suggestionsArray: weatherController.cityNames)
    }

}





