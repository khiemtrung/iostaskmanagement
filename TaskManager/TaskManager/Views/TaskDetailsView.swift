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
        VStack(alignment: .leading, spacing: 16) {
            Text(task.name)
                            .font(.largeTitle)
                        Text("Description: \(task.taskDescription)")
                        Text("Due Date: \(task.dueDate, style: .date)")
                        Text("Priority: \(task.priority)")
                        Text("Category: \(task.category)")
                        Text("Completed: \(task.isCompleted ? "Yes" : "No")")
                        Spacer()

            HStack {
                Button(action: {
                    // Mark as complete logic
                }) {
                    Text("Mark as Complete")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }

                Button(action: {
                    // Edit task logic
                }) {
                    Text("Edit Task")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }

            Button(action: {
                // Delete task logic
            }) {
                Text("Delete Task")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationBarTitle("Task Details", displayMode: .inline)
    }
}

