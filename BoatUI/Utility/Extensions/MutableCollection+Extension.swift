//
//  MutableCollection + Extension.swift
//  BoatUI
//
//  Created by NeoSOFT on 28/11/23.
//


import Foundation
import UIKit

extension MutableCollection {
    
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue,indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}





