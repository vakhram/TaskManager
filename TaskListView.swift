//
//  TaskListView.swift
//  TaskManager
//
//  Created by Guest Acc on 01.01.2025.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    
    enum ListType {
        case uncompleted
        case completed
        case all
    }
    
    @State var isExpanded: Bool = false
    @ObservedObject var viewModel: TaskManagerViewModel
    @Environment(\.colorScheme) var colorScheme
    let type: ListType
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded, content: {
            switch type {
            case .uncompleted:
                ForEach(viewModel.tasks.filter({ !$0.isCompleted }), id: \.id) { task in
                    TaskView(viewModel: viewModel, task: task)
                    Divider()
                }
            case .completed:
                ForEach(viewModel.tasks.filter({ $0.isCompleted }), id: \.id) { task in
                    TaskView(viewModel: viewModel, task: task)
                    Divider()
                }
            case .all:
                ForEach(viewModel.tasks, id: \.id) { task in
                    TaskView(viewModel: viewModel, task: task)
                    Divider()
                }
            }
            
        }, label: {
            switch type {
            case .uncompleted:
                Text("Uncompleted Tasks")
            case .completed:
                Text("Completed Tasks")
            case .all:
                Text("All Tasks")
            }
        })
        
        .padding(20)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

#Preview {
    TaskListView(viewModel: TaskManagerViewModel(context: PersistentController.shared.container.viewContext), type: .all)
}
