//
//  TaskDetailsView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel
    var task: Task
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(task.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                VStack(alignment: .trailing) {
                    Text(task.taskDescription)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                }
                .padding(0)
                .background(Color(UIColor.systemGray5)) // Light background for details
                .cornerRadius(12)
                .shadow(radius: 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Due Date: \(task.dueDate, style: .date)")
                }
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .shadow(radius: 4)
                
                HStack {
                    HStack {
                        // Priority Icon
                        priorityIcon(for: TaskPriority(rawValue: task.priority) ?? .low)
                            .resizable()
                            .frame(width: 20, height: 20) // Adjust the size as needed
                            .foregroundColor(priorityColor(for: TaskPriority(rawValue: task.priority) ?? .low))
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Priority: \(task.priority)")
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                    
                    HStack{
                        categoryIndicator(for: TaskCategory(rawValue: task.category) ?? .work)
                        Text("Category: \(task.category)")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                }
                
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Completed: \(task.isCompleted ? "Yes" : "No")")
                }
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .shadow(radius: 4)
                
                HStack {
                    NavigationLink(destination: AddEditTaskView(taskViewModel: taskViewModel, task: task)) {
                        Text("Edit Task")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    }
                    
                    Button(action: {
                        markAsComplete()
                    }) {
                        Text("Mark as Complete")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    }
                }
                
                
                Button(action: {
                    deleteTask()
                }) {
                    Text("Delete Task")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
 
            }
            .padding(.horizontal)
            .padding(.vertical, 20) // Add some vertical padding for aesthetics
        }
        .navigationBarTitle("Task Details", displayMode: .inline)
    }
    
    private func markAsComplete() {
        taskViewModel.updateTaskCompletionStatus(task: task, isCompleted: true)
    }
    
    private func deleteTask() {
        taskViewModel.deleteTask(task)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func categoryIndicator(for category: TaskCategory) -> some View {
        Circle()
            .fill(categoryColor(for: category))
            .frame(width: 12, height: 12) // Adjust the size as needed
            .padding(.leading, 4) // Add space between the task name and category indicator
    }
    private func categoryColor(for category: TaskCategory) -> Color {
        switch category {
        case .work:
            return .blue
        case .personal:
            return .orange
        case .others:
            return .purple
        }
    }
    private func priorityColor(for priority: TaskPriority) -> Color {
        switch priority {
        case .high: return .red
        case .medium: return .yellow
        case .low: return .green
        }
    }
    private func priorityIcon(for priority: TaskPriority) -> Image {
        switch priority {
        case .high:
            return Image(systemName: "exclamationmark.triangle.fill") // Example icon for high priority
        case .medium:
            return Image(systemName: "arrowtriangle.up.fill") // Example icon for medium priority
        case .low:
            return Image(systemName: "circle.fill") // Example icon for low priority
        }
    }
}

#Preview {
    let sampleTask = Task()
    sampleTask.name = "Sample Task long long long Sample Task long long long Sample Task long long long "
    sampleTask.taskDescription = "This is a sample task description. This is a sample task description. This is a sample task description. This is a sample task description. This is a sample task description. This is a sample task description."
    sampleTask.dueDate = Date()
    sampleTask.priority = TaskPriority.high.rawValue
    sampleTask.category = TaskCategory.work.rawValue
    sampleTask.isCompleted = false
    sampleTask.isDeleted = false
    sampleTask.order = 0
    
    return TaskDetailsView(taskViewModel: TaskViewModel(), task: sampleTask)
}
