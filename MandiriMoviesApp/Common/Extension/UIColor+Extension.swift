//
//  UIColor+Extension.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 25/12/22.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    static let appBlue = UIColor(hex: 0x142B58)
    static let appYellow = UIColor(hex: 0xF7D24B)
}
