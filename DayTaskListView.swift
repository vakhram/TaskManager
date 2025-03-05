//
//  DayTaskListView.swift
//  TaskManager
//
//  Created by vakhram on 02.01.2025.
//

import SwiftUI

struct DayTaskListView: View {
    
    enum TaskType {
        case uncompleted
        case completed
    }
    
    @ObservedObject var viewModel: TaskManagerViewModel
    @State var isExpanded: Bool = false
    let type: TaskType
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        switch type {
        case .uncompleted:
            makeDayTaskListView(type: .uncompleted)
        case .completed:
            makeDayTaskListView(type: .completed)
        }
    }
    
    @ViewBuilder
    private func makeDayTaskListView(type: TaskType) -> some View {
        DisclosureGroup(type == .uncompleted ? "Uncompleted Tasks" : "Completed Tasks", isExpanded: $isExpanded) {
            ForEach(viewModel.sortedTasks, id: \.0) { group in
                if let date = group.0 {
                    let groupedTasks = group.1.filter({ type == .uncompleted ? !$0.isCompleted : $0.isCompleted })
                    DisclosureGroup("\(DateFormatter.createdateFormatter(with: .date).string(from: date))") {
                        if groupedTasks.count == 0 {
                            Text(type == .uncompleted ? "All tasks completed" : "Nothing Completed")
                        } else {
                            ForEach(groupedTasks, id: \.id) { task in
                                TaskView(viewModel: viewModel, task: task)
                            }
                        }
                    }
                }
            }        }
        .padding(20)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}
