//
//  DashboardView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var taskViewModel: TaskViewModel

    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()

            HStack {
                Spacer()
                VStack {
                    Text("Completed Tasks")
                        .font(.headline)
                    Text("\(taskViewModel.completedTasks().count)")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.green) // Background color for completed tasks
                .cornerRadius(10)

                VStack {
                    Text("Pending Tasks")
                        .font(.headline)
                    Text("\(taskViewModel.incompleteTasks().count)")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.orange) // Background color for pending tasks
                .cornerRadius(10)
                Spacer()
            }
            
            VStack {
                Text("Deleted Tasks")
                    .font(.headline)
                Text("\(taskViewModel.incompleteTasks().count)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.red) // Background color for pending tasks
            .cornerRadius(10)
            .frame(maxWidth: .infinity)

            Spacer()
        }
        .background(Color(UIColor.systemGray6)) // Light gray background for the dashboard
        .cornerRadius(15)
        .frame(maxWidth: .infinity)
        .padding()

    }
}

#Preview {
    DashboardView(taskViewModel: TaskViewModel())
}
