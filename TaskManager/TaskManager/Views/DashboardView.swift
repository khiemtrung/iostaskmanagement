//
//  DashboardView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Dashboard")
                .font(.largeTitle)
                .bold()

            HStack {
                VStack {
                    Text("Completed Tasks")
                    // Placeholder for task stats, replace with actual data
                    Text("10")
                        .font(.title)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)

                VStack {
                    Text("Pending Tasks")
                    Text("5")
                        .font(.title)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }
}

