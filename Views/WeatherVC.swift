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
            self.collectionViewDays.reloadData()
            self.collectionView.reloadData()
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
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewDays: UICollectionView!
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
    
    private(set) var weatherVCModel : WeatherVCModel! {
        didSet {
            lblCityName.text = weatherVCModel.cityName
            lblTemp.text = "\(weatherVCModel.temperature)"
            lblWeatherDescription.text = weatherVCModel.weatherDescription

            
        }
    }
    
    var viewModel = WeatherVCManager()
    
    private var subscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchTextField.delegate = self
        viewModel.delegate = self
        
        collectionView.register(DailyWeatherCell.nib(), forCellWithReuseIdentifier: DailyWeatherCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewDays.register(WeatherCell.nib(), forCellWithReuseIdentifier: WeatherCell.identifier)
        collectionViewDays.delegate = self
        collectionViewDays.dataSource = self
        
        stackViewWeatherCells.layer.cornerRadius = 10
        stackViewWeatherDays.layer.cornerRadius = 10
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

extension WeatherVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if weatherVCModel?.weatherCellViewModels.count ?? 0 > 0 {
            if collectionView == self.collectionViewDays {
                return weatherVCModel.weatherCellViewModels.count
                }
            else {
                return weatherVCModel.dailyWeatherCellViewModel.count
                }
            }
        else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewDays {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
            cell.configure(with: weatherVCModel.weatherCellViewModels[indexPath.row])

            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as! DailyWeatherCell
            cell.configure(with: weatherVCModel.dailyWeatherCellViewModel[indexPath.row])
            
            return cell
            
        }
    }
    

    

}

extension WeatherVC: UICollectionViewDelegateFlowLayout {
    
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





