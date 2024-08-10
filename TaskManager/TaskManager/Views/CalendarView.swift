//
//  CalendarView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 10/08/2024.
//

import SwiftUI
import CalendarKit
import UIKit
import RealmSwift

struct CalendarView: UIViewControllerRepresentable {
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var selectedDate: Date

    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarVC = CalendarViewController()
        calendarVC.taskViewModel = taskViewModel
        calendarVC.selectedDate = selectedDate
        return calendarVC
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        uiViewController.selectedDate = selectedDate
        uiViewController.reloadTasks()
    }
}

