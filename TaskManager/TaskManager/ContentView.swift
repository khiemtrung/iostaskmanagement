//
//  ContentView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 09/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskViewModel = TaskViewModel()
    @State private var selectedDate: Date = Date()
    
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
            
            CalendarView(taskViewModel: taskViewModel, selectedDate: $selectedDate)
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("Calendar")
                            }
        }
    }
}

#Preview {
    ContentView()
}
