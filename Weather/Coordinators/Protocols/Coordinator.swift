//
//  Coordinator.swift
//  Weather
//
//  Created by Roma Bogatchuk on 22.01.2023.
//

import UIKit

protocol Coordinator{
    var navigationController: UINavigationController { get set }
    func start()
}
