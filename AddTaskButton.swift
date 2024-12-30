//
//  File.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI

struct AddTaskButton: View {
    @ObservedObject var viewModel: TaskManagerViewModel
    
    var body: some View {
        HStack {
            NavigationLink(destination: AddTaskView(viewModel: viewModel)) {
                    Text("+ New Task")
                }
                .padding(15)
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
        }
        .padding(.top)
    }
}
