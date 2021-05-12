//
//  AsyncImageView.swift
//  YARC
//
//  Created by Michael Kroneder on 20/04/2021.
//

import SwiftUI

struct AsyncImageView<Placholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placholder

    init(url: String, @ViewBuilder placeholder: () -> Placholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .background(Color(R.color.backgroundColorOne()!))
                    .clipShape(Capsule())
            } else {
                placeholder
                    .frame(width: 45, height: 45)
                    .background(Color(R.color.backgroundColorOne()!))
                    .clipShape(Capsule())
            }
        }
    }
}
