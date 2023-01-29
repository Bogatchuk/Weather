//
//  UIAlertController+Extensions.swift
//  Weather
//
//  Created by Roma Bogatchuk on 29.01.2023.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, withMessage message:String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            completion?()
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
