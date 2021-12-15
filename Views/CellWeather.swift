//
//  CellWeather.swift
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
    
    func configure(with viewModel: CellData) {
        lblTime.text = viewModel.time
        lblTemp.text = "\(viewModel.temperature)"
        lblTime.textColor = .white
        lblTemp.textColor = .white
        image.image = viewModel.image
    }


}
