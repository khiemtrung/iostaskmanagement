//
//  ContentView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 09/08/2024.
//
import UIKit
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
                .onAppear {
                    triggerHapticFeedback()
                }
            
            DashboardView(taskViewModel: taskViewModel)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Dashboard")
                }
                .onAppear {
                    triggerHapticFeedback()
                }
            
            CalendarView(taskViewModel: taskViewModel, selectedDate: $selectedDate)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .onAppear {
                    triggerHapticFeedback()
                }
        }
        
    }
    
    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    ContentView()
}
