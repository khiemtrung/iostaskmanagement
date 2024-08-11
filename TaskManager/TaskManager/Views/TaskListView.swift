//
//  TaskListView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var selectedCategory: String = "All" // Default to "All"
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTasks()) { task in
                    // Use a constant to hold the index
                    
                    NavigationLink(destination: TaskDetailsView(taskViewModel: taskViewModel, task: task)) {
                        TaskRowView(taskViewModel: taskViewModel, task: task)
                    }
                }
                .onDelete(perform: deleteTasks)
                .onMove(perform: moveTask)
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(
                //leading: categoryButton,
                leading: EditButton(),
                trailing: HStack {
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
    
    private var categoryButton: some View {
        Menu {
            Button(action: { selectCategory("All") }) {
                Text("All")
            }
            Button(action: { selectCategory("Work") }) {
                Text("Work")
            }
            Button(action: { selectCategory("Personal") }) {
                Text("Personal")
            }
            Button(action: { selectCategory("Others") }) {
                Text("Others")
            }
        } label: {
            Label("Category: \(selectedCategory)", systemImage: "line.horizontal.3.decrease.circle")
        }
    }
    private func selectCategory(_ category: String) {
        selectedCategory = category
    }
    // Function to filter tasks based on the selected category
    private func filteredTasks() -> [Task] {
        taskViewModel.tasks.filter { task in
            (selectedCategory == "All" || task.category == selectedCategory) && !task.isCompleted
        }
    }
    
    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}

struct TaskRowView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var isExpanded: Bool = false
    @State private var newSubtaskName: String = ""
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.name)
                        .font(.headline)
                    Text(task.taskDescription)
                        .font(.subheadline)
                    Text(task.dueDate.formatted(.dateTime.month().day().hour().minute()))
                        .font(.subheadline)
                    HStack {
                        categoryIndicator(for: TaskCategory(rawValue: task.category) ?? .work)
                        Text(task.category)
                            .font(.subheadline)
                    }
                    Text("\(task.order)")
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
            
           
            // Button to expand/collapse subtasks
            if !task.subtasks.isEmpty {
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Text(isExpanded ? "Hide Subtasks" : "Show Subtasks")
                        .foregroundColor(.blue)
                        .padding() // Add padding to make it clear it's a separate button
                        .frame(maxWidth: .infinity, alignment: .leading) // Align it to the left
                }
                .frame(height: 15)
                .buttonStyle(PlainButtonStyle()) // Make the button style plain to avoid navigation interference
                
                if isExpanded {
                    VStack(alignment: .leading) {
                        ForEach(task.subtasks, id: \.id) { subtask in
                            HStack {
                                Text(subtask.name)
                                    .font(.subheadline)
                                Spacer()
                                // Checkmark for completion
                                Button(action: {
                                    // Handle completion status
                                    subtask.isCompleted.toggle()
                                }) {
                                    Image(systemName: subtask.isCompleted ? "checkmark.circle.fill" : "circle")
                                }
                            }
                        }
                        
                    }
                    .padding(.leading, 16)
                }
            }
            
            
        }
        .padding(.horizontal)
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
}
