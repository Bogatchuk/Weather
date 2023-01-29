//
//  UIAlertController+Extensions.swift
//  Weather
//
//  Created by Roma Bogatchuk on 29.01.2023.
//

import UIKit

class SharedClass: NSObject {//This is shared class
static let sharedInstance = SharedClass()

    //Show alert
    func alert(view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }

    private override init() {
    }
    
    func alertWindow(title: String, message: String) {
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1

            let alert2 = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction2 = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert2.addAction(defaultAction2)

            alertWindow.makeKeyAndVisible()

            alertWindow.rootViewController?.present(alert2, animated: true, completion: nil)

    }
}
