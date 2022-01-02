//
//  CustomButtonView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 03/02/2021.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 250, height: 15, alignment: .center)
            .foregroundColor(.white)
            .padding()
            .background(configuration.isPressed ?
                Color(R.color.secondButtonColor()!) :
                Color(R.color.buttonColor()!))
            .cornerRadius(8)
    }
}
