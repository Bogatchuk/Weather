//
//  PageViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.12.2022.
//

import UIKit


protocol MainPageViewControllerDelagate{
    func changedPage(index:Int)
}

class MainPageViewController: UIPageViewController {
    
    
    var index = 0
    
    private lazy var pages: [UIViewController] = {
        return [
            ToDayViewController.instantiate(name: EnumScreens.toDayView.rawValue),
            TomorrowViewController.instantiate(name: EnumScreens.tomorrowView.rawValue),
            FiveDaysViewController.instantiate(name: EnumScreens.fiveDaysView.rawValue)

        ]
    }()
    
    var delegatePage:MainPageViewControllerDelagate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let mainVC = pages.first {
            setViewControllers([mainVC], direction: .forward, animated: true)
            
        }
        
        
    }
    
    
    func scrollToViewController(index newIndex: Int){
        if let firstViewController = viewControllers?.first,
           let currentIndex = pages.firstIndex(of: firstViewController){
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nexViewController = pages[newIndex]
            scrollToViewController(viewController: nexViewController, direction: direction)
        }
    }
    
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in})
    }
}

extension MainPageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = pages.firstIndex(of: currentViewController) {
                delegatePage?.changedPage(index: index)
            }
        }
    }
}

extension MainPageViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0          else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil   }
        return pages[nextIndex]
        
    }
    
    
}




