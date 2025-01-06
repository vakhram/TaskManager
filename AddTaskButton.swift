//
//  File.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import SwiftUI


struct TasksButton: View {
    enum ButtonType {
        case edit
        case add
    }
    
    @ObservedObject var viewModel: TaskManagerViewModel
    var type: ButtonType
    
    var body: some View {
        HStack {
            switch type {
            case .edit:
                NavigationLink(destination: AddTaskView(viewModel: viewModel)) {
                        Text("+ New Task")
                    }
                    .padding(15)
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .foregroundStyle(.white)
                    .clipShape(.buttonBorder)
            case .add:
                NavigationLink(destination: AddTaskView(viewModel: viewModel)) {
                        Text("+ New Task")
                    }
                    .padding(15)
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .foregroundStyle(.white)
                    .clipShape(.buttonBorder)
            }
        }
        .padding(.top)
    }
}
