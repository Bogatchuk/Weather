//
//  MainViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.12.2022.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {

    @IBOutlet weak var pageSegmentedControl: UISegmentedControl!
    private var pageViewController: MainPageViewController?
  
    weak var coordinator: AppCoordinator?
    
    var viewModel: MainViewModelProtocol!{
        didSet{
            title = viewModel.cityName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
  
    }
    
    
    
    @IBAction func showSearchView(_ sender: Any) {
        coordinator?.push(name: .searchView)
    }
    
    @IBAction func changedSelectedPage(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        pageViewController?.scrollToViewController(index: index)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? MainPageViewController {
            self.pageViewController = pageViewController
            self.pageViewController?.delegatePage = self
        }
    }
}

extension MainViewController: MainPageViewControllerDelagate {
 
    func changedPage(index: Int) {
        pageSegmentedControl.selectedSegmentIndex = index
    }
    
}


