//
//  YarcDivider.swift
//  YARC
//
//  Created by Michael Kroneder on 25/02/2021.
//

import SwiftUI

struct YARCDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(height: 1)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
