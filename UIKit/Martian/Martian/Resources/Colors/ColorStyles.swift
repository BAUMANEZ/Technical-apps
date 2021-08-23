//
//  ColorStyles.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

//MARK: - Function for dark mode adaptivity
extension UIColor {
    static func colorForTheme(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor.init { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}

//MARK: - Text
extension UIColor {
    static var primary: UIColor {
        return colorForTheme(light: UIColor("#2A2C3D"), dark: UIColor("000"))
    }
    
    static var secondary: UIColor {
        return colorForTheme(light: UIColor("#B8C2CC"), dark: UIColor("000"))
    }
    
    static var selected: UIColor {
        return colorForTheme(light: UIColor("#6D00FF"), dark: UIColor("000"))
    }
    
    static var unselected: UIColor {
        return colorForTheme(light: UIColor("#2A2C3D"), dark: UIColor("000"))
    }
}

//MARK: - Background
extension UIColor {
    // ....
}
