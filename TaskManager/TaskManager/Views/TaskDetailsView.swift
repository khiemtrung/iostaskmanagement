//
//  TaskDetailsView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct TaskDetailsView: View {
    var task: Task

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(task.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description:")
                        .font(.headline)
                    
                    Text(task.taskDescription)
                        .padding(.bottom)

                    Text("Due Date: \(task.dueDate, style: .date)")
                    Text("Priority: \(task.priority)")
                    Text("Category: \(task.category)")
                    Text("Completed: \(task.isCompleted ? "Yes" : "No")")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10) // Optional: Keep padding inside the VStack
                .background(Color(UIColor.systemGray5)) // Light background for details
                .cornerRadius(10)

                
                HStack {
                    Button(action: {
                        // Mark as complete logic
                    }) {
                        Text("Mark as Complete")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    Button(action: {
                        // Edit task logic
                    }) {
                        Text("Edit Task")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    // Delete task logic
                }) {
                    Text("Delete Task")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal) // Apply padding to the parent VStack to match the screen edges
            .padding(.vertical) // Optional: Add some vertical padding for aesthetics
        }
        .navigationBarTitle("Task Details", displayMode: .inline)
    }
}

#Preview {
    let sampleTask = Task()
    sampleTask.name = "Sample Task"
    sampleTask.taskDescription = "This is a sample task description."
    sampleTask.dueDate = Date()
    sampleTask.priority = TaskPriority.high.rawValue
    sampleTask.category = TaskCategory.work.rawValue
    sampleTask.isCompleted = false
    
    return TaskDetailsView(task: sampleTask)
}
