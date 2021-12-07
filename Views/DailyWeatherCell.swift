//
//  WeatherCell.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//


import UIKit

class DailyWeatherCell: UICollectionViewCell {

    @IBOutlet var lblTime: UILabel!    
    @IBOutlet var lblTemp: UILabel!    
    @IBOutlet var lbldayInTheWeek: UILabel!    
    @IBOutlet var image: UIImageView!
    
    static let identifier = "DailyWeatherCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "DailyWeatherCell", bundle: nil)
    }
    
    func configure(with viewModel: WeatherCellViewModel) {
        lblTime.text = viewModel.time
        lblTemp.text = "\(viewModel.temperature)"
        lbldayInTheWeek.text = viewModel.dayInTheWeek
        
        if viewModel.isDay {
            lblTime.textColor = .white
            lblTemp.textColor = .white
            lbldayInTheWeek.textColor = .white
        }
        else {
            lblTime.textColor = .black
            lblTemp.textColor = .black
            lbldayInTheWeek.textColor = .black
        }
        
        image.image = viewModel.image
        image.tintColor = viewModel.imageColor
    }

}
