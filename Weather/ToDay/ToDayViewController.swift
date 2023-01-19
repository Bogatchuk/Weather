//
//  ToDayViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 17.12.2022.
//

import UIKit

class ToDayViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hourCollectionView: UICollectionView!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var viewModel: ToDayViewModelProtocol!{
        didSet{
            dateLabel.text = viewModel.date
            feelsLikeLabel.text = viewModel.feelsLike
            minTempLabel.text = viewModel.minTemp
            maxTempLabel.text = viewModel.maxTemp
            temperatureLabel.text = viewModel.temperature
            descriptionLabel.text = viewModel.description
            weatherIcon.image = UIImage(named: viewModel.imageName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourCollectionView?.register(HourCell.nib(), forCellWithReuseIdentifier: HourCell.identifier)
        hourCollectionView.showsHorizontalScrollIndicator = false
        
        viewModel = ToDayViewModel()
    }
}


extension ToDayViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as! HourCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
}




