//
//  NavigationView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 26/01/2021.
//

import Rswift
import SwiftUI
import UIKit

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)

                NavigationLink(destination: view
                    .navigationBarTitle("")
                    .navigationBarHidden(false),
                    isActive: binding) {
                        EmptyView()
                }
            }
        }
    }
}

// https://stackoverflow.com/questions/56923397/how-change-background-color-if-using-navigationview-in-swiftui
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let standard = UINavigationBarAppearance()
        standard.backgroundColor = R.color.headerColor()
        navigationBar.tintColor = UIColor.white

        navigationBar.standardAppearance = standard
    }
}
