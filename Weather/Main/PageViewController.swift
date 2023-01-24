//
//  PageViewController.swift
//  Weather
//
//  Created by Roma Bogatchuk on 23.12.2022.
//

import UIKit


protocol PageViewControllerDelagate{
    func changedPage(index:Int)
}

class PageViewController: UIPageViewController {
    
    
    var index = 0
    
    private lazy var pages: [UIViewController] = {
        return [
            UIStoryboard(name: "ToDay", bundle: nil).instantiateViewController(withIdentifier: "ToDayViewController"),
            UIStoryboard(name: "Tomorrow", bundle: nil).instantiateViewController(withIdentifier: "TomorrowViewController"),
            UIStoryboard(name: "FiveDays", bundle: nil).instantiateViewController(withIdentifier: "FiveDaysViewController")
//            self.getViewController(withIdentifier: "ToDayViewController"),
//            self.getViewController(withIdentifier: "TomorrowViewController"),
//            self.getViewController(withIdentifier: "FiveDaysViewController")
        ]
    }()
    
    var delegatePage:PageViewControllerDelagate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let mainVC = pages.first {
            setViewControllers([mainVC], direction: .forward, animated: true)
            
        }
        
        
    }
    
//    private func getViewController(withIdentifier identifier: String) -> UIViewController{
//        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
//    }
    
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

extension PageViewController: UIPageViewControllerDelegate{
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

extension PageViewController: UIPageViewControllerDataSource{
    
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




