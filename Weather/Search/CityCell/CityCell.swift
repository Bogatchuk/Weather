//
//  CityCell.swift
//  Weather
//
//  Created by Roma Bogatchuk on 09.01.2023.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    static let identifire = "cityCell"
    static func nib () -> UINib {
        return UINib(nibName: "CityCell", bundle: nil)
    }
    
    var viewModel: CityCellViewModelProtocol!{
        didSet{
            cityLabel.text = viewModel.city
            regionLabel.text = viewModel.region
            countryLabel.text = viewModel.country
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }

}
