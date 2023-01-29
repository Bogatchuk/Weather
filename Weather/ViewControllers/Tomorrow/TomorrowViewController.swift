//
//  TomorrowViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.12.2022.
//

import UIKit

class TomorrowViewController: UIViewController, Storyboarded {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var hourCollectionView: UICollectionView!
    
    var viewModel: TomorrowViewModelProtocol!{
        didSet{
            dateLabel.text = viewModel.date
            minTempLabel.text = viewModel.minTemp
            maxTempLabel.text = viewModel.maxTemp
            descriptionLabel.text = viewModel.description
            weatherIcon.image = UIImage(named: viewModel.imageName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hourCollectionView?.register(HourCell.nib(), forCellWithReuseIdentifier: HourCell.identifier)
        hourCollectionView.showsHorizontalScrollIndicator = false
        
        viewModel = TomorrowViewModel()
    }
    
}


extension TomorrowViewController: UICollectionViewDelegate, UICollectionViewDataSource{
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as! HourCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
}




