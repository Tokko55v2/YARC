//
//  NavigationView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 26/01/2021.
//

import Rswift
import SwiftUI
import UIKit

// https://stackoverflow.com/questions/56923397/how-change-background-color-if-using-navigationview-in-swiftui
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let standard = UINavigationBarAppearance()
        standard.backgroundColor = R.color.headerColor()
        navigationBar.tintColor = R.color.navigationColor()
        standard.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = standard
    }
}
