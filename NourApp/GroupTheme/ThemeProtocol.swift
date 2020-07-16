//
//  ThemeProtocol.swift
//  NourApp
//
//  Created by Abdelrahman Samir on 6/25/20.
//  Copyright © 2020 Abdelrahman Samir. All rights reserved.
//

import Foundation
import UIKit


protocol ThemeProtocol {
    var accent : UIColor { get }
    var background : UIColor { get }
    var tint : UIColor { get }
}

class LightTheme: ThemeProtocol {
    var accent: UIColor = UIColor(named: "Accent")!
    var background: UIColor = UIColor(named: "Background")!
    var tint: UIColor = UIColor(named: "Tint")!
}

class DarkTheme: ThemeProtocol {
    var accent: UIColor = UIColor(named: "Background")!
    var background: UIColor = UIColor(named: "Accent")!
    var tint: UIColor = UIColor(named: "Tint")!
}

class Theme {
    static var currentTheme : ThemeProtocol = LightTheme()
}
