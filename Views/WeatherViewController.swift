//
//  WeatherViewController.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    
    @IBOutlet var stackWeather: UIStackView!
    @IBOutlet var stackForecast: UIStackView!
    @IBOutlet var lblWeatherDescription: UILabel!
    @IBOutlet var lblWeatherDaysTitle: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var lblCityName: UILabel!
    @IBOutlet var lblTemp: UILabel!
//MARK: - Spinner
    private var spinnerShowing: Bool = false
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var uiViewSpinner: UIView! {
      didSet {
          uiViewSpinner.layer.cornerRadius = 6
      }
    }
//MARK: - CollectionViews
    private var dataSourceWeather:CustomDataSource<CellWeather, CellData>?
    private var dataSourceForecast:CustomDataSource<CellForecast, CellData>?
    @IBOutlet var collectionViewWeather: UICollectionView!
    @IBOutlet var collectionViewForecast: UICollectionView!
    private let viewModel = WeatherViewModel()
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegates()
        setBinding()
    }
        
//MARK: - CollectionViewCells Rendering
    func renderCollectionViewDataSource(_ cellViewModels: [CellData]){
        if cellViewModels.count > 8 {
            dataSourceWeather = CustomDataSource(models: (Array<CellData>(cellViewModels.prefix(upTo:8)) as [CellData]),
                 reuseIdentifier: CellWeather.identifier, collectionView: collectionViewWeather, configureCell: { (cell, weather) in
                        cell.configure(with: weather)
            })
            
            dataSourceForecast = CustomDataSource(models: (Array<CellData>(cellViewModels[5..<cellViewModels.count]) as [CellData]),
              reuseIdentifier: CellForecast.identifier, collectionView: collectionViewForecast, configureCell: { (cell, weather) in
                    cell.configure(with: weather)
            })
            
            collectionViewWeather.dataSource = dataSourceWeather
            collectionViewForecast.dataSource = dataSourceForecast
        }
    }
}

// MARK: Private Helpers
private extension WeatherViewController {
    
//MARK: - SetBinding
    func setBinding() {
        viewModel.viewData.bind { [weak self] viewData in
            guard let self = self else { return }
            self.lblCityName.text = viewData?.cityName
            self.lblCityName.textColor = UIColor.white
            self.lblTemp.text = "\(viewData?.temperature ?? "0°")"
            self.lblWeatherDescription.text = viewData?.weatherDescription
            self.renderCollectionViewDataSource(viewData?.cellsData ?? [])
        }
        viewModel.error.bind { [weak self] error in
            guard let self = self else { return }
            self.lblCityName.text = error
            self.lblCityName.textColor = UIColor.red
        }
        viewModel.showSpinner.bind { [weak self] turnSpinner in
            guard let self = self else { return }
            switch turnSpinner {
                case .ON:
                    self.showSpinner()
                case .OFF:
                    self.hideSpinner()
                }
        }
    }
    
//MARK: - SetUI
    func setUI() {
        stackWeather.layer.cornerRadius = 10
        stackForecast.layer.cornerRadius = 10
        let backgroundImage = UIImage(named: "background.png")
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
//MARK: - SetDelegates
    func setDelegates() {
        searchTextField.delegate = self
        collectionViewWeather.delegate = self
        collectionViewForecast.delegate = self
    }
//MARK: - SpinnerFuncs
    func showSpinner() {
        activityIndicator.startAnimating()
        uiViewSpinner.isHidden = false
        spinnerShowing = true
    }
    func hideSpinner() {
        activityIndicator.stopAnimating()
        uiViewSpinner.isHidden = true
        spinnerShowing = false
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
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

extension WeatherViewController: UITextFieldDelegate {
    
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
            viewModel.getTempForCity(cityName: city)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !viewModel.autoCompleteText( in : textField, using: string, suggestionsArray: viewModel.cityNames)
    }
}





