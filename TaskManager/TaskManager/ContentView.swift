//
//  ContentView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 09/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                TaskListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Tasks")
                    }

                DashboardView()
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
