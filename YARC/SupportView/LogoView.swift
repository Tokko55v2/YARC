//
//  LogoView.swift
//  RedditClient
//
//  Created by Michael Kroneder on 03/02/2021.
//

import SwiftUI
struct LogoView: View {
    var body: some View {
        guard let img = R.image.logo() else {
            fatalError("Unable to load image")
        }

        return Image(uiImage: img)
            .resizable()
            .frame(width: 250, height: 250)
            .padding(.bottom, 50)
    }
}
