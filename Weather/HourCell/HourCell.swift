//
//  HourCell.swift
//  Weather
//
//  Created by Roma Bogatchuk on 20.12.2022.
//

import UIKit

class HourCell: UICollectionViewCell {
    

    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var viewModel: HourCellViewModelProtocol!{
        didSet{
            tempLabel.text = viewModel.temp
            icon.image = UIImage(named: viewModel.iconName)
            timeLabel.text = viewModel.time
        }
    }
    
    static let identifier = "hourCell"
    static func nib () -> UINib {
        return UINib(nibName: "HourCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }

}
