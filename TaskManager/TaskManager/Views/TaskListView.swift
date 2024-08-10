//
//  TaskListView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskViewModel.tasks) { task in
                    // Use a constant to hold the index
                    
                    NavigationLink(destination: TaskDetailsView(taskViewModel: taskViewModel, task: task)) {
                        TaskRowView(task: task)
                    }
                }
                .onDelete(perform: deleteTasks)
                .onMove(perform: moveTask)
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(trailing: HStack {
                EditButton()
                addButton
            })
        }
        .onAppear {
            taskViewModel.fetchTasks() // Call fetchTasks() when the view appears
        }
        
    }
    
    private var addButton: some View {
        NavigationLink(destination: AddEditTaskView(taskViewModel: taskViewModel)) {
            Image(systemName: "plus")
        }
    }
    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let taskToDelete = taskViewModel.tasks[index]
            taskViewModel.deleteTask(taskToDelete)
        }
    }
    
    private func moveTask(from source: IndexSet, to destination: Int) {
        taskViewModel.moveTask(from: source, to: destination) // Call the moveTask function in the ViewModel
    }
}

struct TaskRowView: View {
    var task: Task
    
    var body: some View {
        HStack {
            
            
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text(task.taskDescription)
                    .font(.subheadline)
                Text(task.dueDate, style: .date)
                    .font(.subheadline)
            }
            Spacer()
            
            // Priority Icon
            priorityIcon(for: TaskPriority(rawValue: task.priority) ?? .low)
                .resizable()
                .frame(width: 24, height: 24) // Adjust the size as needed
                .foregroundColor(priorityColor(for: TaskPriority(rawValue: task.priority) ?? .low))
        }
        .padding(.vertical, 8)
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
    
    private func priorityColor(for priority: TaskPriority) -> Color {
        switch priority {
        case .high: return .red
        case .medium: return .yellow
        case .low: return .green
        }
    }
}
