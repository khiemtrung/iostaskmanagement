//
//  DashboardView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI
import SwiftUICharts

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
                
                Spacer()
                
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
                Text("\(taskViewModel.deletedeTasks().count)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.red) // Background color for pending tasks
            .cornerRadius(10)
            .frame(maxWidth: .infinity)

            Spacer()
            
            // Add PieChart here
                        PieChart(chartData: makePieChartData())
                            .touchOverlay(chartData: makePieChartData())
                            .headerBox(chartData: makePieChartData())
                            .legends(chartData: makePieChartData(), columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                            .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                            .padding(.horizontal)

                        Spacer()
            
        }
        .background(Color(UIColor.systemGray6)) // Light gray background for the dashboard
        .cornerRadius(15)
        .frame(maxWidth: .infinity)
        .padding()

    }
    
    func makePieChartData() -> PieChartData {
            let data = PieDataSet(
                dataPoints: [
                    PieChartDataPoint(value: Double(taskViewModel.completedTasks().count), description: "Completed", colour: .green, label: .icon(systemName: "checkmark.circle.fill", colour: .white, size: 30)),
                    PieChartDataPoint(value: Double(taskViewModel.incompleteTasks().count), description: "Pending", colour: .orange, label: .icon(systemName: "exclamationmark.circle.fill", colour: .white, size: 30)),
                    PieChartDataPoint(value: Double(taskViewModel.deletedeTasks().count), description: "Deleted", colour: .red, label: .icon(systemName: "trash.fill", colour: .white, size: 30))
                ],
                legendTitle: "Tasks"
            )
            
            return PieChartData(
                dataSets: data,
                metadata: ChartMetadata(title: "Task Overview", subtitle: "Summary of all tasks"),
                chartStyle: PieChartStyle(infoBoxPlacement: .header)
            )
        }
}

#Preview {
    DashboardView(taskViewModel: TaskViewModel())
}
