//
//  WeatherView.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

extension WeatherVC: WeatherDelegate {

    
    func updateWeather(weatherViewModel: WeatherVCModel) {
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


class WeatherVC: UIViewController {

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
    
    
    
    private var dataSourceWeather:WeatherVCDataSource<WeatherCellViewModel>?
    private var dataSourceDailyWeather:WeatherVCDataSource<WeatherCellViewModel>?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewDays: UICollectionView!
    
    
    
    private(set) var weatherVCModel : WeatherVCModel! {
        didSet {
            lblCityName.text = weatherVCModel.cityName
            lblTemp.text = "\(weatherVCModel.temperature)"
            lblWeatherDescription.text = weatherVCModel.weatherDescription
            self.renderTableViewdataSource(self.weatherVCModel)
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
    
    func renderTableViewdataSource(_ weatherVCModel: WeatherVCModel){
        dataSourceWeather = WeatherVCDataSource.displayDataWeatherCell(for: weatherVCModel.dailyWeatherCellViewModel, withCellidentifier: WeatherCell.identifier, collectionView: collectionView)
        collectionView.dataSource = dataSourceWeather
        collectionView.delegate = self
        collectionView.reloadData()
        
        dataSourceDailyWeather = WeatherVCDataSource.displayDataDailyWeatherCell(for: weatherVCModel.weatherCellViewModels, withCellidentifier: DailyWeatherCell.identifier, collectionView: collectionViewDays)
        collectionViewDays.dataSource = dataSourceDailyWeather
        collectionViewDays.delegate = self
        collectionViewDays.reloadData()
        
        
    }
    
    
    
    
    var viewModel = WeatherVCManager()
    
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


extension WeatherVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewDays {
            return CGSize(width: 90, height: 110)
            }
        else {
            return CGSize(width: 50, height: 100)
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherVC: UITextFieldDelegate {

    @IBAction func btnSearchCity(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Enter something"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {

            viewModel.getTempForCity(cityName: city)

        }
        

    }
}





