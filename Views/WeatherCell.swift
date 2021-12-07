//
//  ForecastCell.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 5.12.21..
//

import UIKit

class WeatherCell: UICollectionViewCell {

    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblTemp: UILabel!    
    @IBOutlet var image: UIImageView!
    
    static let identifier = "WeatherCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCell", bundle: nil)
    }
    
    func configure(with viewModel: WeatherCellViewModel) {
        lblTime.text = viewModel.time
        lblTemp.text = "\(viewModel.temperature)"
        
        if viewModel.isDay {
            lblTime.textColor = .white
            lblTemp.textColor = .white
        }
        else {
            lblTime.textColor = .black
            lblTemp.textColor = .black
        }
        
        image.image = viewModel.image
        image.tintColor = viewModel.imageColor

    }


}
