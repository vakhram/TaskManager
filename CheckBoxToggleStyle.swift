//
//  CheckBoxToggleStyle.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct CheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                            .stroke(lineWidth: 2)
                            .frame(width: 25, height: 25)
                            .cornerRadius(5.0)
                            .overlay {
                                Image(systemName: configuration.isOn ? "checkmark" : "")
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    configuration.isOn.toggle()
                                }
                            }
            configuration.label
        }
    }
}
