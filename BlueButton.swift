//
//  BlueButton.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
    }
}
