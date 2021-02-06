//
//  ContentView.swift
//  redditClient
//
//  Created by Michael Kroneder on 22/01/2021.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var userDefaults = UserDefaultsService()
    var body: some View {
        if userDefaults.getEntropy() {
            MainView()
        } else {
            Entropy()
                .onAppear {
                    setInitialProfile()
                }
        }
    }

    func setInitialProfile() {
        userDefaults.initialProfileStatus.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
