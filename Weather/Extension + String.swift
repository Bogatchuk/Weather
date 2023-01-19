//
//  Extension + String.swift
//  Weather
//
//  Created by Roma Bogatchuk on 18.01.2023.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
