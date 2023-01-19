//
//  MainViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.12.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var pageSegmentedControl: UISegmentedControl!
    private var pageViewController: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let weather = StorageManager.shared.getForecastWeather()
        title = weather!.city!.name
  
    }
    

    @IBAction func changedSelectedPage(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        pageViewController?.scrollToViewController(index: index)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            self.pageViewController = pageViewController
            self.pageViewController?.delegatePage = self
        }
    }
}

extension MainViewController: PageViewControllerDelagate {
 
    func changedPage(index: Int) {
        pageSegmentedControl.selectedSegmentIndex = index
    }
    
}


