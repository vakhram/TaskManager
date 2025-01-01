import SwiftUI
import CoreData

struct AddTaskView: View {
    
    @ObservedObject var viewModel: TaskManagerViewModel
    
    @State var taskNameString: String = ""
    @State var taskDescriprion: String = ""
    @State var taskDeadlineDay: Date = .now
    @State var taskDeadlineTime: Date = .now
    
    var body: some View {
        VStack {
            Text("Add a new Task")
                .font(.system(size: 27, weight: .bold))
                .padding(25)
            Form {
                TextField(text: $taskNameString) {
                    Text("Name:")
                }
                TextField(text: $taskDescriprion) {
                    Text("Description")
                }
                DatePicker(selection: $taskDeadlineDay) {
                    Text("Deadline Day")
                }
                DatePicker(selection: $taskDeadlineTime) {
                    Text("Deadline Time")
                }
            }
            Button ("Create Task") {
                createTask(taskName: taskNameString, deadlineDay: taskDeadlineDay, deadlineTime: taskDeadlineDay, context: viewModel.context)
            } .buttonStyle(BlueButton())
        }
    }
    
    func createTask(taskName: String?, deadlineDay: Date?, deadlineTime: Date?, context: NSManagedObjectContext) {
        let task = TaskClass(context: context)
        task.taskName = taskName ?? "🥵"
        task.deadlineDay = deadlineDay
        task.deadlineTime = deadlineTime
        task.isCompleted = false
        task.id = UUID()
        
        do {
            try context.save()
            print("success")
        } catch {
            print("Failed to save task: \(error.localizedDescription)")
        }
    }
 }

#Preview {
    AddTaskView(viewModel: TaskManagerViewModel(context: PersistentController.shared.container.viewContext))
}
