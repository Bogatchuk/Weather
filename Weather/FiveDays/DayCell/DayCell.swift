//
//  TableViewCell.swift
//  Weather
//
//  Created by Roma Bogatchuk on 28.12.2022.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var viewModel: DayCellViewModelProtocol!{
        didSet{
            dayLabel.text = viewModel.date
            minTempLabel.text = viewModel.minTemp
            maxTempLabel.text = viewModel.maxTemp
            descriptionLabel.text = viewModel.description
            iconImage.image = UIImage(named: viewModel.imageName)
        }
    }
    
    static let identifire = "dayCell"
    static func nib () -> UINib {
        return UINib(nibName: "DayCell", bundle: nil)
    }
    
}

