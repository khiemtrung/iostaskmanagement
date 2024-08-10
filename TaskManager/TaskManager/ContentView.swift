//
//  ContentView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 09/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskViewModel = TaskViewModel()
    var body: some View {
            TabView {
                TaskListView(taskViewModel: taskViewModel)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Tasks")
                    }

                DashboardView(taskViewModel: taskViewModel)
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Dashboard")
                    }
            }
        }
}

#Preview {
    ContentView()
}
