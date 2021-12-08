//
//  WeatherCell.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//


import UIKit

class CellForecast: UICollectionViewCell {

    @IBOutlet var lblTime: UILabel!    
    @IBOutlet var lblTemp: UILabel!    
    @IBOutlet var lbldayInTheWeek: UILabel!    
    @IBOutlet var image: UIImageView!
    
    static let identifier = "CellForecast"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "CellForecast", bundle: nil)
    }
    
    func configure(with viewModel: CellViewModel) {
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
