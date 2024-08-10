//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 09/08/2024.
//

import SwiftUI
import RealmSwift
import UserNotifications

@main
struct TaskManagerApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        // Configure Realm with migration
        let config = Realm.Configuration(
            schemaVersion: 3, // Increment this version number whenever you change the schema
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
                    // Perform the migration: add 'order' property with a default value
                    migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                        newObject?["order"] = 0 // Default value for the new property
                        newObject?["reminderDate"] = nil
                    }
                }
            }
        )
        
        // Set the default Realm configuration
        Realm.Configuration.defaultConfiguration = config
        
        do {
            _ = try Realm() // This will trigger the migration if needed
        } catch {
            print("Error initializing Realm: \(error)")
        }
        
        requestNotificationPermissions()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func requestNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notifications permissions: \(error)")
            }
            print("Notification permission granted: \(granted)")
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
