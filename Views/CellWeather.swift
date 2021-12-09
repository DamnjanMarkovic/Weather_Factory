//
//  ForecastCell.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 5.12.21..
//

import UIKit

class CellWeather: UICollectionViewCell {

    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblTemp: UILabel!    
    @IBOutlet var image: UIImageView!
    
    static let identifier = "CellWeather"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "CellWeather", bundle: nil)
    }
    
    func configure(with viewModel: CellViewModel) {
        lblTime.text = viewModel.time
        lblTemp.text = "\(viewModel.temperature)"

        lblTime.textColor = .white
        lblTemp.textColor = .white
        
        
            
        image.image = viewModel.image
        
        image.tintColor = UIColor.white

    }


}
